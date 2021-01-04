# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FinancialStatementApi do
  def app
    FinancialStatementApi
  end

  describe 'GET /financial_statements' do
    before do
      FinancialStatement.create!(date: DateTime.now)
      get '/financial_statements'
    end

    it 'returns a JSON response' do
      expect(last_response).to be_ok
    end

    it 'returns all financial statements' do
      expect(last_response.body).to eq(FinancialStatement.all.to_json)
    end
  end
end
