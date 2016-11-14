class Vehicle
  def turn_vehicle
  end

  def start
  end

  def turn_off
  end
end

class LandVehicle < Vehicle
  def drive
  end

  def honk
  end
end

class Cars < LandVehicles
  def spin_wheels
  end
end

class Taxi < Cars
  def go_to_destination
  end
end

class RaceCar < Cars
  def go_super_fast
  end
end

class Trucks < LandVehicles
  def load
  end
end

class EmergencyVehicle < Trucks
  def find_hospital
  end
end

class MovingTruck < Trucks
  def deploy_lift
  end
end

class WaterVehicle < Vehicle
  def contact_shore
  end
  def drop_anchor
  end
end

class Boat < WaterVehicle
end

class FishingBoat < Boat
  def find_fish
  end
end

class Freighter < Boat
  def load # Same as Truck, repeating code here.
  end
end

class Ferry < Boat
  def go_to_destination #Same as Taxi, repeating code here.
  end
end

# Where can I add accept_non_driving_passenger method?
# Or a print_manifest method?

