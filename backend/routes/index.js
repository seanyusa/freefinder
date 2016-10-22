module.exports = function (app) {
    app.use('/events', require('./events'));
};