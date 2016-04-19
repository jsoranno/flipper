require 'helper'
RSpec.describe Flipper::Api::V1::Actions::Feature do
  let(:app) { build_api(flipper) }

  describe 'api/v1/feature/:feature' do
    context 'valid route' do
      before do
        flipper[:buddy_list].enable
        flipper[:messenger].enable
        get '/api/v1/features/buddy_list/'
      end

      let(:expected_res) do
        {
          'feature' =>
          {
            'key' => 'buddy_list',
            'name' => 'buddy_list'
          }
        }
      end

      it 'returns features' do
        expect(last_response.status).to eq(200)
        expect(json_response).to eq(expected_res)
      end
    end
  end
end
