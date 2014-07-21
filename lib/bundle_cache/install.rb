require "digest"
require "open-uri"

module BundleCache
  def self.install
    architecture = `uname -m`.strip
    file_name = "#{ENV['BUNDLE_ARCHIVE']}-#{architecture}.tgz"
    digest_filename = "#{file_name}.sha2"
    bucket_name = ENV["AWS_S3_BUCKET"]
    bundle_dir = ENV["BUNDLE_DIR"] || "~/.bundle"
    processing_dir = ENV['PROCESS_DIR'] || ENV['HOME']

    gem_archive = open("https://#{bucket_name}.s3.amazonaws.com/#{file_name}")
    hash_object = open("https://#{bucket_name}.s3.amazonaws.com/#{digest_filename}")

    puts "=> Downloading the bundle"
    File.open("#{processing_dir}/remote_#{file_name}", 'wb') do |file|
      file << gem_archive.read
    end
    puts "  => Completed bundle download"

    puts "=> Extract the bundle"
    `cd #{File.dirname(bundle_dir)} && tar -xf "#{processing_dir}/remote_#{file_name}"`

    puts "=> Downloading the digest file"
    File.open("#{processing_dir}/remote_#{file_name}.sha2", 'wb') do |file|
      file << hash_object.read
    end
    puts "  => Completed digest download"

    puts "=> All done!"
  rescue OpenURI::HTTPError
    puts "There's no such archive!"
  end

end
