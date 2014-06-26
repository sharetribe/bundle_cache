module BundleCache
  extend self

  def verify_env
    %w(AWS_S3_BUCKET BUNDLE_ARCHIVE).each do |var|
      abort("Missing ENV[#{var}]") unless ENV[var]
    end

    abort("Missing required AWS credentials") if (session_token_missing? && access_keys_missing?)
  end

  def session_token_missing?
    ENV['AWS_SESSION_TOKEN'].nil?
  end

  def access_keys_missing?
    ENV['AWS_ACCESS_KEY_ID'].nil? || ENV['AWS_SECRET_ACCESS_KEY'].nil?
  end

end
