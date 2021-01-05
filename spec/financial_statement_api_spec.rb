# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FinancialStatement::Api do
  def app
    FinancialStatement::Api
  end

  let(:json_response) do
    {
      "_id"=>document.id,
      "date"=>document.date,
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
      let!(:document) { FinancialStatement::Document.create!(date: '2020-20-12') }

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
      let(:document) { FinancialStatement::Document.first }

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

  describe 'GET /financial_statements/:id' do
    let(:request) { get "/financial_statements/#{id}" }
    let!(:document) { FinancialStatement::Document.create!(date: '2020-20-12') }

    context 'when record exists' do
      let(:id) { document.id }

      it 'returns the record in JSON format' do
        request
        expect(last_response).to be_ok
        expect(last_response.body).to eq(document.to_json)
      end
    end

    context 'when record does not exist' do
      let(:id) { 'wrong_id' }

      it 'returns 404' do
        request
        expect(last_response).to be_not_found
        expect(last_response.body).to eq('Record not found')
      end
    end
  end

  describe 'PUT /financial_statements/:id' do
    let(:request) { put "/financial_statements/#{id}", params }
    let!(:document) { FinancialStatement::Document.create!(date: '2020-20-12') }
    let(:params) { { financial_statement: { revenue: 8000 } } }

    context 'when record exists' do
      let(:id) { document.id }
      let(:parsed_response) { JSON.parse(last_response.body) }

      it 'updates the record and returns it in JSON format' do
        request
        expect(last_response).to be_ok
        expect(parsed_response['revenue']).to eq(8000)
      end
    end

    context 'when record does not exist' do
      let(:id) { 'wrong_id' }

      it 'returns 404' do
        request
        expect(last_response).to be_not_found
        expect(last_response.body).to eq('Record not found')
      end
    end
  end

  describe 'DELETE /financial_statements/:id' do
    let(:request) { delete "/financial_statements/#{id}", params }
    let!(:document) { FinancialStatement::Document.create!(date: '2020-20-12') }
    let(:params) { { financial_statement: { revenue: 8000 } } }

    context 'when record exists' do
      let(:id) { document.id }

      it 'deletes the record and returns a message that it was deleted' do
        request
        expect(last_response).to be_ok
        expect(last_response.body).to eq "Financial statement #{id} was successfully deleted"
      end
    end

    context 'when record does not exist' do
      let(:id) { 'wrong_id' }

      it 'returns 404' do
        request
        expect(last_response).to be_not_found
        expect(last_response.body).to eq('Record not found')
      end
    end
  end
end
