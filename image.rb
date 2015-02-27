require 'RMagick'
require 'color_namer'
require 'net/http'
require 'tempfile'

class ImageProcess

  def initialize(url)
    @uri = URI(url)
    @name = @uri.path.split('/').last
    @file = Net::HTTP.start(@uri.host, @uri.port) do |http|
      resp = http.get(@uri.path)
      file = Tempfile.new(@name, Dir.tmpdir, 'wb+')
      file.write(resp.body)
      file.flush
      file
    end
  end

  def get_colors
    files = {}

    img = Magick::Image.read(@file.path).first
    img.resize_to_fit!(250)
    quantized = img.quantize(128)
    img.destroy!

    colors_hash = {}

    quantized.color_histogram.each_pair do |pixel, frequency| # grab list of colors and frequency
      html = pixel.to_color(Magick::AllCompliance, false, 8, true)
      shade = ColorNamer.name_from_html_hash(html).last # get shade of the color

      # group the colors by shade
      if colors_hash[shade].nil?
        colors_hash[shade] = { frequency: frequency.to_i, html: html }
      else
        colors_hash[shade][:frequency] += frequency.to_i
      end
    end

    quantized.destroy! # prevent memory leaks

    # normalize color frequency to percentage
    sum = colors_hash.inject(0){ |s,c| s + c.last[:frequency].to_i }.to_f
    colors_hash.map{ |c|  c.last[:frequency] = (c.last[:frequency].to_f / sum * 100).round; c }

    files[@name] = Hash[colors_hash.sort_by { |k,v| -v[:frequency] }]
  end

end
