CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['aws_access_key_id'],
    aws_secret_access_key: ENV['aws_secret_access_key'],
    region:                'us-east-2',
    host:                  's3.example.com',
    endpoint:              'https://s3.us-east-2.amazonaws.com'
  }
  config.fog_directory  = ENV['aws_bucket']
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog
    config.enable_processing = true
  end
end