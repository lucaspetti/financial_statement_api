# frozen_string_literal: true

require 'sinatra'
require 'mongoid'
require_relative 'document'

Mongoid.load!(File.open('./lib/config/mongoid.yml'))

module FinancialStatement
  class Api < ::Sinatra::Base
    get '/financial_statements' do
      FinancialStatement::Document.all.to_json
    end

    post '/financial_statements' do
      statement = FinancialStatement::Document.create!(params[:financial_statement])
      statement.to_json
    end

    get '/financial_statements/:id' do |id|
      statement = FinancialStatement::Document.find(id)
      statement.to_json
    end

    put '/financial_statements/:id' do |id|
      statement = FinancialStatement::Document.find(id)
      statement.update!(params[:financial_statement])
      statement.to_json
    end

    delete '/financial_statements/:id' do |id|
      statement = FinancialStatement::Document.find(id)
      statement.delete
      "Financial statement #{id} was successfully deleted"
    end
  end
end