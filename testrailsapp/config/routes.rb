ActionController::Routing::Routes.draw do |map|
  map.root :controller => "tommy_boy", :action => "index"
  map.connect 'more', :controller => "tommy_boy", :action => "more"
  map.connect 'ebay', :controller => "tommy_boy", :action => "ebay"
  map.connect 'ebay2', :controller => "tommy_boy", :action => "ebay2"
  map.connect 'mcr', :controller => "tommy_boy", :action => "mcr"
  map.connect 'mattknox', :controller => "tommy_boy", :action => "mattknox"
  map.connect 'env', :controller => "tommy_boy", :action => "env"
end
