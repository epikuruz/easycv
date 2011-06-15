require 'rubygems'
require 'zipruby'
require 'nokogiri'
require 'fileutils'

module MyCV
  module ODF

    class ODFGenerator2

      def self.translate(xslt, template, xml, new_doc)
        new(xslt, template, xml, new_doc).translate()
      end

      def initialize(xslt, template, xml, new_doc)
        #Store the instance variables
        @xslt = xslt
        @template =template
        @xml = xml
        @new_doc = new_doc
      end

      def translate()
        puts "converting " + @template + ' to '+ @new_doc
        #get the existing document
        existing_xml = get_from_template("word/document.xml")
        #find the body node
        body_node = existing_xml.root.xpath("w:body", {"w" => "http://schemas.openxmlformats.org/wordprocessingml/2006/main"}).first
        #remove all current nodes on the body (ie clear doc)
        body_node.children.unlink
        #For each node on the new xml add it to the current xml.
        new_xml.xpath("*/w:body", {"w" => "http://schemas.openxmlformats.org/wordprocessingml/2006/main"}).first.children.each do |child|
          body_node.add_child(child)
        end
        #compress the result to a docx
        compress(existing_xml)
      end

      def get_from_template(filename)
        #retrieve the document from the template doc
        xml = Zip::Archive.open(@template) do |zipfile|
          zipfile.fopen(filename).read
        end
        #parse the resulting file into the Nokogiri xml doc
        Nokogiri::XML.parse(xml)
      end

      def new_xml
        #transform the xml values to fit out word document.
        stylesheet_doc.transform(Nokogiri::XML.parse(File.open(@xml)))
      end

      def compress(new_xml)
        #Copy the template to the new document
        FileUtils.copy(@template, @new_doc)
        #Open the zip archive
        Zip::Archive.open(@new_doc, Zip::CREATE) do |zipfile|
          #Replace the document.xml with our new xml
          zipfile.add_or_replace_buffer('word/document.xml', new_xml.to_s)
        end
      end

      def stylesheet_doc
        #Parse the xslt into the Nokogiri XSLT
        Nokogiri::XSLT.parse(File.open(@xslt))
      end
    end
  end
end