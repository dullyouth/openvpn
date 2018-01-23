#
# Cookbook Name:: OpenVPN
# Recipe:: ldap
#
# Author:: Luke and Nathan
#

ldap_url = node['openvpn']['ldap']['source']['url']

ldap_src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/threerings-openvpn-auth-ldap-#{node['openvpn']['ldap']['source']['git_commit_hash']}"

remote_file ldap_url do
  source   ldap_url
  checksum node['openvpn']['ldap']['source']['checksum']
  path     "#{ldap_src_filepath}.tar.gz"
  backup   false
end


package 'openvpn-auth-ldap'

directory node['openvpn']['ldap']['config']['auth_dir'] do
  action :create
end

template "#{node['openvpn']['ldap']['config']['auth_dir']}/auth-ldap.conf" do
  source 'auth.conf.erb'
end
