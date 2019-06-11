class NumberToValidWord

	MAPPED_NUMBERS_TO_LETTERS = {"2" => ["a", "b", "c"],
								 "3" => ["d", "e", "f"],
								 "4" => ["g", "h", "i"],
								 "5" => ["j", "k", "l"],
								 "6" => ["m", "n", "o"],
								 "7" => ["p", "q", "r", "s"],
								 "8" => ["t", "u", "v"],
								 "9" => ["w", "x", "y", "z"]}
	
	def convert_number_to_valid_array_of_words(input_number)
		return "Please enter a valid number" if input_number.blank? || input_number.length < 10 

		@valid_words_dictionary = convert_the_dictionary_to_array()
		number_array = convert_input_to_array(input_number)
		array_of_characters = convert_array_of_numbers_to_array_of_characters(number_array)
		all_possible_combination_of_input = possible_combination_of_given_number(array_of_characters)
		p all_possible_combination_of_input
	end

	def convert_the_dictionary_to_array
    	valid_words_dictionary = []
    	file_path = "public/dictionary.txt"

   	 	File.foreach( file_path ) do |word|
      		valid_words_dictionary.push(word.chop.to_s.downcase)
   	 	end
   	 	valid_words_dictionary
	end

	def convert_input_to_array(input)
		number_array = input.split("")
	end

	def convert_array_of_numbers_to_array_of_characters(input_number)
		mapped_input_digits_to_letters_array = input_number.map{|digit| MAPPED_NUMBERS_TO_LETTERS[digit] }
	end

	#Find all possible combination of the words based on the keys
	#returns all possible combinations of INVALID words
	def possible_combination_of_given_number(array_of_characters)
		begin
      		possible_combinations_of_words = array_of_characters.shift.product(*array_of_characters).map(&:join)
		rescue TypeError
			return "Invalid entry. May contain either 1's or 0's. Please chech the input"
		end
		total_word_combination = get_meaningful_combination_of_words(possible_combinations_of_words)
		total_word_combination
	end

	#Loop to get minimum 3 letters words
	def get_meaningful_combination_of_words(possible_combinations_of_words)
		total_word_combination = []
		for i in 2..7 
			
			word_combinations = possible_combinations_of_words.map{|word| word[0..i]}
			shift_each_characters = possible_combinations_of_words.map{|word| word[i+1 ..-1]}
			track_word_combination_from_dictionary = @valid_words_dictionary & word_combinations
			track_shift_each_characters_from_dictionary = @valid_words_dictionary & shift_each_characters			
			total_word_combination << track_word_combination_from_dictionary
			total_word_combination << track_shift_each_characters_from_dictionary
		end
		total_word_combination
	end

end