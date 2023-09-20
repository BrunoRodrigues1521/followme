'use strict';
require('dotenv').config({path:"env/.env"});
const {OAuth2Client} = require('google-auth-library');
const jwt=require('jsonwebtoken')
const jwt_decode = require('jwt-decode');

class TokenService{

    createJwtToken(user){

        return jwt.sign(user,process.env.JWT_SECRET,{expiresIn:process.env.JWT_EXPIRES_IN});
    }

    isJwtToken(req){
        if (req.headers['authorization']) {
            try {
                let authorization = req.headers['authorization'].split(' ');
                if (authorization[0] !== 'Bearer') {
                    return {error:"Invalid Token"};
                }
                req.jwt = jwt.verify(authorization[1], process.env.JWT_SECRET);
                return {success:1};
            } catch (err) {
                return {error:"Invalid Token"};
            }
        } else {
            return {error:"Missing Token"};
        }
    }

    decodeJwtToken(token){
        const decodedToken = jwt_decode(token);
        return decodedToken;
    }

    async validateGtoken(token){
        try{
            const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);
            const ticket = await client.verifyIdToken({
                idToken: token,
                audience: process.env.GOOGLE_CLIENT_ID,
            });
            const payload = ticket.getPayload();
            const user = {email:payload['email'],username:payload['name'],picture:payload['picture']};
            return {data:user};
        }catch(err){
            return {error:"Couldn't validate token"};
        }

    }
}

module.exports= TokenService;