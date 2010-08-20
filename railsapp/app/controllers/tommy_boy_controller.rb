class TommyBoyController < ApplicationController
  
  def index
  end

  def more
  end

  def ebay
#    render :text => proc{|resp,output| 1.times {|i| output.write("ebay." + "html")}}, :content_type => "text/plain"
    render :text => 'ebay.html' # , :content_type => 'text/plain'
  end

  def mcr
    render :text => "http://mattknox.com", :content_type => "text/plain"
  end

end
