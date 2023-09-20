const mongoose = require('mongoose')
const routeModel = mongoose.model('Route')

exports.insert = async function (route) {

    const newRoute = new routeModel();
    newRoute.name= route.name;
    newRoute.description =route.description;
    newRoute.visibility= route.visibility;
    newRoute.difficulty = route.difficulty;
    newRoute.rating = route.rating;
    newRoute.tags= route.tags;
    newRoute.distance= route.distance;
    newRoute.images= route.images;
    newRoute.rating = 0;
    newRoute.waypoints= route.waypoints;
    newRoute.email= route.email;
    return newRoute.save();
};

exports.getByEmail = async function (email,page,itemsPerPage) {
    return routeModel.find({
        email:email
    }).skip(itemsPerPage*(page-1)).limit(itemsPerPage);
};

exports.getById = async function (id) {
    return routeModel.find({
        _id:id
    });
};

exports.getMultipleById = async function (arrayOfId) {
    return routeModel.find({
        _id:{$in:arrayOfId}
    });
};

exports.getByQuery = async function (query,page,itemsPerPage) {
    return routeModel.find({
        $and:[query]
    }).lean().skip(itemsPerPage*(page-1)).limit(itemsPerPage);
};

exports.deleteByEmailAndName= async function(email, name) {
    return routeModel.deleteOne({
        email:email,
        name:name
    });
}

exports.putRating= async function(_id,rating){
    return routeModel.findOneAndUpdate({
        _id:_id
    },{rating:rating},{new:true})}

exports.putReview = async function (_id, review){
    return routeModel.findOneAndUpdate({
        _id:_id
    },{$push:{ reviews:review}},{upsert:true, new:true})
}