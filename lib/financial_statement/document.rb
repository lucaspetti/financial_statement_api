# frozen_string_literal: true

module FinancialStatement
  class Document
    include Mongoid::Document

    field :date, type: DateTime
    field :revenue, type: Integer
    field :gross_profit, type: Integer
    field :period, type: String
    field :research_and_dev_expenses, type: Integer
    field :general_administrative_expenses, type: Integer
    field :selling_and_marketing_expenses, type: Integer
    field :other_expenses, type: Integer
    field :net_income, type: Integer
  end
end
