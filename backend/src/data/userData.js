const mongoose = require('mongoose')
const userModel = mongoose.model('User')
const favouritesModel = mongoose.model('Favourites')

exports.insert = async function (user) {

    const newUser = new userModel();
    newUser.username = user.username;
    newUser.email = user.email;
    newUser.password = user.password;
    return newUser.save()
};

exports.authWithGoogle = async function (user) {
    const newUser = new userModel();
    newUser.username = user.username;
    newUser.email = user.email;
    newUser.picture = user.picture;
    return newUser.save()
};

exports.getbyEmail = async function (email) {
        return userModel.findOne({
            email:email
        },{_id:1,username:1,email:1,password:1,picture:1});  
};

exports.reset = async function (email,password) {
    return userModel.findOneAndUpdate({
        email:email
    },{password:password},{new:true});
};

exports.update = async function (email,username,picture){
    if(username && picture){
        return userModel.findOneAndUpdate({
            email:email
        },{username:username,picture:picture},{new:true})
    }else if (username){
        return userModel.findOneAndUpdate({
            email:email
        },{username:username},{new:true})
    }else{
        return userModel.findOneAndUpdate({
            email:email
        },{picture:picture},{new:true})
    }

}

exports.addRouteFavouritesById= async function(email,favourites) {
    return favouritesModel.updateOne({
        user:email
    },{$push:{ favourites:favourites}},{upsert:true});
}

exports.getFavourites= async function(email) {
    return favouritesModel.findOne({
        user:email
    },{favourites:1}).populate("favourites");
}