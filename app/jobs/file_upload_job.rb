class FileUploadJob < ApplicationJob
  queue_as :default

  def perform(file_upload)
    file_upload.status = :in_progress
    file_upload.status = :processed
    file_upload.save!
  rescue
    file_upload.status = :failed
    file_upload.save
  end
end
