module BundleCache
  extend self

  def verify_env
    required_env = %w(AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_S3_BUCKET BUNDLE_ARCHIVE)

    required_env.each do |var|
      abort("Missing ENV[#{var}]") unless ENV[var]
    end
  end

end
