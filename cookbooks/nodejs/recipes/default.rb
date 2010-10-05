#
# Cookbook Name:: nodejs
# Recipe:: default
#
nodejs_file = "node-v0.2.3.tar.gz"
nodejs_dir = "node-v0.2.3"
nodejs_url = "http://nodejs.org/dist/#{nodejs_file}"
nodejs_install_dir = "/data/nodejs"

directory nodejs_install_dir do
  owner 'root'
  group 'root'
  mode 0755
  recursive true
end

# download nodejs
remote_file "#{nodejs_install_dir}/#{nodejs_file}" do
  source "#{nodejs_url}"
  owner 'root'
  group 'root'
  mode 0644
  backup 0
  not_if { FileTest.exists?("#{nodejs_install_dir}/#{nodejs_file}") }
end
execute "unarchive nodejs" do
  command "cd #{nodejs_install_dir} && tar zxf #{nodejs_file} && sync"
  not_if { FileTest.directory?("#{nodejs_install_dir}/#{nodejs_dir}") }
end

# compile nodejs
execute "configure nodejs" do
  command "cd #{nodejs_install_dir}/#{nodejs_dir} && ./configure"
  not_if { FileTest.exists?("#{nodejs_install_dir}/#{nodejs_dir}/node") }
end
execute "build nodejs" do
  command "cd #{nodejs_install_dir}/#{nodejs_dir} && make"
  not_if { FileTest.exists?("#{nodejs_install_dir}/#{nodejs_dir}/node") }
end
execute "symlink nodejs" do
  command "ln -s #{nodejs_install_dir}/#{nodejs_dir}/node #{nodejs_install_dir}/node"
  not_if { FileTest.exists?("#{nodejs_install_dir}/node") }
end
