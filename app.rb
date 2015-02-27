require 'rack/parser'
require 'sinatra/base'
require 'sinatra/json'
require 'json'
require File.dirname(__FILE__)+'/image'

class App < Sinatra::Base
  helpers Sinatra::JSON

  use Rack::Parser, :parsers => {
    'application/json' => proc { |data| JSON.parse data }
  }

  get '/' do
    File.read(File.join('public', 'index.html'))
  end

  post '/colors' do
    ImageProcess.new(params[:url]).get_colors.to_json
  end
end
