var express = require('express');
var apiRouter = express.Router();

apiRouter.use('/events', require('./events'));
apiRouter.use('/archivedevents', require('./archivedEvents'))
apiRouter.use('/search', require('./search'));

module.exports = apiRouter;