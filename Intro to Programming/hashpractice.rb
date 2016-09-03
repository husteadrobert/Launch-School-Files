family = { uncles: ["bob", "joe", "steve"],
			sisters: ["jane","jill", "beth"],
			brothers: ["frank", "rob", "david"],
			aunts: ["mary", "sally", "susan"]
		}


new_array = family.select { |key| key == :sisters || key == :brothers}

printout = new_array.values.flatten

p printout


