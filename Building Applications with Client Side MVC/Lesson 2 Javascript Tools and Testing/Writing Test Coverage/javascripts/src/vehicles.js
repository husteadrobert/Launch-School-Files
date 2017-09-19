var Vehicle = function(options) {
  this.make = options.make;
  this.model = options.model;
};

Vehicle.prototype.toString = function() {
  return String(this.make + ' ' + this.model);
};

Vehicle.prototype.honkHorn = function() {
  return "Beep beep!";
};