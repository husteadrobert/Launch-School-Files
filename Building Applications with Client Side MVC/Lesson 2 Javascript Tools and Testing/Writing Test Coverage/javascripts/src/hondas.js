function Honda(model) {
  var currentModel = this.verify(model);
  if (!currentModel) {
    throw new Error('Model ' + model + ' does not exist.');
    return undefined;
  }
  this.make = "Honda";
  this.model = model;
  this.price = Honda.getPrice(this.model);
}

var modelList = ["Accord", "Civic", "Crosstour", "CR-V", "CR-Z", "Fit", "HR-V", "Insight", "Odyssey", "Pilot"];
var priceList = [16500,    14500,   21000,       15800,  12000,  13100, 16000,  18100,     22500,     19300];

Honda.prototype = Object.create(Vehicle.prototype);
Honda.prototype.constructor = Honda;

Honda.prototype.verify = function(model) {
  return modelList.indexOf(model) !== -1;
};

Honda.getPrice = function(model) {
  var modelIndex = modelList.indexOf(model);
  return priceList[modelIndex];
};

Honda.getModels = function() {
  return modelList.slice();
}