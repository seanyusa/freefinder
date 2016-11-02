var express = require('express');
var apiRouter = express.Router();

apiRouter.use('/events', require('./events'));
apiRouter.use('/eventarchives', require('./eventArchives'))
apiRouter.use('/search', require('./search'));

module.exports = apiRouter;