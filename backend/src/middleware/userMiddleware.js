const {isValid} = require('../helpers/helpers');

exports.isValidFormatUpdate= function (req, res, next){

    const {email} = req.params;
    const {username,picture} = req.body;
    
    if(!isValid(email,"email")){
        return res.status(400).send({success:0,error:"Insert a valid email address"});
    }
    if(!isValid(username,"string") && !isValid(picture,"string")){
        return res.status(400).send({success:0,error:"At least one user parameter should be provided"});
    }
    return next();

}

exports.isValidFavourites = function(req,res,next){

    const {email,favourites} = req.body;

    if(!isValid(email,"email")){
        return res.status(400).send({success:0,error:"Insert a valid email address"});
    }

    if(!isValid(favourites,"objectIdArray")){
        return res.status(400).send({success:0,error:"Insert a valid set of favourites"});
    }
    return next();
}

exports.isValidFormatEmail = function(req,res,next){

    const {email} = req.params;

    if(!isValid(email,"email")){
        return res.status(400).send({success:0,error:"Insert a valid user email"});
    }
    return next();
}