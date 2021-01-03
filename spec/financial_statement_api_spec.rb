# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FinancialStatementApi do
  def app
    FinancialStatementApi
  end

  describe 'GET root' do
    it 'returns a welcome message' do
      get '/'
      expect(last_response).to be_ok
    end
  end
end
