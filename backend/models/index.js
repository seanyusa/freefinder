// Main - index.js
// Sample code from http://docs.sequelizejs.com/en/1.7.0/articles/express/

"use strict";

// DB Passwords Storage
var env = process.env.NODE_ENV || 'development';
var config = require('../secret/config')[env];

var fs        = require("fs");
var path      = require("path");
var Sequelize = require("sequelize");

var db        = {};

var sequelize = new Sequelize(config.database.db, config.database.user, config.database.pass, {
  host: config.database.host,
  dialect: 'mssql',
  pool: {
    max: 5,
    min: 0,
    idle: 10000
  },
  dialectOptions: {
    encrypt: true,
    trustServerCertificate: false
  }
});

fs
  .readdirSync(__dirname)
  .filter(function(file) {
    return (file.indexOf(".") !== 0) && (file !== "index.js");
  })
  .forEach(function(file) {
    var model = sequelize.import(path.join(__dirname, file));
    db[model.name] = model;
  });

Object.keys(db).forEach(function(modelName) {
  if ("associate" in db[modelName]) {
    db[modelName].associate(db);
  }
});

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;