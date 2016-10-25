# Boolean Assertions
assert_equal(true, value.odd?)

# Equality Assertions
assert_equal('XYZ', value.downcase)

# Nil Assertions
assert_nil(value)

# Empty Object Assertions
assert_equal(true, value.empty?)
assert_empty(value)

# Included Object Assertions
assert_includes(value, 'xyz')

# Exception Assertions
assert_raises(NoExperienceError) { employee.hire }
assert_raises NoExperienceError do
  employee.hire
end

# Type Assertions
assert_instance_of(Numeric, value)

# Kind Assertion
assert_kind_of(Numberic, vavlue)

# Same Object Assertions
assert_same(list, list.process)

# Refutations
refute_includes(list, 'xyz')