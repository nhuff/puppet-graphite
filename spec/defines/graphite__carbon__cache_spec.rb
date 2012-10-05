require 'spec_helper'

describe 'graphite::carbon::cache' do
    let(:title) { 'test' }
    let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat' }}
    let(:params) {{ 
      :user    => 'root',
      :log_dir => '/opt/graphite/log',
      :storage_dir => '/opt/graphite/storage',
      :pid_dir     => '/opt/graphite/storage',
    }}

    it {
      should contain_concat__fragment('carbon_cache_test').
        with_content(/USER = root/).
        with_content(/STORAGE_DIR = \/opt\/graphite\/storage/).
        with_content(/PID_DIR = \/opt\/graphite\/storage/).
        with_content(/LOG_DIR = \/opt\/graphite\/log/)
    }
end
