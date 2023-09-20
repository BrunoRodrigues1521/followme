'use strict'
const {isValid} = require('../helpers/helpers');

exports.isValidRoute= function (req, res, next){
    const {description,visibility, difficulty, tags, distance, images, email, waypoints}= req.body;

    if(!isValid(description,"string")){
        return res.status(400).send({success:0,error:"Insert a valid description"});
    }
    if(!isValid(visibility,"boolean")){
        return res.status(400).send({success:0,error:"Insert a valid visibility"});
    }
    if(!isValid(difficulty,"number")){
        return res.status(400).send({success:0,error:"Insert a valid difficulty"});
    }
    if(!isValid(tags,"array")){
        return res.status(400).send({success:0,error:"Insert a valid set of tags"});
    }
    if(!isValid(distance,"number")){
        return res.status(400).send({success:0,error:"Insert a valid distance"});
    }
    if(!isValid(images,"array")){
        return res.status(400).send({success:0,error:"Insert a valid set of images"});
    }
    if(!isValid(email,"email")){
        return res.status(400).send({success:0,error:"Insert a valid email address"});
    }
    if(!isValid(waypoints,"array")){
        return res.status(400).send({success:0,error:"Insert a valid set of waypoints"});
    }
    return next();
}

exports.isValidGetByEmail = function(req,res,next){

    const {email} = req.params;
    const {page} = req.query;

    if(!isValid(email,"email")){
        return res.status(400).send({success:0,error:"Insert a valid email address"});
    }
    if(!isValid(Number(page),"number")){
        return res.status(400).send({success:0,error:"Insert a valid page number"});
    }
    if(page<1){
        return res.status(400).send({success:0,error:"Page number must be higher or equal to 1"});
    }
    return next();
}

exports.isValidDelete = function(req,res,next){

    const {email,name} = req.body;

    if(!isValid(email,"email")){
        return res.status(400).send({success:0,error:"Insert a valid email address"});
    }
    if(!isValid(name,"string")){
        return res.status(400).send({success:0,error:"Insert a valid name"});
    }
    return next();
}

exports.isValidQuery = function(req,res,next){
    const {page} = req.query;
    const {lat,lon} = req.query;
    const query = Object.keys(req.query);
    const whiteList = ["page","name","description","lat","lon","city","distance","fromDistance","rating","difficulty"]

    if(!isValid(Number(page),"number")){
        return res.status(400).send({success:0,error:"Insert a valid page number"});
    }
    if(page<1){
        return res.status(400).send({success:0,error:"Page number must be higher or equal to 1"});
    }

    for(var i =0;i<query.length;i++){
        if(!whiteList.includes(query[i])){
            return res.status(400).send({success:0,error:"Unknown query params"});
        }
    }
    return next();
}

exports.isValidUpdateRatings = function(req, res, next){
    const {rating} = req.body;

    if(!isValid(rating, "number")){
        return res.status(400).send({success:0,error:"Insert a valid rating"});
    }
    return next();
}

exports.isValidUpdateReviews = function(req, res, next){
    const {content, email, images} = req.body.review;

    if(!isValid(content, "string")){
        return res.status(400).send({success:0,error:"Insert a valid content"});
    }
    if(!isValid(email, "email")){
        return res.status(400).send({success:0,error:"Insert a valid email"});
    }
    if(!isValid(images, "array")){
        return res.status(400).send({success:0,error:"Insert a valid image"});
    }
    return next();
}
