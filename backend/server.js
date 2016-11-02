var express = require('express');
var Sequelize = require('sequelize');
var bodyParser = require('body-parser');
console.log('loaded all node modules');

var models  = require("./models");
console.log('Required ./models.');

var app = express();
console.log('Express successfully started');

app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies
console.log('Use bodyParser with Express');

var apiRouter = require('./routes');
app.use('/api', apiRouter)
console.log('Required ./routes');

// USE: server [cleardb]

var clearDb = false;
// Argument Parsing
process.argv.forEach(function (val, index, array) {
  console.log(index + ': ' + val);
  if(val === 'cleardb') clearDb = true;
});
console.log('cleardb: ' + clearDb);
console.log('Read all command line arguments.');

// var allowCrossDomain = function(req, res, next) {
//     res.header('Access-Control-Allow-Origin', '*');
//     res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
//     res.header('Access-Control-Allow-Headers', 'Content-Type');
//     next();
// };
// app.use(allowCrossDomain);
// console.log('Set Access control headers');

// Webpage server
app.use('/', express.static('./webpage'));
console.log('Started static webapp service.');

app.set('port', process.env.PORT || 2400);
console.log('Set port successfully to ' + (process.env.PORT || 2400));

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

app.get('/api', function(req, res){
  console.log('Request: GET /');
  res.setHeader('Content-Type', 'application/json');
  res.send( {'message': 'FreeFinder REST API backend'});
});
