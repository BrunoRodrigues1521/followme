var fs = require('fs');
var path = require('path')
const fetch = require('node-fetch');
const {isValid} = require("../helpers/helpers");
const {reset} = require("../data/userData");
const userData = require('../data/userData');

class RouteService{

    constructor(routeData) {
        this.routeData= routeData;
    }

    async insert(route){
        const imagesarray = new Array();
        //const reviewimagesarray = new Array();
        const waypointsArray= new Array();
        //route.reviewImages.forEach(passToReviewImageAndSave)
        route.images.forEach(passToImageAndSave);
        route.waypoints.forEach(passToStringWaypoints);

        function passToImageAndSave(image){
            let raw = Buffer.from(image, 'base64');
            let imagePath = Date.now().toString()+Math.floor(Math.random()*100);
            let base= __dirname;
            fs.writeFile(path.join(base,'..','..','images',imagePath+'.png'), raw, (err)=>{
                if(err)console.log(err.message); return {error:"Image Error"};
                console.log("File Saved")
            })
            imagesarray.push(process.env.ROUTES_PICS_BASE_URL+imagePath+'.png');
        }
        /*function passToReviewImageAndSave(image){
            let raw = Buffer.from(image, 'base64');
            let imagePath = Date.now().toString()+Math.floor(Math.random()*100);
            reviewimagesarray.push(imagePath+'.png');
            let base= __dirname;
            fs.writeFile(path.join(base,'..','..','images',imagePath+'.png'), raw, (err)=>{
                if(err)console.log(err.message); return {error:"Image Error"};
                console.log("File Saved")
            })
        }*/

        function passToStringWaypoints(waypoint){
            waypointsArray.push({lat: waypoint.lat.toString(), lon: waypoint.lon.toString()});
        }
        try{
            route.images=imagesarray;
            route.waypoints=waypointsArray;
            //route.reviewImages=reviewimagesarray;
            let result= await this.routeData.insert(route);
            result= {
                id: result._id,
                name: result.name,
                description: result.description,
                visibility:result.visibility,
                difficulty:result.difficulty,
                rating: result.rating,
                tags: result.tags,
                distance: result.distance,
                images: result.images,
                email: result.email,
                waypoints:result.waypoints
            }
            return{data: result};
        }catch (err){
            console.log(err)
            return {error:"Internal Server Error"}
        }
    }

    async getByEmail(req){
        const {email} = req.params;
        const {page} = req.query;
        const itemsPerPage = 10
        try{
            let result= await this.routeData.getByEmail(email,page,itemsPerPage);
            return{data: result};
        }catch (err){
            console.log(err);
            return {error:"Internal Server Error"}
        }
    }

    async getById(id){
        try{
            let result= await this.routeData.getById(id);
            return{data: result};
        }catch (err){
            console.log(err);
            return {error:"Internal Server Error"}
        }
    }

    async getMultipleById(arrayOfId){
        try{
            let result= await this.routeData.getMultipleById(arrayOfId);
            return{data: result};
        }catch (err){
            console.log(err);
            return {error:"Internal Server Error"}
        }
    }

    async getByQuery(req){
        const query = req.query
        const {page,fromDistance,lat,lon} = req.query;
        const itemsPerPage = 10;
        try {
            if(query.distance && query.distance>=0){
                query.distance = {$lte:query.distance};
            }
            let queryResult = await this.routeData.getByQuery(query,page,itemsPerPage);
            let userCoordinates = {uLat:lat,uLon:lon};
            let resultSet = [];
            if(isValid(lat, "string") && isValid(lon, "string")){
                for (var i=0;i<queryResult.length;i++){
                    let waypointCoordinates = {wLat: queryResult[i].waypoints[0].lat,wLon:queryResult[i].waypoints[0].lon}
                    const distance = await this.calcDistancetoUser(userCoordinates,waypointCoordinates);
                    if(fromDistance){
                        if(distance<fromDistance){
                            queryResult[i].fromDistance = distance;
                            resultSet.push(queryResult[i]);
                        }
                    }
                    else{
                        queryResult[i].fromDistance = distance;
                        resultSet.push(queryResult[i]);
                    }
                }
            }else{
                resultSet.push(queryResult)
            }

            return{data: resultSet};
        } catch (err) {
            return {error:"Internal Server Error"}
        }
    }

    async deleteByEmailAndName(routeParam){
        const email= routeParam.email;
        const name= routeParam.name;
        try{
            let result= await this.routeData.deleteByEmailAndName(email, name);
            return{data:result};
        }catch(err){
            return{error: "Internal Server Error"}
        }
    }

    async calcDistancetoUser(userCoordinates,waypointCoordinates){
        const {uLat,uLon} = userCoordinates;
        const {wLat,wLon} = waypointCoordinates;
        console.log(userCoordinates)
        console.log(waypointCoordinates)
        const request={
            "mode":"drive",
            "sources":[
                {
                    "location":[uLon,uLat]
                }
            ],
            "targets":[
                {
                    "location":[wLon,wLat]
                }
            ]
        }
        console.log(request)
        const url = `https://api.geoapify.com/v1/routematrix?apiKey=367aa79e17364e44a729eb76d2d0e459`;
        const res = await fetch(url, {
            method: 'POST',
            body: JSON.stringify(request),
            headers: { 'Content-Type': 'application/json' }})
        console.log(res)
        const data = await res.json();
        return (data.sources_to_targets[0][0].distance)/1000;
    }
    async updateRating(request){
        const {id,rating} = request;
        var route = await this.routeData.getById(id);
        var lastRating;
        if(route != null){

            lastRating= route[0].rating;

            var newRating= Math.round((rating+lastRating)/2);

            try{
                var result=await this.routeData.putRating(id, newRating);
                result= {
                    id: result._id,
                    name: result.name,
                    description: result.description,
                    visibility:result.visibility,
                    difficulty:result.difficulty,
                    rating: result.rating,
                    tags: result.tags,
                    distance: result.distance,
                    images: result.images,
                    email: result.email,
                    waypoints:result.waypoints
                }
                return{data: result};
            }catch (err){
                console.log(err)
                return {error:"Internal Server Error"}
            }
        }else{
            return {error:"Route does not exist"}
        }

    }

    async updateReviews(request){
        const{id, review} = request;
        const reviewimagesarray = new Array();
        review.images.forEach(passToReviewImageAndSave)

        function passToReviewImageAndSave(image){
            let raw = Buffer.from(image, 'base64');
            let imagePath = Date.now().toString()+Math.floor(Math.random()*100);

            let base= __dirname;
            fs.writeFile(path.join(base,'..','..','images',imagePath+'.png'), raw, (err)=>{
                if(err)console.log(err.message); return {error:"Image Error"};
                console.log("File Saved")
            })
            reviewimagesarray.push(process.env.ROUTES_PICS_BASE_URL+imagePath+'.png');
        }
        try{
            review.images= reviewimagesarray;


            let userProfile=await userData.getbyEmail(review.email);
            review.username= userProfile.username;
            review.picture= userProfile.picture;
            let result= await this.routeData.putReview(id, review);
            result= {
                id: result._id,
                name: result.name,
                description: result.description,
                visibility:result.visibility,
                difficulty:result.difficulty,
                rating: result.rating,
                tags: result.tags,
                distance: result.distance,
                reviews: result.reviews,
                images: result.images,
                email: result.email,
                waypoints:result.waypoints
            }
            return{data: result};
        }catch (err){
            console.log(err)
            return {error:"Internal Server Error"}
        }




    }

}


module.exports = RouteService;