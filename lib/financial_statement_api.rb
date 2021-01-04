# frozen_string_literal: true

require 'bundler/setup'
require 'sinatra'
require 'mongoid'
require_relative './financial_statement'

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))

class FinancialStatementApi < Sinatra::Base
  get '/financial_statements' do
    FinancialStatement.all.to_json
  end

  post '/financial_statements' do
    statement = FinancialStatement.create!(params[:financial_statement])
    statement.to_json
  end

  get '/financial_statements/:id' do |id|
    statement = FinancialStatement.find(id)
    statement.to_json
  end

  put '/financial_statements/:id' do |id|
    statement = FinancialStatement.find(id)
    statement.update!(params[:financial_statement])
    statement.to_json
  end

  delete '/financial_statements/:id' do |id|
    statement = FinancialStatement.find(id)
    statement.delete
    "Financial statement #{id} was successfully deleted"
  end
end
