dep 'imagemagick', :template => 'managed' do
  installs {
    via :brew, 'imagemagick'
  }
  provides 'convert'
end

dep 'rmagick', :template => 'gem' do
  requires 'imagemagick'
end
