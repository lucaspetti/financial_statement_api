# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FinancialStatement::Api do
  def app
    FinancialStatement::Api
  end

  let(:json_response) do
    {
      "_id"=>statement.id,
      "date"=>statement.date,
      "gross_profit"=>nil,
      "revenue"=>nil
    }
  end

  describe 'GET /financial_statements' do
    context 'when there are no records on the DB' do
      before { get '/financial_statements' }

      it 'returns an empty JSON response' do
        expect(last_response).to be_ok
        expect(last_response.body).to eq("[]")
      end
    end

    context 'when there are records on the DB' do
      let!(:statement) { FinancialStatement::Document.create!(date: '2020-20-12') }

      before { get '/financial_statements' }

      it 'returns a JSON response' do
        expect(last_response).to be_ok
      end

      it 'returns all financial statements' do
        expect(last_response.body).to eq([json_response].to_json)
      end
    end
  end

  describe 'POST /financial_statements' do
    let(:request) { post '/financial_statements', params }

    context 'when params are correct' do
      let(:params) { { financial_statement: { date: '2020-20-12' } } }
      let(:statement) { FinancialStatement::Document.first }

      it 'creates a financial statement' do
        expect { request }.to change(FinancialStatement::Document, :count).by(1)
      end

      it 'returns the created statement it in JSON format' do
        request
        expect(last_response).to be_ok
        expect(last_response.body).to eq(json_response.to_json)
      end
    end

    context 'when params are incorrect' do
      let(:params) { {} }

      it 'does not create a financial statement' do
        expect { request }.not_to change(FinancialStatement::Document, :count)
      end

      it 'returns the created statement it in JSON format' do
        request
        expect(last_response.status).to eq(422)
        expect(last_response.body).to eq('Could not create record')
      end
    end
  end
end
