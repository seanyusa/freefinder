var express = require('express');
var Sequelize = require('sequelize');
var models  = require("./models");

var bodyParser = require('body-parser');
var app = express();

app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

var router = require('./routes')(app);

// USE: server [cleardb]

var clearDb = false;
// Argument Parsing
process.argv.forEach(function (val, index, array) {
  console.log(index + ': ' + val);
  if(val === 'cleardb') clearDb = true;
});
console.log('cleardb: ' + clearDb);

var allowCrossDomain = function(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    next();
};
app.use(allowCrossDomain);

app.use('/webapp', express.static('../webpage'));
app.set('port', 2400);

models.sequelize.sync({ force: clearDb }).then(function () {
  var server = app.listen(app.get('port'), function() {
    models.sequelize
      .authenticate()
      .then(function(err) {
        console.log('Connection has been established successfully.');
      })
      .catch(function (err) {
        console.log('Unable to connect to the database:', err);
      });
    console.log('Server listening on port ' + server.address().port);
  });
});

app.get('/', function(req, res){
  console.log('Request: GET /');
  res.setHeader('Content-Type', 'application/json');
  res.send( {'message': 'FreeFinder REST API backend'});
});
