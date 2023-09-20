'use strict';
const { ObjectId } = require('mongodb');
const mongoose = require('mongoose');
const routeModel = require('./routeModel');
const Schema = mongoose.Schema;

const favouritesSchema = new Schema({
    user: {
        type: String,
        required: "Insert a valid user email"
    },
    favourites:[{
        type: mongoose.Schema.Types.ObjectId,
        ref: routeModel
    }]

}, {collection: 'favouriteCollection'}   );
module.exports = mongoose.model('Favourites', favouritesSchema);