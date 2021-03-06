# Cookbook:: cb_cis_windows_2016
# Recipe:: cis-9-2-private-profile
#
# Copyright:: 2018, Jesse Boyce, All Rights Reserved.

# 9.2.1 (L1) Ensure 'Windows Firewall: Private: Firewall state' is set to 'On (recommended)'
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile' do
  if ENV['TEST_KITCHEN']
    values [{ name: 'EnableFirewall', type: :dword, data: 0 }]
  else
    values [{ name: 'EnableFirewall', type: :dword, data: 1 }]
  end
  recursive true
  action :create
  only_if { node['cb_cis_windows_2016']['cis_level_1'] }
end

# 9.2.2 (L1) Ensure 'Windows Firewall: Private: Inbound connections' is set to 'Block (default)'
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile' do
  values [{ name: 'DefaultInboundAction', type: :dword, data: 1 }]
  action :create
  only_if { node['cb_cis_windows_2016']['cis_level_1'] }
end

# 9.2.3 (L1) Ensure 'Windows Firewall: Private: Outbound connections' is set to 'Allow (default)'
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile' do
  values [{ name: 'DefaultOutboundAction', type: :dword, data: 1 }]
  action :create
  only_if { node['cb_cis_windows_2016']['cis_level_1'] }
end

# 9.2.4 (L1) Ensure 'Windows Firewall: Private: Settings: Display a notification' is set to 'No'
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile' do
  values [{ name: 'DisableNotifications', type: :dword, data: 0 }]
  action :create
  only_if { node['cb_cis_windows_2016']['cis_level_1'] }
end

# 9.2.5 (L1) Ensure 'Windows Firewall: Private: Settings: Apply local firewall rules' is set to 'Yes (default)'
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile' do
  values [{ name: 'AllowLocalPolicyMerge', type: :dword, data: 1 }]
  action :create
  only_if { node['cb_cis_windows_2016']['cis_level_1'] }
end

# 9.2.6 (L1) Ensure 'Windows Firewall: Private: Settings: Apply local connection security rules' is set to 'Yes (default)'
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile' do
  values [{ name: 'AllowLocalIPsecPolicyMerge', type: :dword, data: 1 }]
  action :create
  only_if { node['cb_cis_windows_2016']['cis_level_1'] }
end

# 9.2.7 (L1) Ensure 'Windows Firewall: Private: Logging: Name' is set to '%SYSTEMROOT%\System32\logfiles\firewall\privatefw.log'
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging' do
  values [{ name: 'LogFilePath', type: :string, data: '%SYSTEMROOT%\System32\logfiles\firewall\privatefw.log' }]
  recursive true
  action :create
  only_if { node['cb_cis_windows_2016']['cis_level_1'] }
end

# 9.2.8 (L1)  Ensure 'Windows Firewall: Private: Logging: Size limit (KB)' is set to '16,384 KB or greater'
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging' do
  values [{ name: 'LogFileSize', type: :dword, data: 16384 }]
  action :create
  only_if { node['cb_cis_windows_2016']['cis_level_1'] }
end

# 9.2.9 (L1) Ensure 'Windows Firewall: Private: Logging: Log dropped packets' is set to 'Yes'
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging' do
  values [{ name: 'LogDroppedPackets', type: :dword, data: 1 }]
  action :create
  only_if { node['cb_cis_windows_2016']['cis_level_1'] }
end

# 9.2.10 (L1) Ensure 'Windows Firewall: Private: Logging: Log successful connections' is set to 'Yes'
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging' do
  values [{ name: 'LogSuccessfulConnections', type: :dword, data: 1 }]
  action :create
  only_if { node['cb_cis_windows_2016']['cis_level_1'] }
end

# powershell_script 'Firewall Domain Profile Settings' do
#   code <<-EOH
#   $params = @{
#     'Name'='Private';
#     'Enabled'='True';
#     'DefaultInboundAction'='Block';
#     'DefaultOutboundAction'='Allow';
#     'AllowLocalFirewallRules'='True';
#     'AllowLocalIPsecRules'='True';
#     'NotifyOnListen'='False';
#     'LogFileName'='%SYSTEMROOT%\System32\logfiles\firewall\privatefw.log';
#     'LogMaxSizeKilobytes'='16384';
#     'LogAllowed'='True';
#     'LogBlocked'='True';
#     'PolicyStore'="$env:COMPUTERNAME"
#   }

#   Set-NetFirewallProfile @params -Verbose
#   EOH
# end
