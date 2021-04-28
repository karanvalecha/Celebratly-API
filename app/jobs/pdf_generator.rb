require 'render_anywhere'

class PdfGenerator
  include RenderAnywhere

  def perform
    @occurrences = Occurence.all.to_a
    to_pdf
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file("#{Rails.root}/public/birthday.pdf")
  end

  private

  def as_html
    # render template: "pdf/birthday", locals: { occurrences: @occurrences }
    ActionController::Base.new.render_to_string(template: "pdf/birthday", locals: { occurrences: @occurrences })
  end
end