// Route - search
var express = require('express');
var Sequelize = require('sequelize');

var models  = require("../models");

var router = express.Router();

router.get('/', function(req, res){
  console.log('Request: Search /events from ' + req.query.eventTitle);

  if (!(req.query.eventTitle && req.query.startTime)) {
  	res.setHeader('Content-Type', 'application/json');
    res.status(400).send(JSON.stringify({message: 'missing query parameters'}));
    console.log('Missing query params');
    return;
  }

  models.Event.findAll({
    where: {
      eventTitle: req.query.eventTitle,
      startTime: req.query.startTime
    }
  }).then(function(events) {
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify({events: events}));
    console.log('All events sent');
  });
});


module.exports = router;