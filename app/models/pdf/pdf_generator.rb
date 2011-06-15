begin
  require 'rubygems'
  require 'pdf/writer'
  require 'pdf/techbook'
  gem "i18n"
  gem "pdf-writer"
rescue LoadError => le
  if le.message =~ %r{pdf/writer$}
    $LOAD_PATH.unshift("../lib")
    require 'pdf/writer'
  else
    raise
  end
end

module MyCV
  class PDFGenerator





    def generate( cv, formatting_options, pdf_filename)
      pdf = PDF::Writer.new( :paper => formatting_options.paper_size  )
      pdf.select_font "Times-Roman"


      pdf.text( "<i>CURRICULUM VITAE</i>", :font_size => 48, :justification => :center )
      pdf.text("Hello: " +   I18n.translate("hello") , :font_size => 24, :justification => :left)
      pdf.text("Personal Info", :font_size => 24, :justification => :left)
      pdf.text("Firstname:" + cv.personal_data.firstname, :font_size => 12, :justification => :left)
      pdf.text("Lastname:" + cv.personal_data.lastname, :font_size => 12, :justification => :left)
      pdf.text("Date of birth:" + cv.personal_data.birth_date, :font_size => 12, :justification => :left)
      pdf.save_as(pdf_filename)
      xxx()
    end


    def xxx()
text = <<TEXT

1<Level 1>
2<Level 2>
3<Level 3>
4<Level 4>


.code
pdf = PDF::Writer.new
pdf.select_font "Times-Roman"
pdf.text "Hello Ruby", :font =>14, :justification => :left
pdf.save_as("e:/hello_ruby.pdf")
.endcode

.blist disc
Line item 1 with disc
.endblist
.blist disc
Line item 2 with disc
.endblist
.blist disc
Line item 3 with disc
.endblist

.blist bullet
Line item 1 with bullet
.endblist
.blist bullet
Line item 2 with bullet
.endblist
.blist bullet
Line item 3 with bullet
.endblist

.pre
       Pre line 1
       Pre line 2
.endpre
TEXT

pdf = PDF::TechBook.new
pdf.select_font "Times-Roman"
pdf.text "Hello Ruby\n", :font =>18, :justification => :left
pdf.techbook_parse text
pdf.save_as("hello_ruby.pdf")
    end
  end
end

