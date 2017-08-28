Puppet::Type.type(:cisco_vpfa_config).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:ini_setting).provider(:ruby)
) do

  # Format for config is section/setting, eg NETWORK/VTS_IP
  def section
    resource[:name].split('/', 2).first.upcase
  end

  def setting
    resource[:name].split('/', 2).last.upcase
  end

  def separator
    ' = '
  end

  def self.file_path
    '/etc/vpe/vpfa.ini'
  end

end
