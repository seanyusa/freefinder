// Route - events
var express = require('express');
var Sequelize = require('sequelize');

var models  = require("../models");

var router = express.Router();

// ----- GET /events - Get list of all events. -----
router.get('/', function(req, res){
  console.log('Request: GET /events');
  models.Event.findAll({
    order: 'startTime'
  })
  .then(function(events) {
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify({events: events}));
    console.log('All events sent');
  })
});

// ----- POST /events - Create new event. -----
router.post('/', function(req, res) {
  console.log('Request: POST /events');
  var eventTitle = req.body.eventTitle;
  var description = req.body.description;
  var startTime = new Date(req.body.startTime);
  var endTime = new Date(req.body.endTime);
  var hyperlink = req.body.hyperlink;
  var location = req.body.location;
  var extractedFrom = req.body.extractedFrom;
  var freeFood = req.body.freeFood;
  var freeSwag = req.body.freeSwag;
  var needRSVP = req.body.needRSVP;
  console.log(JSON.stringify(req.body));

  models.Event
  .create({ 
    eventTitle: eventTitle, 
    description: description, 
    startTime: startTime, 
    endTime: endTime,
    hyperlink: hyperlink,
    location: location,
    extractedFrom: extractedFrom,
    freeFood: freeFood, 
    freeSwag: freeSwag,
    needRSVP: needRSVP })
  .then(function() {
    models.Event
      .findOrCreate({where: { /*eventTitle: eventTitle*/ }, defaults: {}})
      .spread(function(event, created) {
        console.log('Created event: ' + eventTitle );
        res.setHeader('Content-Type', 'application/json');
        res.send(JSON.stringify(event));
      })
  })
  .catch(Sequelize.ValidationError, function (err) {
    // respond with validation errors
    return res.status(422).send(err);
  })
  .catch(function(err) {
    console.log('ERROR:' + err)
    res.status(500).send('Error encountered: ' + err);
  })
});

// ----- GET /events/eventid - Get a specific event. -----
router.get('/:eventId', function(req, res){
  var eventId = req.params.eventId;
  console.log('Request: GET /events/' + eventId);

  models.Event.findById(eventId).then(function(event) {
    if(event == null) {
      res.status(404).send( {'message': 'Event not found'} );
      console.log('Event ' + eventId + ' not found.');
      return
    }
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify(event));
    console.log('Event ' + eventId + ' sent');
  })
  .catch(function(err) {
    console.log('ERROR:' + err)
    res.status(500).send( {'message': 'Error encountered: ' + err } );
  })
  console.log('Requested for Event.'); 
});

// ----- POST /events/eventid - Update a events information. -----
router.post('/:eventId', function(req, res){
  var eventId = req.params.eventId;
  var eventTitle = req.body.eventTitle;
  var description = req.body.description;
  var startTime = new Date(req.body.startTime);
  var endTime = new Date(req.body.endTime);
  var hyperlink = req.body.hyperlink;
  var location = req.body.location;
  var extractedFrom = req.body.extractedFrom;
  var freeFood = req.body.freeFood;
  var freeSwag = req.body.freeSwag;
  var needRSVP = req.body.needRSVP;

  console.log('Request: POST /events/' + eventId);

  models.Event.findById(eventId).then(function(event) {
    if(event == null) {
      res.status(404).send( {'message': 'Event not found'} );
      console.log('Event ' + eventId + ' not found.');
      return
    }
    event.updateAttributes({
      eventTitle: eventTitle, 
      description: description, 
      startTime: startTime, 
      endTime: endTime,
      hyperlink: hyperlink,
      location: location,
      extractedFrom: extractedFrom,
      freeFood: freeFood, 
      freeSwag: freeSwag,
      needRSVP: needRSVP
    });
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify(event));
    console.log('Event ' + eventId + ' updated');
  })
  .catch(function(err) {
    console.log('ERROR:' + err)
    res.status(500).send({'message': 'Error encountered: ' + err });
  })
  console.log('Updated event: ' + eventname); 
});

// ----- DELETE /events/eventid - Delete a specific event. -----
router.delete('/:eventId', function(req, res){
  var eventId = req.params.eventId;
  console.log('Request: DELETE /events/' + eventId);
  models.Event.findById(eventId).then(function(event) {
    if(event == null) {
      res.status(404).send( {'message': 'Event not found'} );
      console.log('Event with id: ' + eventId + ' not found.');
      return
    }
    event.destroy({ force: true });
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify(event));
    console.log('Event with id ' + eventId + ' sent');
    console.log('Deleted event with id:' + eventId);
  })
  .catch(function(err) {
    res.status(500).send('Error encountered: ' + err);
  })
});

// ------ DELETE all events ---------
router.delete('/', function(req, res){
  console.log('Request: DELETE ALL /events');
  models.Event.sync({ force : true }) // drops table and re-creates it
    .success(function() {
      console.log('Cleared all events');
      res.send(JSON.stringify({'message' : 'cleared all events.'}));
    })
    .error(function(err) {
      res.status(500).send('Error encountered: ' + err);
    });
});

module.exports = router;