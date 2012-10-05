require 'spec_helper'

describe 'graphite::carbon' do
  context 'default' do
    let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat' }}
    it {
      should contain_package('carbon')
      should contain_concat('/etc/carbon/carbon.conf')
    }
  end
  context 'with package =>' do
    let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat' }}
    let (:params) {{ :package => 'carbon_custom' }}
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
end
