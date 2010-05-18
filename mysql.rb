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
  helper(:launch_agent?) {
    shell "launchctl list | grep '#{plist}'"
  }
  
  met? {
    which 'mysql' && launch_agent?
  }
  
  after(:on => :osx) {
    shell 'mysql_install_db'
    shell "cp #{brew_path}/#{plist} #{launch_agents}"
    shell "launchctl load -w #{launch_agents}/#{plist}"
  }
end
