require_relative('functions')

puts "\n*** Lake Readings ***"
puts "Calculates the mean and median of the wind speed air temperature,"
puts "\n*** and barometric pressure recorded at the Deep Moor Station"
puts "on Lake Readings given range of dates."

start_date, end_date = query_user_for_date_range

# puts start_date.strftime('%B %d, %Y')
# puts end_date.strftime('%B %d, %Y')

# READING_TYPES.each do |type,label|
# readings = get_readings_from_remote_for_dates(type,start_date,end_date)
# puts "#{label}: " + readings.join(", ")
# end

results = retrieve_and_calculate_results(start_date,end_date)
puts results.inspect
