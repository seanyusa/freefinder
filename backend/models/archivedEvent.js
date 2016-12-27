// ArchivedEvent model - archivedEvent.js

"use strict";

module.exports = function(sequelize, DataTypes) {
  var ArchivedEvent = sequelize.define("ArchivedEvent", {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true },
    campusId: {
      type: DataTypes.INTEGER,
      allowNull: true},
    eventTitle: { 
      type: DataTypes.STRING,
      allowNull: false },
    description: { 
      type: DataTypes.STRING },
    startTime: { 
      type: DataTypes.DATE, 
      allowNull: false },
    endTime: { 
      type: DataTypes.DATE },
    hyperlink: { 
      type: DataTypes.STRING },
    location: {
      type: DataTypes.STRING },
    geoLat: {
      type: DataTypes.DOUBLE },
    geoLong: {
      type: DataTypes.DOUBLE },
    extractedFrom: {
      type: DataTypes.STRING },
    freeFood: { 
      type: DataTypes.BOOLEAN },
    freeSwag: { 
      type: DataTypes.BOOLEAN },
    bringResume: { 
      type: DataTypes.BOOLEAN },
    needRSVP: { 
      type: DataTypes.BOOLEAN }
  }, {
    timestamps: false,
    classMethods: {
      associate: function(models) {
        
      }
    }
  });

  return ArchivedEvent;
};