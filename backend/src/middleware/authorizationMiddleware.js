const TokenService = require('../services/tokenService');
const TokenServiceInstance = new TokenService();

exports.isAllowed= function (req, res, next){

    const emailArray = [];
    const header = req.headers['authorization'].split(' ')

    if(req.params.email){
        emailArray.push(req.params.email)
    }
    if(req.query.email){
        emailArray.push(req.query.email)
    }
    if(req.body.email){
        emailArray.push(req.body.email)
    }
    const isAllowed = isTokenMatch(emailArray,header[1]);

    if(!isAllowed){
        return res.status(401).send({success:0,error:"Not allowed"});
    }
    next();
    
}

isTokenMatch= function (array,token){

    const decodedToken = TokenServiceInstance.decodeJwtToken(token);
    for(var i=0;i<array.length;i++){
        if(array[i]!=decodedToken.email){
            return false;
        }
    }
    return true;
}