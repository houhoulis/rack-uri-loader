class TommyBoyController < ApplicationController
  
  def index
  end

  def more
  end

  def ebay
#    render :text => proc{|resp,output| 1.times {|i| output.write("ebay." + "html")}}, :content_type => "text/plain"
    render :text => 'This Is The Controller.  not ebay_html.' # , :content_type => 'text/plain'
  end

  def ebay2
#    render :text => proc{|resp,output| 1.times {|i| output.write("ebay." + "html")}}, :content_type => "text/plain"
#    render :text => 'ebay.html' # , :content_type => 'text/plain'
    render :text => "I biting FROM CONTROLLER e-bay-2-html", :content_type => 'text/plain'
  end

  def mattknox
    render :text => "http://mattknox.com", :content_type => "text/plain"
  end

  def mcr
    render :text => "http://masscomputerrelief.com",
      :content_type => "text/plain"
  end

  def env
    ENV['URL_Loader_Param'] = 'http://masscomputerrelief.com'
  end

end
