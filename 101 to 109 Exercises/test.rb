def center_of(string)
  if string.length.odd?
    return string[(string.length / 2)]
  else
    value1 = string[(string.length / 2) - 1]
    value2 = string[(string.length / 2)]
    return "#{value1}#{value2}"
  end
end











 puts   center_of('I love ruby') == 'e'
 puts   center_of('Launch School') == ' '
 puts   center_of('Launch') == 'un'
puts    center_of('Launchschool') == 'hs'
 puts   center_of('x') == 'x'