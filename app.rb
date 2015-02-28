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
    if params[:url]
      ImageProcess.new(params[:url], remote: true).get_colors.to_json
    elsif params['file']
      File.open('uploads/' + params['file'][:filename], "w") do |f|
        f.write(params['file'][:tempfile].read)
      end
      ImageProcess.new("uploads/#{params['file'][:filename]}").get_colors.to_json
    end
  end
end
