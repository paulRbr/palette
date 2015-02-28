require 'sinatra/base'
require 'grape'
require 'json'
require File.dirname(__FILE__)+'/image'

module Palette
  class Api < Grape::API
    format :json

    resource :colors do
      desc 'Creates an image color histogram given an url or an image file'
      params do
        optional :url, type: String
        optional :file
      end
      post do
        if params[:url]
          ImageProcess.new(params[:url], remote: true).get_colors
        elsif params[:file]
          File.open('uploads/' + params[:file][:filename], "w") do |f|
            f.write(params[:file][:tempfile].read)
          end
          ImageProcess.new("uploads/#{params[:file][:filename]}").get_colors
        end
      end
    end
  end

  class Web < Sinatra::Base
    get '/' do
      File.read(File.join('public', 'index.html'))
    end
  end
end
