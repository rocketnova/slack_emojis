require 'httparty'
require 'json'
file = File.read('./emojis.json')
data_hash = JSON.parse(file)

data_hash['emoji'].each do |emoji|
  url = emoji['url']
  extension = url.split('.').last
  filename = "output/#{emoji['name']}.#{extension}"
  File.open(filename, "w") do |file|
    file.binmode
    HTTParty.get(url, stream_body: true) do |fragment|
      file.write(fragment)
    end
  end
end
