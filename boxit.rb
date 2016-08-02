require 'sinatra'
require 'rubyserial'

serialport = Serial.new '/dev/ttyUSB0'

get '/' do
  erb :index
end

get '/pass' do
  serialport.write("O")
  "Pass"
end

get '/fail' do
  serialport.write("A")
  "Fail"
end

get '/switch_led/*/*' do |led_id, mode|
  led = led_id.to_i
  if led <= 10 && mode == "on" || mode == "off"
   if mode == "on"
     command = "L"+led_id+"1"
   else
     command = "L"+led_id+"0"
   end
   serialport.write(command)
   "Switching LED #{led_id} #{mode}"
  else 
   "Invalid values"
  end
end

get '/move_gauge_to/*' do |gauge_position|
  position = gauge_position.to_i
  if position >= 0  && position <= 255
    command = "G"+gauge_position
    serialport.write(command)
    "Setting gauge to position #{position}"
  else
    "Position #{position} is invald"
  end
end

get '/test' do
  serialport.write('T')
  "Test"
end
