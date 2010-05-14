dep 'rvm' do
  met? {
    which 'rvm'
  }
  meet {
    # Install from Github using provided script
    shell 'bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )'
    
    shell 'bash -c "source ~/.rvm/scripts/rvm"'
    shell 'bash -c "rvm notes"'
    
    # Make sure RVM is always loaded by bash
    profile = Dir["~/.bash_profile", "~/.bashrc"].first || "~/.bash_profile"
    shell "echo 'if [[ -s \"$HOME/.rvm/scripts/rvm\" ]]  ; then source \"$HOME/.rvm/scripts/rvm\" ; fi' >> #{profile}"
  }
end
