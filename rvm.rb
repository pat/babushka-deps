dep 'rvm' do
  helper(:path) {
    '~/.rvm/scripts/rvm'
  }
  
  met? {
    path.p.file?
  }
  meet {
    # Install from Github using provided script
    shell 'bash -c "`curl http://rvm.beginrescueend.com/releases/rvm-install-head`"'
    
    shell 'bash -c "source ~/.rvm/scripts/rvm; rvm notes"'
    
    # Make sure RVM is always loaded by bash
    profile = Dir["~/.bash_profile", "~/.bashrc"].first || "~/.bash_profile"
    shell "echo 'if [[ -s \"$HOME/.rvm/scripts/rvm\" ]]  ; then source \"$HOME/.rvm/scripts/rvm\" ; fi' >> #{profile}"
  }
end

dep 'fish rvm' do
  requires 'fish', 'rvm'
  
  helper(:github) {
    'http://github.com/eventualbuddha/fish-nuggets/raw/master/functions'
  }
  helper(:functions) {
    '~/.config/fish/functions'
  }
  helper(:rvm_env) {
    functions / '__bash_env_to_fish.fish'
  }
  helper(:rvm_fish) {
    functions / 'rvm.fish'
  }
  helper(:cd_fish) {
    functions / 'cd.fish'
  }
  
  met? {
    rvm_env.file?
  }
  meet {
    shell "curl --create-dirs -o #{rvm_env} #{github}/__bash_env_to_fish.fish"
    shell "curl -o #{rvm_fish} #{github}/rvm.fish"
    shell "curl -o #{cd_fish} #{github}/cd.fish"
  }
end

dep 'rvm_ruby' do
  helper(:path) { '/usr/local/bin/rvm_ruby' }
  met? {
    path.p.file?
  }
  meet {
    render_erb 'rvm/rvm_ruby', :to => path, :sudo => true
  }
end
