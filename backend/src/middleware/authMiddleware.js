require('dotenv').config({path:"env/.env"})
const UserService = require("../services/userService");
const userData = require('../data/userData');
const UserServiceInstance = new UserService(userData);
const {isValid} = require('../helpers/helpers');


exports.isUser = async function(req,res,next){
    const {email} = req.body;
    const exists = await UserServiceInstance.exists(email)
    try {
        if(exists.error){
            return res.status(500).send({success:0,error:"Internal Server Error"});
        }
        if(exists){
            return res.status(403).send({success:0,error:"Account already exists"});
        }
        return next();
        
    } catch (err) {
        return res.status(500).send({success:0,error:"Internal Server Error"});
    }
}

exports.isAuthorized = async function(req,res,next){

        const {email,password} = req.body;
        try{
            const result = await UserServiceInstance.get(email)

            if(result.error){
                console.log(result.error)
                return res.status(500).send({success:0,error:"Internal Server Error"});
            }
            if(!result.data){
                return res.status(401).send({success:0,error:"Wrong Credentials"});
            }
            if(!result.data.password){
                return res.status(401).send({success:0,error:"Seems that your account is linked to third party sign in methods"});
            }
            const isMatch = await UserServiceInstance.checkPassword(password,result.data.password);
                if(isMatch){
                    res.locals.data={
                        id:result.data._id,
                        username:result.data.username,
                        email:result.data.email
                    }
                    return next();
                }
                return res.status(401).send({success:0,error:"Wrong Credentials"});
        }catch(err){
            console.log(err)
            return res.status(500).send({success:0,error:"Internal Server Error"});
        }

}

exports.isValidFormatRegister = function(req,res,next){

    const {username,email,password} = req.body;

    if(!isValid(username,"string")){
        return res.status(400).send({success:0,error:"Insert a valid username"});
    }
    if(!isValid(email,"email")){
        return res.status(400).send({success:0,error:"Insert a valid email address"});
    }
    if(!isValid(password,"password")){
        return res.status(400).send({success:0,error:"Password must be between 7 to 20 characters which contain only characters, numeric digits and underscore and first character must be a letter"});
    }
    return next();
}

exports.isValidFormatLogin = function(req,res,next){

    const {email,password} = req.body;

    if(!isValid(email,"email")){
        return res.status(400).send({success:0,error:"Insert a valid email address"});
    }
    if(!isValid(password,"password")){
        return res.status(400).send({success:0,error:"Password must be between 7 to 20 characters which contain only characters, numeric digits and underscore and first character must be a letter"});
    }
    return next();
}

exports.isValidFormatToken = function(req,res,next){

    const {token} = req.body;

    if(!isValid(token,"string")){
        return res.status(400).send({success:0,error:"Insert a valid format token"});
    }
    return next();
}

exports.isValidFormatReset = function(req,res,next){

    const {email,currentPassword,newPassword} = req.body;

    if(!isValid(email,"email")){
        return res.status(400).send({success:0,error:"Insert a valid email address"});
    }
    if(!isValid(currentPassword,"password") || !isValid(newPassword,"password")){
        return res.status(400).send({success:0,error:"Password must be between 7 to 20 characters which contain only characters, numeric digits and underscore and first character must be a letter"});
    }
    return next();
}