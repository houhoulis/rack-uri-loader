require File.join(File.dirname(__FILE__), 'rack-plastic')
#require 'rack-plastic'

# This middleware converts the text of every paragraph to leetspeak.
#
module Rack
  class L337 < Plastic
 
    def change_nokogiri_doc(doc)
      doc.css("p").each do |p|
        p.traverse do |node|
          if node.text?
            l337_text = node.content.upcase.tr('ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                                               '48CD3F6H1JKLMN0P9R57UVWxY2')
            update_text(node, l337_text)
          end
        end
      end
      doc
    end
    
  end
end
