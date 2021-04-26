class Occurrences::PublishController < ApplicationController
  before_action do
    @occurrence = Occurrence.find(params[:occurrence_id])
  end

  def show
    config = JSON.parse(File.read('config/videoshow.json'))
    config[:images] = []
    json_file = Tempfile.new
    image_files = []

    images = @occurrence.status_uploads.image.map do |st|
      img = MiniMagick::Image.open(st.image_upload.url)
      tmp_file = Tempfile.new
      img.format 'png'
      image_files << tmp_file
      img.write tmp_file.path
      config[:images] << tmp_file.path
    end

    json_file.write(config.to_json)
    json_file.rewind

    output_file = "#{@occurrence.slug}.mp4"

    `./node_modules/videoshow/bin/videoshow -c #{json_file.path} --audio app/assets/audios/Happy-Birthday-to-you-Singing-Bell.mp3 -o #{output_file} --debug`

    @occurrence.published_video.attach(
      io: File.open(output_file),
      filename: output_file
    )

    render 'occurrences/show'
  end
end
