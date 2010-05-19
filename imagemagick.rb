pkg 'imagemagick' do
  installs {
    via :brew, 'imagemagick'
  }
  provides 'convert'
end

gem 'rmagick' do
  requires 'imagemagick'
end
