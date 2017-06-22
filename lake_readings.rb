require_relative('functions')

puts "\n*** Lake Readings ***"
puts "Calculates the mean and median of the wind speed air temperature,"
puts "\n*** and barometric pressure recorded at the Deep Moor Station"
puts "on Lake Readings given range of dates."

start_date, end_date = query_user_for_date_range

results = retrieve_and_calculate_results(start_date,end_date)
output_results_table(results)
