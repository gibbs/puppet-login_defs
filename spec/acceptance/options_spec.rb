require 'spec_helper_acceptance'

describe 'options' do
  pp = <<-MANIFEST
    class { 'login_defs':
      options => {
        'GID_MIN' => {
          value => '2000',
        },
        'HUSHLOGIN_FILE' => {
          value   => '.hushlogin',
          enabled => false,
        },
        'USERGROUPS_ENAB' => {
          value => 'no',
        },
        'PASS_MAX_DAYS' => {
          value   => 123,
          comment => 'testcomment',
        },
        'DEFAULT_HOME' => {
          value   => 'yes',
          enabled => false,
        },
      }
    }
  MANIFEST

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  describe file('/etc/login.defs') do
    it { is_expected.to exist }
    it { is_expected.to be_file }
    it { is_expected.to be_mode 6_44 }
    it { is_expected.to be_owned_by 'root' }
    it { is_expected.to be_readable }

    its(:content) do
      is_expected.to match(%r{MANAGED BY PUPPET})

      # Custom
      is_expected.to match(%r{GID_MIN	2000})
      is_expected.to match(%r{#HUSHLOGIN_FILE	.hushlogin})
      is_expected.to match(%r{USERGROUPS_ENAB	no})
      is_expected.to match(%r{PASS_MAX_DAYS	123})
      is_expected.to match(%r{# testcomment})
      is_expected.to match(%r{#DEFAULT_HOME	yes})

      # Ensure a common value is correct
      is_expected.to match(%r{ENCRYPT_METHOD	SHA512})
    end
  end
end
