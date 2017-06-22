require 'readline'
require 'date'
require 'open-uri'

DATA_START_DATE = '2006-09-20'
MAX_DAYS = 7

READING_TYPES = {
 
	"Wind_Speed" => "Wind Speed",
	"Air_Temp" => "Air Temp",
	"Barometric_Press" => "Pressure"
}

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

# Retriving Remote Data

def get_reading_from_remote_for_dates(type,start_date,end_date)
	readings = []
	start_date.upto(end_date) do |date|
	readings += get_readings_from_remote(type,date)
	end
	return readings
end

def get_readings_from_remote(type,date)
	raise "Invalid Reading Type" unless
			READING_TYPES.keys.include?(type)
	base_url = "http://lpo.dt.navy.mil/data/DM"
	url = "{base_url}/#{data.year}/#{date.strftime("%Y_%m_%d")}/#{type}"
	puts "Retrieving: #{url}"
	data = open(url).readlines
	  	
	readings = data.map do |line|
		line_items.chomp.split(" ")
		reading = line_items[2].to_f
	end
	return readings
end


def mean(array)
total = array.inject(0) { | sum, x| sum += x}
return total.to_f / array.length
end
 
 
 
	 	 	
def median(array)
	array.sort!
	length = array.length
	if length %2 == 1
		return array[length/2]
	else
		item1 = array[length/2 – 1]
		item2 = array[length/2]
		return mean([item1,item2])
	end
end
 
 
 
def retrieve_and_calculate_results(start_date,end_date)
	results = {}
READINGS_TYPES.each do |type,label|
readings = get_readings_from_remote_from_dates(type,start_date,end_date)
results[label] = {
:mean => mean(readings),
:median => mean(readings),
}
end
return results
end


def output_results_table()
	puts
	puts "___________________________"
	puts "| Type | Mean | Median | "
	puts "___________________________"
	results.each do |label,hash|
		print "| " + label.ljust(10) + " | "
		print sprintf("%.6f", hash[:mean]).rjust(10) + " | "
		puts sprintf("%.6f", hash[:median]).rjust(10) + " | "
	end
		puts " _______________________"
		puts
end


## API Methods 

def url_params_for_date_range
begin
	start_date = Date.parse(params[:start])
	end_date = Date.parse(params[:end])
rescue ArgumentError
halt "Invalid date format."
end
if !date_valid?(start_date)
halt "start date must be after #{DATA_START_DATE} and before today."
elsif !date_valid?(end_date)
halt "end date must be after #{DATA_START_DATE} and before today."
elsif !date_range_valid?(start_date,end_date)
halt "Invalid date range."
end
end