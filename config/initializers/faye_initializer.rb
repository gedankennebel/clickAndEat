Thread.new do
  puts 'Starting faye at port 9292...'
  system("rackup faye.ru -s thin -E production")
end