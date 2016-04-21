require 'flipper/api/action'
require 'flipper/api/v1/decorators/feature'

module Flipper
  module Api
    module V1
      module Actions
        class BooleanGate < Api::Action
          route %r{api/v1/features/[^/]*/(enable|disable)/?\Z}
          
          def put
            feature_name = Rack::Utils.unescape(request.path.split("/")[-2])
            feature = flipper[feature_name.to_sym]
            feature = Decorators::Feature.new(feature)
            action = Rack::Utils.unescape(request.path.split("/").last)
            feature.send(action)
            json_response({feature: feature})
          end
        end
      end
    end
  end
end
