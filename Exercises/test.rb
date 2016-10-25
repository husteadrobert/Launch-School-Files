# # Group 1
# def check_return_with_proc
#   my_proc = proc { return }
#   my_proc.call
#   puts "This will never output to screen."
# end

# check_return_with_proc

#The return was called and execution left the method.

# Group 2
# my_proc = proc { return }

# def check_return_with_proc_2(my_proc)
#   my_proc.call
# end

# check_return_with_proc_2(my_proc)

#This gives an error, unexpected return.  so the proc defined outside a method gives an error.

# # Group 3
# def check_return_with_lambda
#   my_lambda = lambda { return }
#   my_lambda.call
#   puts "This will be output to screen."
# end

# check_return_with_lambda

#Lambda defined in method does not return out of the method, outputs.

# # Group 4
# my_lambda = lambda { return }
# def check_return_with_lambda(my_lambda)
#   my_lambda.call
#   puts "This will be output to screen."
# end

# check_return_with_lambda(my_lambda)

#Lamba defined outside of method does not return out of method.  Like Lambad is it's own universe.

# Group 5
def block_method_3
  yield
end

block_method_3 { return }

#Seing a block to the method caused an error.  This makes sense since Procs did it too.