class ProfileImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  process convert: 'jpg'
  process resize_to_fit: [100, 100]

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

  def size_range
    0..10.megabytes
  end

  def content_type_allowlist
    /image\//
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
