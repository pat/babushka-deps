pkg 'mysql software' do
  installs {
    via :apt, %w[mysql-server libmysqlclient15-dev]
    via :brew, 'mysql'
  }
  provides 'mysql'
end