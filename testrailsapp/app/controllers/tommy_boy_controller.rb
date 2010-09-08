class TommyBoyController < ApplicationController
  
  def index
  end

  def more
  end

  def ebay
    render :text => 'This is the controller -- not ebay_html static file.',
      :content_type => 'text/plain'
  end

  def mattknox
    render :text => "http://mattknox.com", :content_type => "text/plain"
  end

  def env
    ENV['URI_Loader_Param'] = 'http://flickr.com'
  end

end
