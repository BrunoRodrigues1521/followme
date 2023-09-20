'use strict'


exports.isJwtToken = function(req,res,next){

    const TokenService = require('../services/tokenService');
    const TokenServiceInstance = new TokenService();

    const result = TokenServiceInstance.isJwtToken(req);

    if(result.error){
        return res.status(401).send({success:0,error:result.error});
    }
    return next();
}

exports.isGoogleToken = async function(req,res,next){

    const TokenService = require('../services/tokenService');
    const TokenServiceInstance = new TokenService();

    const result = await TokenServiceInstance.validateGtoken(req.body.token);
    res.locals = result;
    if(result.error){
        return res.status(401).send({success:0,error:result.error});
    }
    return next();
}

