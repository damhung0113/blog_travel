class CkeditorPictureUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave
  include CarrierWave::MiniMagick

  storage :file
  def store_dir
    "uploads/ckeditor/pictures/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [Settings.uploaders.picture.thumb_w,
      Settings.uploaders.picture.thumb_h]
  end

  version :content do
    process resize_to_limit: [Settings.uploaders.picture.content,
      Settings.uploaders.picture.content]
  end

  def extension_white_list
    Ckeditor.image_file_types
  end
end
