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
      puts 'puts ENV["URI_Loader_Param"]:'
      puts ENV["URI_Loader_Param"]
      
      if rails_response? && ENV_loader_param?
        fetched_string = Nokogiri::HTML(open(ENV["URI_Loader_Param"]))
        @body.body = fetched_string.to_html
        update_content_length
      end
      [status, @headers, @body]
    end

    def rails_response?
      (@body.class.name == "ActionController::Response" ||
        @body.class.name == "ActionDispatch::Response") &&
        @body.body
    end

    def ENV_loader_param?
      ENV["URI_Loader_Param"]
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