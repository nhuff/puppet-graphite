require 'spec_helper'

describe 'graphite::carbon' do
  context 'default' do
    let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat' }}
    it {
      should contain_package('carbon')
      should contain_concat('/etc/carbon/carbon.conf')
      should contain_concat__fragment('carbon_header').
        with_content(/USER = carbon/)
    }
  end
  context 'with package =>' do
    let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat' }}
    let(:params) {{ :package => 'carbon_custom' }}

    it {
      should contain_package('carbon_custom')
    }
  end
  context 'with conf_dir =>' do
    let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat' }}
    let(:params) {{ :conf_dir => '/opt/graphite/conf' }}
    it {
      should contain_concat('/opt/graphite/conf/carbon.conf')
    }
  end
  context 'with user =>' do
    let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat' }}
    let(:params) {{ :user => 'root' }}

    it {
      should contain_concat__fragment('carbon_header').
        with_content(/USER = root/)
    }
  end
  context 'with storage_dir =>' do
    let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat' }}
    let(:params) {{ :storage_dir => '/opt/graphite/storage' }}

    it {
      should contain_concat__fragment('carbon_header').
        with_content(/STORAGE_DIR = \/opt\/graphite\/storage/)
    }
  end
  context 'with pid_dir =>' do
    let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat' }}
    let(:params) {{ :pid_dir => '/opt/graphite/run' }}

    it {
      should contain_concat__fragment('carbon_header').
        with_content(/PID_DIR = \/opt\/graphite\/run/)
    }
  end
  context 'with log_dir =>' do
    let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat' }}
    let(:params) {{ :log_dir => '/opt/graphite/log' }}

    it {
      should contain_concat__fragment('carbon_header').
        with_content(/LOG_DIR = \/opt\/graphite\/log/)
    }
  end
end
