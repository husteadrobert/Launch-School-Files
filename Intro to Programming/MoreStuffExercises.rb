def check_in(input_string)
  if /lab/=~ input_string.downcase #--_Cause shouldn't Labyrinth print?
    puts input_string
  end
end

check_in("laboratory")
check_in("experiemnt")
check_in("Pans Labyrinth") 
check_in("elaborate")
check_in("polar bear")


def execute(&block)
  block.call
end

execute { puts "Hello from inside the execute method!"}

