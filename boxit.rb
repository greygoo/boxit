require 'sinatra'

get '/' do
  erb :index
end

get '/pass' do
  'Switching to green'
end

get '/fail' do
  'Switching to red'
end

get '/switch_led/*/*' do |led_id, mode|
  'Switching #{led_id} #{mode}'
end

get '/move_gauge_to/*' do |position|
  'Setting gauge to position #{position}'
end
