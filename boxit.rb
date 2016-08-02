require 'sinatra'
require 'rubyserial'

serialport = Serial.new '/dev/ttyUSB0'

get '/' do
  erb :index
end

get '/pass' do
  'Pass'
  serialport.write('O')
end

get '/fail' do
  'Fail'
  serialport.write('A')
end

get '/switch_led/*/*' do |led_id, mode|
  led = led_id.to_i
  if led <= 10 && mode == "on" || mode == "off"
   "Switching LED #{led_id} #{mode}"
   if mode == "on"
     command = "L"+led_id+"1"
   else
     command = "L"+led_id+"0"
   end
   command
   serialport.write(command)
  else 
   "Invalid values"
  end
end

get '/move_gauge_to/*' do |gauge_position|
  position = gauge_position.to_i
  if position >= 0  && position <= 255
    "Setting gauge to position #{position}"
    command = "G"+gauge_position
    serialport.write(command)
  else
    "Position #{position} is invald"
  end
end
