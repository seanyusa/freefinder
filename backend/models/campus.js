// Campus model - campus.js

"use strict";

module.exports = function(sequelize, DataTypes) {
  var Campus = sequelize.define("Campus", {
    name: { 
      type: DataTypes.STRING,
      allowNull: false },
    description: { 
      type: DataTypes.STRING },
    imageURL: { 
      type: DataTypes.STRING },
    hyperlink: { 
      type: DataTypes.STRING },
    geoLat: {
      type: DataTypes.DOUBLE },
    geoLong: {
      type: DataTypes.DOUBLE }
  }, {
    timestamps: false,
    classMethods: {
      associate: function(models) {
        Campus.hasMany(models.Event, {as: 'Events'})
      }
    }
  });

  return Campus;
};