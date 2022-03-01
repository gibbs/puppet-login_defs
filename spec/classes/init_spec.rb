require 'spec_helper'

describe 'login_defs', type: :class do
  context 'on supported systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) { facts }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to create_class('login_defs') }
        it { is_expected.to contain_class('login_defs') }
        it {
          is_expected.to create_file('/etc/login.defs').with({
                                                               owner: 'root',
            group: 0,
            mode: '0644'
                                                             })
        }
      end
    end
  end
end
