# frozen_string_literal: true

require 'bundler/setup'
require 'sinatra'

class FinancialStatementApi < Sinatra::Base
  get '/' do
    "Financial Statement Generator. Welcome #{params[:name]}"
  end

  get '/financial_statements' do
    # Display all Financial Statements
  end

  post '/financial_statements' do
    # Create a new Financial Statement
  end
end
