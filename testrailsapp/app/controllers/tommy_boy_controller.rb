class TommyBoyController < ApplicationController
  
  def index
  end

  def more
  end

  def text
    render :text => 'This is the "text" controller -- not a static file.'
  end

  def text_plain
    render :text => "http://mattknox.com", :content_type => "text/plain"
  end

  def headers
    response.headers.merge!('URI-Loader-Param' => 'http://flickr.com')
  end

  def env
    ENV['URI_Loader_Param'] = 'http://flickr.com'
  end

end
