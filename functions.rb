require 'readline'
require 'date'

DATA_START_DATE = '2006-09-20'
MAX_DAYS = 7


def query_user_for_date_range
	start_date = nil
	end_date = nil
	until start_date && end_date
		puts "\n First , we need a start date."
		start_date = query_user_for_date
		puts "\n Next we need an end date"
		end_date = query_user_for_date
 
		if !date_range_valid?(start_date,end_date)
			puts "Let’s try again."
			start_date = end_date = nil
		end
	end
 
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
		date = nil  unless date_valid?(date)
	end
	return date
end


def date_valid?(date)
	valid_dates = Date.parse(DATA_START_DATE)..Date.today
	if valid_dates.cover?(date)
		return true
	else
		puts "\n Date must be after #{DATA_START_DATE} and before today."
		return false
	end
end


def date_range_valid?(start_date,end_date)
	 if start_date > end_date
		 puts "\n Start date must be before end date."
		 return false
	elseif start_date + MAX_DAYS < end_date
		puts "\n NO more than #{ MAX_DAYS} days"
		return false
	end
		return true
 
end

