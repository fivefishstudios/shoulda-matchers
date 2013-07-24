module Shoulda # :nodoc:
  module Matchers
    module ActiveRecord # :nodoc:
      module AssociationMatchers
        class OrderMatcher
          attr_accessor :missing_option

          def initialize(order, name)
            @order = order
            @name = name
            @missing_option = ''
          end

          def description
            "order => #{order}"
          end

          def matches?(subject)
            self.subject = ModelReflector.new(subject, name)

            if option_verifier.correct_for_relation_clause?(:order, order)
              true
            else
              self.missing_option = "#{name} should be ordered by #{order}"
              false
            end
          end

          private

          def option_verifier
            @option_verifier ||= OptionVerifier.new(subject)
          end

          attr_accessor :subject, :order, :name
        end
      end
    end
  end
end