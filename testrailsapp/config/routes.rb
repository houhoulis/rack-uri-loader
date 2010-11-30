ActionController::Routing::Routes.draw do |map|
  map.root :controller => "tommy_boy", :action => "index"
  map.connect 'more', :controller => "tommy_boy", :action => "more"
  map.connect 'text', :controller => "tommy_boy", :action => "text"
  map.connect 'text_plain', :controller => "tommy_boy", :action => "text_plain"
  map.connect 'headers', :controller => "tommy_boy", :action => "headers"
  map.connect 'env', :controller => "tommy_boy", :action => "env"
end
