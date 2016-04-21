require 'rack'
require 'flipper'

require 'rack/methodoverride'
require 'flipper/api/middleware'

module Flipper
  module Api
    def self.app(flipper)
      app = App.new(200,{'Content-Type' => 'application/json'}, [''])
      builder = Rack::Builder.new
      yield builder if block_given?
      builder.use Flipper::Api::Middleware, flipper
      builder.run app
      builder
    end

    class App
      attr_writer :status
      
      def initialize(status, headers, body)
        @status = status
        @headers = headers
        @body = body
      end

      def call(env)
        response
      end

      private

      def response
        [@status, @headers, @body]
      end
    end
  end
end
