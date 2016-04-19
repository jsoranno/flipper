require 'flipper/api/action'
require 'flipper/api/v1/decorators/feature'

module Flipper
  module Api
    module V1
      module Actions
        class Feature < Api::Action
          route %r{api/v1/features/[^/]*/?\Z}
          
          def get
            feature_name = Rack::Utils.unescape(request.path.split("/").last)
            feature = flipper[feature_name]
            decorated_feature = V1::Decorators::Feature.new(feature)
            json_response({feature: decorated_feature})
          end
        end
      end
    end
  end
end
