'use strict';
const RouteService = require("../services/routeService");
const routeData = require('../data/routeData');
const RouteServiceInstance = new RouteService(routeData);

exports.insert= async function (req, res){
    try{
        const result= await RouteServiceInstance.insert(req.body);
        if(result.error){
            return res.status(500).json({success:0,error:result.error});;
        }
        res.status(200).json({success:1, route: result});
    }catch(err){
        console.log(err)
        return res.status(500).send({success:0,error:"Internal Server Error"});
    }
};

exports.getByEmail= async function (req, res){
    try{
        const result= await RouteServiceInstance.getByEmail(req);
        if(result.error){
            return res.status(500).json({success:0,error:result.error});
        }
        res.status(200).json({success:1, routes: result.data});
    }catch(err){
        return res.status(500).send({success:0,error:"Internal Server Error"});
    }
};

exports.getByQuery= async function (req,res){
    try{
        const result= await RouteServiceInstance.getByQuery(req);
        if(result.error){
            return res.status(500).json({success:0,error:result.error});
        }
        res.status(200).json({success:1, routes: result.data});
    }catch(err){
        console.log(err);
        return res.status(500).send({success:0,error:"Internal Server Error"});
    }
}

exports.deleteByEmailAndName= async function(req, res){
    try{
        const result= await RouteServiceInstance.deleteByEmailAndName(req.body);
        if(result.error){
            return res.status(500).json({success:0,error:result.error});
        }
        res.status(200).json({success:1, routes: result.data});
    }catch(err){
        return res.status(500).send({success:0,error:"Internal Server Error"});
    }

};

exports.updateRating= async function(req, res){
    try{
        const result= await RouteServiceInstance.updateRating(req.body);
        if(result.error){
            return res.status(500).json({success:0,error:result.error});
        }
        res.status(200).json({success:1, routes: result.data});
    }catch(err){
        return res.status(500).send({success:0,error:"Internal Server Error"});
    }
}

exports.updateReview= async function(req, res){
    try{
        const result= await RouteServiceInstance.updateReviews(req.body);
        if(result.error){
            return res.status(500).json({success:0,error:result.error});
        }
        res.status(200).json({success:1, routes: result.data});
    }catch(err){
        return res.status(500).send({success:0,error:"Internal Server Error"});
    }
}