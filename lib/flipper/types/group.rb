module Flipper
  module Types
    class Group < Type
      def self.wrap(group_or_name)
        return group_or_name if group_or_name.is_a?(self)
        Flipper.group(group_or_name)
      end

      attr_reader :name

      def initialize(name, &block)
        @name = name.to_sym
        @value = @name
        @block = block
      end

      def match?(*args)
        @block.call(*args)
      end
    end
  end
end
