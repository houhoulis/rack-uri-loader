ActionController::Routing::Routes.draw do |map|
  map.root :controller => "tommy_boy", :action => "index"
  map.connect 'more', :controller => "tommy_boy", :action => "more"
  map.connect 'ebay', :controller => "tommy_boy", :action => "ebay"
  map.connect 'mcr', :controller => "tommy_boy", :action => "mcr"
end
