# frozen_string_literal: true

module FinancialStatement
  class Document
    include Mongoid::Document

    field :date, type: DateTime
    field :revenue, type: Integer
    field :gross_profit, type: Integer
  end
end
