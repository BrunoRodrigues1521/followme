'use strict';
const routeMiddleware = require('../middleware/routeMiddleware');
const validationMiddleware = require('../middleware/validationMiddleware');
const authorizationMiddleware = require('../middleware/authorizationMiddleware');
const routeController = require("../controllers/routeController");

module.exports = function (app) {
    const routeController =
        require('../controllers/routeController');

    app.route('/routes')
        .post(routeMiddleware.isValidRoute,
            //validationMiddleware.isJwtToken,
            //authorizationMiddleware.isAllowed,
            routeController.insert)
        .delete(
            validationMiddleware.isJwtToken,
            routeMiddleware.isValidDelete,
            authorizationMiddleware.isAllowed,
            routeController.deleteByEmailAndName)

    app.route('/routes/filter')
        .get(validationMiddleware.isJwtToken,
            routeMiddleware.isValidQuery,
            routeController.getByQuery)

    app.route('/routes/:email')
        .get(validationMiddleware.isJwtToken,
            routeMiddleware.isValidGetByEmail,
            routeController.getByEmail)
    app.route('/routes/rating')
        .put(validationMiddleware.isJwtToken,
            routeMiddleware.isValidUpdateRatings,
            routeController.updateRating)
    app.route('/routes/review')
        .put(validationMiddleware.isJwtToken,
            routeMiddleware.isValidUpdateReviews,
            routeController.updateReview)
}