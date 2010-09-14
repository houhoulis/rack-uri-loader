ActionController::Routing::Routes.draw do |map|
  map.root :controller => "tommy_boy", :action => "index"
  map.connect 'more', :controller => "tommy_boy", :action => "more"
  map.connect 'ebay', :controller => "tommy_boy", :action => "ebay"
  map.connect 'mattknox', :controller => "tommy_boy", :action => "mattknox"
  map.connect 'headers', :controller => "tommy_boy", :action => "headers"
  map.connect 'env', :controller => "tommy_boy", :action => "env"
end
