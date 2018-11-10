require 'sinatra'
require 'json'

restaurants = [
	{"id" => "0", "name" => "Mica", "visited" => true},
	{"id" => "1", "name" => "La Quiche", "visited" => false},
]

get '/restaurants' do
	content_type :json
	restaurants.to_json
end

put '/restaurant/:id' do
	content_type :json
	id = params['id'].to_s
	body_parameters = JSON.parse(request.body.read)
	visited = body_parameters['visited']
	
	restaurant = restaurants.select { |e| e['id'] == id }[0]
	return status 404 unless restaurant

	restaurant['visited'] = visited
	restaurants = restaurants.map { |e| e['id'] == id ? restaurant : e }
	restaurant.to_json
end