require 'nokogiri'
require 'open-uri'

module Rack

	class ExternalURILoader

    def initialize(app, options = {}) #:nodoc:
      @app = app
      @options = options
    end

    def call(env) #:nodoc
      @request = Rack::Request.new(env)
      status, @headers, @body = @app.call(env)
      if rails_response? && text_response?

        puts status.to_s + " ===== and headers #{@headers.to_s[0,180]},\n
          ========== @body.inspect.to_s[0,180] #{@body.inspect.to_s[0,180]}, and\n
          ========== @body.body.class #{@body.body.class}.\n"
        puts "===== @body.body.to_s == " + @body.body.to_s
        puts "===== fetched_doc is via URI."

        fetched_doc = open(@body.body)
        fetched_string = Nokogiri::HTML(doc_to_string(fetched_doc))
        @body.body = fetched_string.to_html
        @headers["Content-Type"] = "text/html"
        update_content_length
      end
      [status, @headers, @body]
    end

    def rails_response?
      (@body.class.name == "ActionController::Response" ||
        @body.class.name == "ActionDispatch::Response") &&
        @body.body
    end

    def text_response?
      @headers["Content-Type"] && @headers["Content-Type"].include?("text/plain")
    end

    def doc_to_string(doc)
      s = ""
      doc.each { |x| s << x }
			puts "s.class ===== #{s.class}"
			puts "s.inspect ===== #{s.inspect}"
      s
    end

    def update_content_length
      length = 0
      @body.each do |s|   # we can't use inject because @body may not respond to it
        length += Rack::Utils.bytesize(s)   # we use Rack::Utils.bytesize to avoid
                                            # incompatibilities between Ruby 1.8 and 1.9
      end
      @headers['Content-Length'] = length.to_s
    end
  end
end