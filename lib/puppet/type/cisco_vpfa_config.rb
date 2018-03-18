Puppet::Type.newtype(:cisco_vpfa_config) do

  ensurable

  newparam(:name, :namevar => true) do
    desc 'Section/setting name to manage from vpfa.ini'
    newvalues(/\S+\/\S+/)
  end

  newproperty(:value) do
    munge do |value|
      if value.is_a? String
        value.strip
      else
        # Render also boolean settings as strings
        value ? 'True' : 'False'
      end
    end
  end

  newparam(:secret, :boolean => true) do
    desc 'Whether to hide the value from Puppet logs. Defaults to `true`.'
    newvalues(:true, :false)
    defaultto true
  end

  newparam(:ensure_absent_val) do
    desc 'A value that is specified as the value property will behave as if ensure => absent was specified'
    defaultto('<SERVICE DEFAULT>')
  end

  autorequire(:file) do
    ['/etc/vpe/vpfa/vpfa.ini']
  end

  autorequire(:package) do
    'vpfa'
  end

end
