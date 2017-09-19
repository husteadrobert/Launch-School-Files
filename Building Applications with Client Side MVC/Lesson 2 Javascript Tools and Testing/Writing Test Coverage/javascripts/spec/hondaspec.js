describe('Honda Constructor', function() {
  beforeEach(function() {
    this.testVehicle = new Honda('Civic');
  });
  
  it('inherits the Vehicle Prototype', function() {
    expect(this.testVehicle.toString()).toEqual('Honda Civic');
  });
  it('sets the model property when a valid model is passed in', function() {
    expect(this.testVehicle.model).toEqual('Civic');
  });
  it('throws an error if an invalid model is passed in', function() {
    expect(function() {new Honda('InvalidModel')}).toThrow(new Error('Model InvalidModel does not exist.'));
  });
  it('returns a list of valid models', function() {
    expect(Honda.getModels.length).toBeDefined();
    expect(Honda.getModels()).toContain('Civic');
  });
  it('calls getPrice when a new car is created', function() {
    spyOn(Honda, 'getPrice');
    var car = new Honda('Civic');
    expect(Honda.getPrice).toHaveBeenCalled();
  });
  it('returns a price for the passed in model', function() {
    expect(Honda.getPrice('Civic')).toBeGreaterThan(0);
  });
  it('returns a price less than 15000 when a Civic is created', function() {
    expect(this.testVehicle.price).toBeLessThan(15000);
  });
  it('returns a price greater than 10000 when a CR-Z is created', function() {
    this.testVehicle = new Honda('CR-Z');
    expect(this.testVehicle.price).toBeGreaterThan(10000);
  });
});