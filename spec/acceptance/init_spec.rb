require 'spec_helper_acceptance'

describe 'include class' do
  pp = <<-MANIFEST
    include ::login_defs
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

    its(:content) { is_expected.to match(%r{MANAGED BY PUPPET}) }
  end
end
