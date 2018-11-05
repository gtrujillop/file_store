class FileUploadsController < ApplicationController
  before_action :set_file_upload, only: :create
  
  # POST create
  def create
    # FileUploadJob.perform_later @file_upload if @file_upload.save
    @file_upload.status = :uploaded
    @file_upload.save!
    status = @file_upload.valid? ? :ok : :unprocessable_entity
    render json: { file_upload: @file_upload, errors: @file_upload.errors.messages }, status: status
  end

  # GET index
  def index
    raise ActionController::BadRequest.new("Required params not present") unless (params[:tag_search_query] && params[:page])
    file_uploads = FileUpload.by_tags(URI.decode(params[:tag_search_query]))
                             .paginate(page: params[:page], per_page: 10)
    render json: { file_uploads: file_uploads, records: file_uploads.count }, status: file_uploads.present? ? :ok : :not_found
  end

  private

  def set_file_upload
    @file_upload = FileUpload.new(file_upload_params)
    @file_upload.status = :initiated
  end
  
  def file_upload_params
    params.require(:file_upload).permit(
      :uuid, 
      :file_name, 
      :status, 
      tag_list: []
    )
  end
end