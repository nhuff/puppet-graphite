require 'spec_helper'

precon = <<-EDOC
  include graphite::carbon
  graphite::carbon::cache{'default':}
EDOC

describe 'graphite::carbon::storage' do
  let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat' }}
  let(:pre_condition) {precon}
  context 'Default' do
    let(:title) {'graphite-default'}
    let(:params) {{
      :pattern    => '.*',
      :retentions => '60s:1d'
    }}

    it {
      should contain_concat__fragment('carbon_storage_graphite-default').with(
        'target'  => '/etc/carbon/storage-schemas.conf',
        'content' => /\[graphite-default\]\s+pattern = \.\*\s+retentions = 60s:1d/m,
        'order'   => 10
      )
    }
  end
  context 'with order =>' do
    let(:title) {'graphite-default'}
    let(:params) {{
      :pattern    => '.*',
      :retentions => '60s:1d',
      :order      => 99,
    }}

    it {
      should contain_concat__fragment('carbon_storage_graphite-default').with(
        'order' => 99
      )
    }
  end

end
