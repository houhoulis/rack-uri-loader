require 'nokogiri'
require 'open-uri'

module Rack

	class ExternalURILoader

    def initialize(app, options = {}) #:nodoc:
      # options = { :method => "text_plain" || "http_header" || default = "env" }
      @app = app
      @method = options[:method]
    end

    def call(env) #:nodoc:
      @request = Rack::Request.new(env)
      puts "pre app call: "
#      puts @body.body.to_s if @body && @body.body
      puts @body.body.to_s if rails_response?
      status, @headers, @body = @app.call(env)
      puts "post app call: "
#      puts @body.body.to_s if @body && @body.body
      puts @body.body.to_s if rails_response?
      puts

      if !@method || ( @method == "env" ) # default
        if rails_response? && ENV_loader_param?
          uri = ENV.delete('URI_Loader_Param')
          fetched_string = Nokogiri::HTML(open(uri))
          @body.body = fetched_string.to_html
        end
      elsif @method == "http_header"
        if rails_response? && uri_loader_header?
          fetched_string = Nokogiri::HTML(open(@headers['URI-Loader-Param']))
          @body.body = fetched_string.to_html
          @headers.delete('URI-Loader-Param')
        end
      elsif @method == "text_plain"
        if rails_response? && text_response?
          uri = @body.body.to_s
          fetched_string = Nokogiri::HTML(open(uri))
          @body.body = fetched_string.to_html
          @headers['Content-Type'] = 'text/html'
        end
      else
        raise 'If you use rack-uri-loader with a :method option, it must ' +
          'be either "env", "http_header", or "text_plain".  You passed in "' +
          @method.to_s + '".'
      end
      update_content_length
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

    def uri_loader_header?
      @headers["URI-Loader-Param"]
    end

    def text_response?
      @headers["Content-Type"].include?("text/plain")
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