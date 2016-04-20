require 'helper'
RSpec.describe Flipper::Api::V1::Actions::BooleanGate do
  let(:app) { build_api(flipper) }

  describe '#put enable' do
    before do
      flipper[:my_feature].disable
      put '/api/v1/features/my_feature/enable'
    end

    it 'enables feature' do
      expect(last_response.status).to eq(200)
      expect(json_response).to eq(true)
    end
  end
end
