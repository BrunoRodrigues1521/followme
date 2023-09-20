'use strict';
const authMiddleware = require('../middleware/authMiddleware');
const validationMiddleware = require('../middleware/validationMiddleware');
const authorizationMiddleware = require('../middleware/authorizationMiddleware');
const userMiddleware = require('../middleware/userMiddleware');

module.exports = function (app) {
    const userController =
        require('../controllers/userController');
    
    // rotas de autenticação

    app.route('/auth/register')
        .post(authMiddleware.isValidFormatRegister,
              authMiddleware.isUser,
              userController.insert)
            
    app.route('/auth/login')
        .post(authMiddleware.isValidFormatLogin,
              authMiddleware.isAuthorized,
              userController.get)
              
    app.route('/auth/google')
        .post(authMiddleware.isValidFormatToken,
              validationMiddleware.isGoogleToken,
              userController.authWithGoogle)
    app.route('/user/resetpasswd')
        .patch(validationMiddleware.isJwtToken,
             authMiddleware.isValidFormatReset,
             authorizationMiddleware.isAllowed,
             userController.resetPasswd)         

    app.route('/user/:email')
        .get(validationMiddleware.isJwtToken,
              userMiddleware.isValidFormatEmail,
              userController.getByEmail)
        .patch(validationMiddleware.isJwtToken,
              userMiddleware.isValidFormatUpdate,
              authorizationMiddleware.isAllowed,
              userController.update)

    app.route('/user/favourites')
        .post(validationMiddleware.isJwtToken,
              userMiddleware.isValidFavourites,
              authorizationMiddleware.isAllowed,
              userController.addFavourites)
    app.route('/user/:email/favourites')
        .get(validationMiddleware.isJwtToken,
             userMiddleware.isValidFormatEmail,
             userController.getFavourites)
   
};