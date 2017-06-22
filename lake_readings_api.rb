require_relative('functions')
require 'sinatra'
require 'json'
#localhost:4567
get '/' do
text = "<h1> **** LAKE Readings API</h1>"
text << "<p>Submit a request a request as
'readings?start=2014-01-01&end=2014-01-03'</p>"
erb text
end
get '/readings' do
start_date,end_date = url_params_for_date_range
results = retrieve_and_calculate_results(start_date,end_date)
	content_type :json
	erb results.to_json
end
not_found do
	erb "Page not found"
end
