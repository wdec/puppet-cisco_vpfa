require 'spec_helper'

describe 'cisco_vpfa::db::sync' do

  shared_examples_for 'cisco_vpfa-dbsync' do

    it 'runs cisco_vpfa-db-sync' do
      is_expected.to contain_exec('cisco_vpfa-db-sync').with(
        :command     => 'cisco_vpfa-manage db_sync ',
        :path        => [ '/bin', '/usr/bin', ],
        :refreshonly => 'true',
        :user        => 'cisco_vpfa',
        :logoutput   => 'on_failure'
      )
    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge(OSDefaults.get_facts({
          :os_workers     => 8,
          :concat_basedir => '/var/lib/puppet/concat'
        }))
      end

      it_configures 'cisco_vpfa-dbsync'
    end
  end

end
