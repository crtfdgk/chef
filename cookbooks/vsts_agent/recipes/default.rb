include_recipe 'ark::default'

if platform_family?('debian') && node['vsts_agent']['prerequisites']['debian']['install']
  package 'libunwind8'
  package 'libcurl3'
  unless platform?('ubuntu') && node['platform_version'].to_i >= 16
    package 'libicu52'
  end

elsif (platform_family?('mac_os_x') || platform_family?('mac_os_x_server')) && node['vsts_agent']['prerequisites']['osx']['install']
  cpu = node['cpu'] ? node['cpu']['total'].to_i : 2
  version = node['vsts_agent']['prerequisites']['osx']['openssl']['version']
  ark 'openssl' do
    url node['vsts_agent']['prerequisites']['osx']['openssl']['url']
    backup false
    path Chef::Config[:file_cache_path]
    action :put
  end

  bash "Make openssl #{version}" do
    cwd "#{Chef::Config[:file_cache_path]}/openssl"
    code <<-EOH
      ./configure shared darwin64-x86_64-cc --prefix=/usr/local/openssl-#{version}
      make depend
      make -j #{cpu}
      make install
      rm -rf /usr/local/openssl /usr/local/bin/openssl
      ln -s /usr/local/openssl-#{version} /usr/local/openssl
      ln -s /usr/local/openssl/bin/openssl /usr/local/bin/openssl
      mkdir -p /usr/local/lib
      cp /usr/local/openssl/lib/lib* /usr/local/lib/
    EOH
    not_if "/usr/local/bin/openssl version |grep #{version}"
  end
end
