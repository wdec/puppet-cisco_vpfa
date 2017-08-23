#
# Unit tests for cisco_vpfa::keystone::auth
#

require 'spec_helper'

describe 'cisco_vpfa::keystone::auth' do
  shared_examples_for 'cisco_vpfa-keystone-auth' do
    context 'with default class parameters' do
      let :params do
        { :password => 'cisco_vpfa_password',
          :tenant   => 'foobar' }
      end

      it { is_expected.to contain_keystone_user('cisco_vpfa').with(
        :ensure   => 'present',
        :password => 'cisco_vpfa_password',
      ) }

      it { is_expected.to contain_keystone_user_role('cisco_vpfa@foobar').with(
        :ensure  => 'present',
        :roles   => ['admin']
      )}

      it { is_expected.to contain_keystone_service('cisco_vpfa::FIXME').with(
        :ensure      => 'present',
        :description => 'cisco_vpfa FIXME Service'
      ) }

      it { is_expected.to contain_keystone_endpoint('RegionOne/cisco_vpfa::FIXME').with(
        :ensure       => 'present',
        :public_url   => 'http://127.0.0.1:FIXME',
        :admin_url    => 'http://127.0.0.1:FIXME',
        :internal_url => 'http://127.0.0.1:FIXME',
      ) }
    end

    context 'when overriding URL parameters' do
      let :params do
        { :password     => 'cisco_vpfa_password',
          :public_url   => 'https://10.10.10.10:80',
          :internal_url => 'http://10.10.10.11:81',
          :admin_url    => 'http://10.10.10.12:81', }
      end

      it { is_expected.to contain_keystone_endpoint('RegionOne/cisco_vpfa::FIXME').with(
        :ensure       => 'present',
        :public_url   => 'https://10.10.10.10:80',
        :internal_url => 'http://10.10.10.11:81',
        :admin_url    => 'http://10.10.10.12:81',
      ) }
    end

    context 'when overriding auth name' do
      let :params do
        { :password => 'foo',
          :auth_name => 'cisco_vpfay' }
      end

      it { is_expected.to contain_keystone_user('cisco_vpfay') }
      it { is_expected.to contain_keystone_user_role('cisco_vpfay@services') }
      it { is_expected.to contain_keystone_service('cisco_vpfa::FIXME') }
      it { is_expected.to contain_keystone_endpoint('RegionOne/cisco_vpfa::FIXME') }
    end

    context 'when overriding service name' do
      let :params do
        { :service_name => 'cisco_vpfa_service',
          :auth_name    => 'cisco_vpfa',
          :password     => 'cisco_vpfa_password' }
      end

      it { is_expected.to contain_keystone_user('cisco_vpfa') }
      it { is_expected.to contain_keystone_user_role('cisco_vpfa@services') }
      it { is_expected.to contain_keystone_service('cisco_vpfa_service::FIXME') }
      it { is_expected.to contain_keystone_endpoint('RegionOne/cisco_vpfa_service::FIXME') }
    end

    context 'when disabling user configuration' do

      let :params do
        {
          :password       => 'cisco_vpfa_password',
          :configure_user => false
        }
      end

      it { is_expected.not_to contain_keystone_user('cisco_vpfa') }
      it { is_expected.to contain_keystone_user_role('cisco_vpfa@services') }
      it { is_expected.to contain_keystone_service('cisco_vpfa::FIXME').with(
        :ensure      => 'present',
        :description => 'cisco_vpfa FIXME Service'
      ) }

    end

    context 'when disabling user and user role configuration' do

      let :params do
        {
          :password            => 'cisco_vpfa_password',
          :configure_user      => false,
          :configure_user_role => false
        }
      end

      it { is_expected.not_to contain_keystone_user('cisco_vpfa') }
      it { is_expected.not_to contain_keystone_user_role('cisco_vpfa@services') }
      it { is_expected.to contain_keystone_service('cisco_vpfa::FIXME').with(
        :ensure      => 'present',
        :description => 'cisco_vpfa FIXME Service'
      ) }

    end

    context 'when using ensure absent' do

      let :params do
        {
          :password => 'cisco_vpfa_password',
          :ensure   => 'absent'
        }
      end

      it { is_expected.to contain_keystone__resource__service_identity('cisco_vpfa').with_ensure('absent') }

    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'cisco_vpfa-keystone-auth'
    end
  end
end
