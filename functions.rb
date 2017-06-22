require 'readline'
require 'date'

def query_user_for_date_range
	start_date = nil
	end_date = nil
	puts "\n First , we need a start date."
	start_date = query_user_for_date
	puts "\n Next we need an end date"
	end_date = query_user_for_date
	return start_date,end_date
end

def query_user_for_date
	date = nil
	until date.is_a? Date
		prompt = "please enter a date as YYYY-MM-DD: "
		response = Readline.readline(prompt,true)
		exit if [ 'quit', 'exit','q','x'].include?(response)
		begin
			date = Date.parse(response)
		rescue ArgumentError
			puts "\n Invalid date format."
		end
	end
	return date
end
