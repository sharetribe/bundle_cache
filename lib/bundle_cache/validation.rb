module BundleCache
  extend self

  def verify_env
    deprecation_warning

    %w(AWS_S3_BUCKET BUNDLE_ARCHIVE).each do |var|
      abort("Missing ENV[#{var}]") unless ENV[var]
    end

    if aws_credentials_missing?
     puts "WARNING: Missing AWS credentials"
     puts "You can not upload a new version of the archive"
   end
  end

  def aws_credentials_missing?
    (session_token_missing? && access_keys_missing?)
  end

  def session_token_missing?
    ENV['AWS_SESSION_TOKEN'].nil?
  end

  def access_keys_missing?
    ENV['AWS_ACCESS_KEY_ID'].nil? || ENV['AWS_SECRET_ACCESS_KEY'].nil?
  end

  def deprecation_warning
    if !!ENV['AWS_S3_KEY']
      puts "The 'AWS_S3_KEY' environment variable is deprecated and will be removed in the future."
      puts "Please set 'AWS_ACCESS_KEY_ID' instead"
      ENV['AWS_ACCESS_KEY_ID'] = ENV['AWS_S3_KEY']
    end

    if !!ENV['AWS_S3_SECRET']
      puts "The 'AWS_S3_SECRET' environment variable is deprecated and will be removed in the future."
      puts "Please set 'AWS_SECRET_ACCESS_KEY' instead"
      ENV['AWS_SECRET_ACCESS_KEY'] = ENV['AWS_S3_SECRET']
    end

    if !!ENV['AWS_S3_REGION']
      puts "The 'AWS_S3_REGION' environment variable is deprecated and will be removed in the future."
      puts "Please set 'AWS_DEFAULT_REGION' instead"
      ENV['AWS_DEFAULT_REGION'] = ENV['AWS_S3_REGION']
    end
  end

end
