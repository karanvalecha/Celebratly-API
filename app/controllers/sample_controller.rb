class SampleController < ApplicationController
  DEFAULT_RESOLUTION = "450x720"
  def show
    folder_name = get_folder(Time.now.to_i)

    params[:text_statuses].each do |nested_param|
      create_jpg(folder_name, nested_param[:bg_color], nested_param[:msg])
    end

    create_video(folder_name)

    send_file File.open("#{folder_name}/video.mp4")
  end

  def create_video(folder_name)
    slideshow_transcoder = FFMPEG::Transcoder.new(
      '',
      "#{folder_name}/video.mp4",
      { resolution: DEFAULT_RESOLUTION },
      input: "#{folder_name}/%*.jpg",
      input_options: { framerate: '1/5' }
    )

    slideshow = slideshow_transcoder.run
  end

  def create_jpg(folder_name, bg_color, msg)
    file = Tempfile.new(["test_temp", ".jpg"])

    MiniMagick::Tool::Convert.new do |i|
     i.size DEFAULT_RESOLUTION
     i.gravity "center"
     i.xc bg_color
     i.pointsize 26
     i.fill 'white'
     i.annotate '0,0', "#{msg}"
     i << file.path
    end

    image = MiniMagick::Image.open(file.path)

    image.combine_options do |i|
      i.gravity 'SouthEast'
      i.draw "text 10,10 '#{current_user.full_name}'"
      i << file.path
    end

    image.write(file.path)


    file_name = File.basename(file.path)

    FileUtils.mv file, "#{folder_name}/#{file_name}"  
  end

  def get_folder(folder_name)
    folder_path = Rails.root.join("tmp/#{folder_name}")
    FileUtils.mkdir_p folder_path
    folder_path.to_s
  end
end
