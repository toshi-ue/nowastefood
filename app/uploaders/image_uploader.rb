# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  if Rails.env.production?
    include Cloudinary::CarrierWave
    CarrierWave.configure do |config|
      config.cache_storage = :file
    end
  else
    include CarrierWave::MiniMagick
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

  def size_range
    1..10.megabytes
  end

  process convert: 'jpg'
  process resize_to_fit: [400, 400]

  def extension_allowlist
    %w[jpg jpeg gif png]
  end

  def filename
    "#{secure_token}.jpg" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
