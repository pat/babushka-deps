dep 'jekyll', :template => 'gem' do
  requires 'pygments'
end

dep 'pygments' do
  met? { which 'pygmentize' }
  meet { shell 'easy_install Pygments' }
end
