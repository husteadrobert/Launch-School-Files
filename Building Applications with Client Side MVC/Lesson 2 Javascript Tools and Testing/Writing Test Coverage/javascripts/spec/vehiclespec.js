describe('Vehicle Constructor', function() {
  beforeEach(function() {
    this.testVehicle = new Vehicle({make: 'Ford', model: 'Taurus'});
  });
  
  it('sets the make and model properties when an object is passed in', function() {
    var anotherCar = new Vehicle({make: 'Ford', model: 'Taurus'});
    expect(this.testVehicle).toEqual(anotherCar);
  });
  it('returns a concatenated string with make and model', function() {
    expect(this.testVehicle.toString()).toEqual('Ford Taurus');
    this.testVehicle.make = 'Honda';
    this.testVehicle.model = 'Civic';
    expect(this.testVehicle.toString()).toEqual('Honda Civic');
  });
  it('returns a message when the horn is honked', function() {
    expect(this.testVehicle.honkHorn()).toEqual('Beep beep!');
  });
});