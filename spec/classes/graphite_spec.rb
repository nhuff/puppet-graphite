require 'spec_helper'

describe 'graphite' do
  let(:facts) {{:concat_basedir => '/var/lib/puppet/concat'}}
  context 'Default' do
    it {
      should contain_package('carbon')
      should contain_package('whisper')
      should contain_package('graphite-web')
      should contain_file('/opt/graphite/webapp/graphite/local_settings.py')
      should contain_concat('/opt/graphite/conf/storage-schemas.conf')
    }
  end
end
