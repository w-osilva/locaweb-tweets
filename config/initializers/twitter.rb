file = File.join(Rails.root, 'config', 'twitter.yml')
content = ERB.new(File.read(file)).result
$twitter_config = YAML.load(content)[Rails.env].symbolize_keys