class OccurrenceVideoCreator < ApplicationJob
  attr_reader :occurrence

  def initialize(occurrence)
    @occurrence = occurrence
  end

  def birthday_audio
    'app/assets/audios/Happy-Birthday-to-you-Singing-Bell.mp3'
  end

  def random_audio
    [
      'app/assets/audios/celeb_whistle_1.mp3',
      'app/assets/audios/celeb_whistle_2.mp3',
      'app/assets/audios/celeb_3.mp3',
      'app/assets/audios/celeb_4.mp3',
    ].sample
  end

  def audio_path
    if occurrence.event.birthday?
      birthday_audio
    else
      random_audio
    end
  end

  def intro_image
    if occurrence.event.birthday?
      'app/assets/images/template_birthday.png'
    elsif occurrence.event.work_anniversary?
      'app/assets/images/template_anniversary.png'
    end
  end

  def template_end_image
    'app/assets/images/template_end.png'
  end

  def logo_path
    'app/assets/images/small_logo.png'
  end

  def make_video
    config = JSON.parse(File.read('config/videoshow.json'))
    config[:images] = []
    json_file = Tempfile.new
    image_files = []

    image_files << intro_image

    @occurrence.status_uploads.each do |st|
      image_files << st.image_upload.url
    end

    image_files << template_end_image

    image_files.compact.each do |url|
      img = MiniMagick::Image.open(url)
      tmp_file = Tempfile.new
      img.format 'png'
      image_files << tmp_file
      img.write tmp_file.path
      config[:images] << tmp_file.path
    end

    json_file.write(config.to_json)
    json_file.rewind

    output_file = "#{@occurrence.slug}.mp4"

    `./node_modules/videoshow/bin/videoshow -c #{json_file.path} --audio #{audio_path} -o #{output_file} --logo #{logo_path} --debug`

    # for now it works only when uploading immediately after process
    @occurrence.published_video.attach(
      io: File.open(output_file),
      filename: output_file
    )

    output_file
  end
end