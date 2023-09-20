require('dotenv').config({path:"env/.env"});
const bcrypt = require("bcrypt");
var fs = require('fs');
var path = require('path')

class UserService{

    constructor(userData){
        this.userData = userData;
    }

    async insert(user){

        try{
            const hashpasswd=this.hashPassword(user.password);
            user.password=hashpasswd;
            let result = await this.userData.insert(user);
            result = {
                id: result._id,
                username: result.username,
                email: result.email
            }
            return {data:result};
        }catch(err){
            return {error:"Internal Server Error"};
        }
    }
    async get(email){
        try{
            const result = await this.userData.getbyEmail(email);
            return {data:result};
        }catch(err){
            return {error:err};
        }
    }

    async getByEmail(email){
        try{
            let result = await this.userData.getbyEmail(email);
            result = {
                id:result._id,
                username:result.username,
                email:result.email,
                picture: result.picture
            }
            return {data:result};
        }catch(err){
            return {error:err};
        }
    }

    async update(req){

        try{
            const {email} = req.params;
            let {username,picture} =req.body;    
            if(picture){
                picture = this.passToImageAndSave(picture);
            }
            let result = await this.userData.update(email,username,picture);
            result = {
                id: result._id,
                username: result.username,
                email: result.email,
                picture: result.picture
            }
            return {data:result};
        }catch(err){
            console.log(err)
            return {error:"Internal Server Error"};
        }
    }

    async authWithGoogle(user){
        try{
            const result = await this.userData.authWithGoogle(user);
            return {data:result};
        }catch(err){
            return {error:err};
        }
    }
    async exists(email){
        try{
            const result = await this.userData.getbyEmail(email);
            if(result){
                return true;
            }
            return false;
        }catch(err){
            return {error:err};
        }
    }
    
    async resetPasswd(body){

        const {email,currentPassword,newPassword} = body;

        if(currentPassword===newPassword){
            return {error:"New password cannot be equal to your current one"};
        }

        try {
            const userInfo = await this.userData.getbyEmail(email);

            if(!userInfo){
                return {error:"User doesn't exist"};
            }
            const {password} = userInfo;

            const isMatch = await this.checkPassword(currentPassword,password);

            if(!isMatch){
                return {error:"Current password doesn't match"};
            } 
            
            const hashpasswd = this.hashPassword(newPassword)
            await this.userData.reset(email,hashpasswd);

            return {success:1};
            
        } catch (err) {
            return {error:err};
        }
    }
    async addFavourites(body){
        const {email,favourites} = body;
        console.log(email)
        try {
            let result = await this.userData.addRouteFavouritesById(email,favourites);
            if(result.acknowledged){
                return {success:1};
            }
            return {error:"Internal Server Error"};
        

        } catch (err) {
            console.log(err)
            return {error: "Internal Server Error"};
        }
    }

    async getFavourites(params){
        const {email} = params;
        try {
            const favourites = await this.userData.getFavourites(email);

            if(favourites){
                return {data:favourites};
            }
            return {data:[]};
        } catch (err) {
            console.log(err)
            return {error: "Internal Server Error"};
        }
    }

    hashPassword(password){
        return bcrypt.hashSync(password, 10);
    }

    async checkPassword(password,actualPassword){
        return await bcrypt.compare(password,actualPassword);
    }
    passToImageAndSave(image){
        let baseUrl = process.env.PROFILE_PICS_BASE_URL;
        let raw = Buffer.from(image, 'base64');
        let imagePath = Date.now().toString()+Math.floor(Math.random()*100);
        let base= __dirname;
        fs.writeFile(path.join(base,'..','..','profilePics',imagePath+'.png'), raw, (err)=>{
            if(err)console.log(err.message); return {error:"Image Error"};
        })
        return baseUrl+imagePath+'.png';
    }
}

module.exports = UserService;