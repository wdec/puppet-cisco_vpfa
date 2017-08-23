Puppet::Type.type(:cisco_vpfa_config).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:ini_setting).provider(:ruby)
) do

  def self.file_path
    '/etc/vpe/vpfa.ini'
  end

end
