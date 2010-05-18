pkg 'mysql software' do
  installs {
    via :apt, %w[mysql-server libmysqlclient15-dev]
    via :brew, 'mysql'
  }
  provides 'mysql'
  
  helper(:plist) {
    'com.mysql.mysqld.plist'
  }
  helper(:brew_path) {
    BrewHelper.brew_path_for('mysql')
  }
  helper(:launch_agents) {
    '~/Library/LaunchAgents'
  }
  
  after(:on => :osx) {
    shell 'mysql_install_db'
    shell "cp #{brew_path}/#{plist} #{launch_agents}"
    shell "launchctl load -w #{launch_agents}/#{plist}"
  }
end
