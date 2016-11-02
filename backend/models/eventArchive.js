// EventArchive model - eventArchive.js

"use strict";

module.exports = function(sequelize, DataTypes) {
  var EventArchive = sequelize.define("EventArchive", {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    eventTitle: { 
      type: DataTypes.STRING,
      allowNull: false },
    description: { 
      type: DataTypes.STRING },
    startTime: { 
      type: DataTypes.DATE, 
      allowNull: false },
    hyperlink: { 
      type: DataTypes.STRING, 
      allowNull: true },
    location: {
      type: DataTypes.STRING },
    extractedFrom: {
      type: DataTypes.STRING },
    freeFood: { 
      type: DataTypes.BOOLEAN },
    freeSwag: { 
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

  return EventArchive;
};