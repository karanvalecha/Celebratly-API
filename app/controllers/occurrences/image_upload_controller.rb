class Occurrences::ImageUploadController < ApplicationController
  before_action do
    @occurrence = Occurrence.find(params[:occurrence_id])
  end

  def create
    @status_upload = StatusUpload.image.new(occurrence: @occurrence, user: current_user)

    @status_upload.image_upload.attach(
      io: get_file,
      filename: "#{@occurrence.slug}:#{current_user.id}"
    )
    @status_upload.save!

    render 'status_uploads/show'
  end

  def index
    @status_uploads = @occurrence.status_uploads

    render 'status_uploads/index'
  end

  def destroy
    @status_upload = StatusUpload.image.find_or_initialize_by(occurrence: @occurrence, user: current_user)
    @status_upload.image_upload.purge
    @status_upload.destroy
    head 200
  end

  def get_file
    if params[:base64]
      StringIO.new(
        Base64.decode64(params[:base64])
      )
    else
      params[:file]
    end
  end
end
