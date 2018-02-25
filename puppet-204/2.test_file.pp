file {'/home/admin/test_file1.txt':
  ensure => file,
  content => 'This is Test File',
  mode => '0600',
  owner => 'admin',
  group => 'admin',
}
