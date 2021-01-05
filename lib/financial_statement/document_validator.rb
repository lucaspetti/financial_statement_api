# frozen_string_literal: true

module FinancialStatement
  class DocumentValidator
    def initialize(attributes)
      @attributes = attributes
    end

    def valid?
      @attributes.is_a?(Hash) && @attributes.any?
    end
  end
end