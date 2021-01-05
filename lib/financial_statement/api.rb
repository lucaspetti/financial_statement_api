# frozen_string_literal: true

require 'sinatra'
require 'mongoid'
require_relative 'document'
require_relative 'document_validator'

Mongoid.load!(File.open('./config/mongoid.yml'))

module FinancialStatement
  class Api < ::Sinatra::Base
    get '/financial_statements' do
      Document.all.to_json
    end

    post '/financial_statements' do
      if DocumentValidator.new(params[:financial_statement]).valid?
        document = Document.create!(params[:financial_statement])
        document.to_json
      else
        status 422
        body 'Could not create record'
      end
    end

    get '/financial_statements/:id' do |id|
      document = Document.find(id)
      if document
        document.to_json
      else
        render_not_found
      end
    end

    put '/financial_statements/:id' do |id|
      document = Document.find(id)
      if document
        document.update!(params[:financial_statement])
        document.to_json
      else
        render_not_found
      end
    end

    delete '/financial_statements/:id' do |id|
      document = Document.find(id)
      if document
        document.delete
        status 200
        body "Financial statement #{id} was successfully deleted"
      else
        render_not_found
      end
    end

    private

    def render_not_found
      status 404
      body 'Record not found'
    end
  end
end
