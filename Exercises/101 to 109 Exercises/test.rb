def merge(array1, array2)
  index2 = 0
  result = []

  array1.each do |value|
    while index2 < array2.size && array2[index2] <= value
      result << array2[index2]
      index2 += 1
    end
    result << value
  end

  result.concat(array2[index2..-1])
end



def merge_sort(array)
  finished_array = []
  if array.size > 1
    cut = array.size / 2
    array1, array2 = array[0..cut], array[cut+1..-1]
  end




    if array1.size > 1 
      merge_sort(array1)
    elsif array2.size > 1
      merge_sort(array2)
    else
      finished_array.concat(merge(array1, array2))
    end
  finished_array
end


def merge_sort(array)
  return array if array.size <= 1
  cut = (array.size / 2) - 1
  array1, array2 = array[0..cut], array[cut+1..-1]
  merge(merge_sort(array1), merge_sort(array2))
end







puts merge_sort([9, 5, 7, 1]) == [1, 5, 7, 9]
puts merge_sort([5, 3]) == [3, 5]
puts merge_sort([6, 2, 7, 1, 4]) == [1, 2, 4, 6, 7]
puts merge_sort(%w(Sue Pete Alice Tyler Rachel Kim Bonnie)) == %w(Alice Bonnie Kim Pete Rachel Sue Tyler)
puts merge_sort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]) == [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]
