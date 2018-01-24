require 'spec_helper'
describe 'puppetserver', :type => :class do
  on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        it { is_expected.to compile }
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('puppetserver') }
        it { is_expected.to contain_class('puppetserver::install').that_comes_before('Class[puppetserver::config]') }
        it { is_expected.to contain_class('puppetserver::config').that_comes_before('Class[puppetserver::service]') }
        it { is_expected.to contain_class('puppetserver::service') }


        context 'puppetserver::install defaults' do
          it { is_expected.to contain_package('puppetserver') }
          it { is_expected.to contain_package('puppet-agent') }
        end

        context 'puppetserver::install when puppetdb true' do
          let(:params) { { puppetdb: true } }
          it { is_expected.to contain_package('puppetdb-termini') }
        end

        context 'puppetserver::config defaults' do
          it { is_expected.to contain_augeas('main_certname').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
             })
          }
          it { is_expected.to contain_augeas('main_server').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf',
          })}
          it { is_expected.to contain_augeas('java_args') }
        end

        context 'puppetserver::config when puppetdb true' do
          let(:params) { { puppetdb: true } }
          it { is_expected.to contain_augeas('master_storeconfigs').with({
            'context' => '/files/etc/puppetlabs/puppet/puppet.conf/master',})
          }
          it { is_expected.to contain_file('/etc/puppetlabs/puppet/routes.yaml') }
          it { is_expected.to contain_file('/etc/puppetlabs/puppet/puppetdb.conf') }
          end

          context 'puppetserver::service defaults' do
            it { is_expected.to contain_service('puppetserver').with({
              'ensure' => 'running',
              'enable' => true,
              })
            }
            it { is_expected.to contain_service('puppet').with({
              'ensure' => 'running',
              'enable' => true,
              })
            }
          end
  end
 end
end
