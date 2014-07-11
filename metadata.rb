name             "quagga"
maintainer       "Bao Nguyen"
maintainer_email "ngqbao@gmail.com"
license          "All rights reserved"
description      "Generic Quagga cookbook"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

%w{ }.each do |i|
  depends i
end
