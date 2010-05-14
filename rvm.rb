dep 'rvm' do
  helper :path do
    '~/.rvm/scripts/rvm'
  end
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
