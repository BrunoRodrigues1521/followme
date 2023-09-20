require('./src/config/mongo-config');
require('./src/models/userModel');
require('./src/models/routeModel');
require('./src/models/favouritesModel');

const express = require('express')
const cors = require('cors')
const PORT = process.env.PORT || 5000
const helmet = require('helmet');
const app = express();

const userRoutes = require('./src/routes/userRoutes');
const routeRoutes = require('./src/routes/routeRoutes');

app.use(helmet());
app.use(express.json({limit:'50mb'}));
app.use(express.urlencoded({limit:'50mb', extended: false }));
app.use(cors());
app.use(function(req, res, next) {
      res.header('Access-Control-Allow-Origin', '*');
      res.header('Access-Control-Allow-Headers', 'Content-Type');
      res.header('Access-Control-Allow-Methods', 'GET, POST, PUT ,DELETE');
      next();
});
userRoutes(app);
routeRoutes(app);

app.use('/uploads', express.static('./images'));
app.use('/profiles', express.static('./profilePics'));

app.use(function(req, res) {
      res.status(404).send({sucess:0,error:"Not Found"});
});
app.use(function(req, res) {
      res.status(403).send({sucess:0,error:"Forbidden"});
});
app.use(function(req, res) {
      res.status(500).send({sucess:0,error:"Internal Server Error"});
});
  
app.listen(PORT, () =>
    console.log(`Listening on http://localhost:${PORT}`));