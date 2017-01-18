require "yaml"

def load_fame
  path = if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/hall_of_fame.yaml", __FILE__)
  else
    File.expand_path("../hall_of_fame.yaml", __FILE__)
  end
  YAML.load_file(path)
end

hall_of_fame = load_fame


hall_of_fame[2]["opponent"] = nil

p hall_of_fame[2]

hall_of_fame[2]["opponent"] = "Johnny 5"

p hall_of_fame[2]

File.open("hall_of_fame.yaml", "w") do |f|
  f.write(hall_of_fame.to_yaml)
end


hall_of_fame[2]["opponent"] = "HAL"

p hall_of_fame[2]

File.open("hall_of_fame.yaml", "w") do |f|
  f.write(hall_of_fame.to_yaml)
end