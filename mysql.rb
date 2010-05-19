pkg 'mysql software' do
  installs {
    via :apt, %w[mysql-server libmysqlclient15-dev]
    via :brew, 'mysql'
  }
  provides 'mysql'
  
  helper(:brew_path) {
    Babushka::BrewHelper.brew_path_for('mysql')
  }
  helper(:plist) {
    'com.mysql.mysqld.plist'
  }
  helper(:launch_agents) {
    '~/Library/LaunchAgents'
  }
  helper(:my_cnf) {
    '/etc/my.cnf'
  }
  
  met? {
    which('mysql') && my_cnf.p.exists? &&
      !shell('launchctl list')[/#{plist}/].nil?
  }
  meet {
    install_packages!
    log "Writing configuration file for MySQL"
    render_erb 'mysql/my.cnf', :to => my_cnf, :sudo => true
    shell 'mysql_install_db'
    shell "cp #{brew_path}/#{plist} #{launch_agents}"
    shell "launchctl load -w #{launch_agents}/#{plist}"
  }
end
