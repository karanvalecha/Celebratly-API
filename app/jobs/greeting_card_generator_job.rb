class GreetingCardGeneratorJob
  require "pdfkit"
  
  def perform
    kit = PDFKit.new(<<-HTML)
      <!DOCTYPE html>
      <style>
        body {
          background-color: #05a1a1;
        }

        .birthday-card {
          display: block;
          margin-left: auto;
          margin-right: auto;
          text-align: center;
          margin: auto;
          width: 50%;
          border: 3px solid green;
          padding: 10px;
          max-width: 600px;
          background-color: white;
          box-shadow: 0 24px 40px -8px #311B92;
          width: 100%;
          height: 100%;
        }

        .birthday-card img {
          width: 100%;
        }

        .page-break {
          page-break-after: always;
        }

        .page-break:last-child {
          page-break-after: avoid;
        }
      </style>

      <body>
        <div class="birthday-card page-break">
          <img src="https://image.freepik.com/free-vector/surprise-theme-happy-birthday-card-illustration_1344-199.jpg" alt="Birthday image">
          <h1>Happy Birthday. Hope you are having a great day.</h1>          
          <h3>from Pooja</h3>
        </div>
        <div class="birthday-card page-break">
          <img src="https://picsum.photos/200" alt="Birthday image">
          <h1>Happy Birthday. Hope you are having a great day.</h1>          
          <h3>from Karan</h3>
        </div>
        <div class="birthday-card page-break">
          <img src="https://picsum.photos/200" alt="Birthday image">
          <h1>Happy Birthday. Hope you are having a great day.</h1>          
          <h3>from Karan</h3>
        </div>
      </body>
    HTML

    kit.to_file("happy_birthday2.pdf")
  end
end
