class TextStatusController < ApplicationController
  def show
    file = Tempfile.new(["test_temp", ".jpg"])

    MiniMagick::Tool::Convert.new do |i|
     i.size "450x500"
     i.gravity "center"
     i.xc params[:bg_color]
     i.fill 'white'
     i.pointsize '24'
     i.annotate '0,0', "#{params[:msg]} \n - #{current_user.full_name}"
     i << file.path
    end

    render file: file.path
  end
end
