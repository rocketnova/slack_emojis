# Modified from https://gist.github.com/lmarkus/8722f56baf8c47045621?permalink_comment_id=4020434#gistcomment-4020434

# Use unbuffered output of `puts` to get real time verbose logging in docker logs.
$stdout.sync = true

require 'httparty'
require 'json'
file = File.read('./emojis.json')
data_hash = JSON.parse(file)

data_hash['emoji'].each do |emoji|
  url = emoji['url']
  extension = url.split('.').last
  filename = "#{emoji['name']}.#{extension}"
  File.open("output/#{filename}", "w") do |file|
    file.binmode
    # Rescue any network errors, log the issue, and continue to the next item.
    begin
      HTTParty.get(url, stream_body: true) do |fragment|
        file.write(fragment)
      end
      # Verbose logging.
      puts "exported #{filename}"
    rescue => e
      puts e
      puts "Manually download using: curl -o #{filename} #{url}"
      next
    end
  end
end

# Signal happy ending.
puts "Done!"
