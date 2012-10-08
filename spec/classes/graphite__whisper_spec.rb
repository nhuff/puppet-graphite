require 'spec_helper'

describe 'graphite::whisper' do
  context 'default' do
    it {
      should contain_package('whisper')
    }
  end
  context 'with package =>' do
    let (:params) {{ :package => 'whisper_custom' }}

    it {
      should contain_package('whisper_custom')
    }
  end
end
