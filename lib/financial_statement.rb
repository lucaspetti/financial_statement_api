# frozen_string_literal: true

class FinancialStatement
  include Mongoid::Document

  field :date, type: DateTime
  field :revenue, type: Integer
  field :gross_profit, type: Integer
end
