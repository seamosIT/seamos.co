CarrierWave.configure do |config|

  if Rails.env.production? || Rails.env.staging?
    config.fog_credentials = {
      :provider               => "AWS",
      :region                 => 'us-east-1',
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY']
    }

  	# config.root = Rails.root.join('tmp')
  	config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.fog_directory  = 'document-photos-seamos'
  end
end
