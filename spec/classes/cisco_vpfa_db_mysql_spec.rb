require 'spec_helper'

describe 'cisco_vpfa::db::mysql' do

  let :pre_condition do
    'include mysql::server'
  end

  let :required_params do
    { :password => 'fooboozoo_default_password', }
  end

  shared_examples_for 'cisco_vpfa-db-mysql' do
    context 'with only required params' do
      let :params do
        required_params
      end

      it { is_expected.to contain_openstacklib__db__mysql('cisco_vpfa').with(
        :user           => 'cisco_vpfa',
        :password_hash  => '*3DDF34A86854A312A8E2C65B506E21C91800D206',
        :dbname         => 'cisco_vpfa',
        :host           => '127.0.0.1',
        :charset        => 'utf8',
        :collate        => 'utf8_general_ci',
      )}
    end

    context 'overriding allowed_hosts param to array' do
      let :params do
        { :allowed_hosts => ['127.0.0.1','%'] }.merge(required_params)
      end

      it { is_expected.to contain_openstacklib__db__mysql('cisco_vpfa').with(
        :user           => 'cisco_vpfa',
        :password_hash  => '*3DDF34A86854A312A8E2C65B506E21C91800D206',
        :dbname         => 'cisco_vpfa',
        :host           => '127.0.0.1',
        :charset        => 'utf8',
        :collate        => 'utf8_general_ci',
        :allowed_hosts  => ['127.0.0.1','%']
      )}
    end

    describe 'overriding allowed_hosts param to string' do
      let :params do
        { :allowed_hosts => '192.168.1.1' }.merge(required_params)
      end

      it { is_expected.to contain_openstacklib__db__mysql('cisco_vpfa').with(
        :user           => 'cisco_vpfa',
        :password_hash  => '*3DDF34A86854A312A8E2C65B506E21C91800D206',
        :dbname         => 'cisco_vpfa',
        :host           => '127.0.0.1',
        :charset        => 'utf8',
        :collate        => 'utf8_general_ci',
        :allowed_hosts  => '192.168.1.1'
      )}
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'cisco_vpfa-db-mysql'
    end
  end
end
