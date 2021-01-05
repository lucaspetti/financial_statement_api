# frozen_string_literal: true

require 'sinatra'
require 'mongoid'
require_relative 'document'
require_relative 'document_validator'

Mongoid.load!(File.open('./lib/config/mongoid.yml'))

module FinancialStatement
  class Api < ::Sinatra::Base
    get '/financial_statements' do
      Document.all.to_json
    end

    post '/financial_statements' do
      if DocumentValidator.new(params[:financial_statement]).valid?
        statement = Document.create!(params[:financial_statement])
        statement.to_json
      else
        status 422
        body 'Could not create record'
      end
    end

    get '/financial_statements/:id' do |id|
      statement = Document.find(id)
      statement.to_json
    end

    put '/financial_statements/:id' do |id|
      statement = Document.find(id)
      statement.update!(params[:financial_statement])
      statement.to_json
    end

    delete '/financial_statements/:id' do |id|
      statement = Document.find(id)
      statement.delete
      "Financial statement #{id} was successfully deleted"
    end
  end
end