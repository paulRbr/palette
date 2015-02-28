require File.dirname(__FILE__)+'/api'

map '/' do
  run Rack::Cascade.new [Palette::Api, Palette::Web]
end
