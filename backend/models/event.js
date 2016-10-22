// Event model - event.js

"use strict";

module.exports = function(sequelize, DataTypes) {
  var Event = sequelize.define("Event", {
    eventTitle: { 
      type: DataTypes.STRING,
      allowNull: false },
    description: { 
      type: DataTypes.STRING },
    freeFood: { 
      type: DataTypes.BOOLEAN },
    freeSwag: { 
      type: DataTypes.BOOLEAN },
    startTime: { 
      type: DataTypes.BIGINT, 
      allowNull: false },
    hyperlink: { 
      type: DataTypes.STRING, 
      allowNull: true }
  }, {
    timestamps: false,
    classMethods: {
      associate: function(models) {
        
      }
    }
  });

  return Event;
};