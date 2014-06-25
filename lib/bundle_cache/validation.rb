module BundleCache
  extend self

  def verify_env
    required_env = %w(AWS_S3_KEY AWS_S3_SECRET AWS_S3_BUCKET BUNDLE_ARCHIVE)

    required_env.each do |var|
      unless ENV[var]
        puts "Missing ENV[#{var}]"
        exit 1
      end
    end
  end

end
