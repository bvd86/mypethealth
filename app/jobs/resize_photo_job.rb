require 'tmpdir'
require 'fileutils'

class ResizePhotoJob < ApplicationJob
  queue_as :default

  def perform(object_class, object_id, attachment_attribute, max_width = 120, max_height = 120)
    object = object_class.constantize.find_by(id: object_id)

    return unless object and object.send(attachment_attribute).attached?

    blob = object.send(attachment_attribute).blob
    new_data = nil

    blob.open do |temp_file|
      path = temp_file.path
      pipeline = ImageProcessing::MiniMagick.source(path)
        .resize_to_limit(max_width, max_height)
        .call(destination: path)

      ImageOptim.new.optimize_image!(path)

      new_data = File.binread(path)
    end

    object.send(attachment_attribute).attach io: StringIO.new(new_data), filename: blob.filename.to_s
  end
end
