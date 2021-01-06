# frozen_string_literal: true

require 'mongoid'
require './lib/financial_statement/api'
require './lib/financial_statement/document_validator'
require './lib/financial_statement/document'

Mongoid.load!(File.open('./config/mongoid.yml'))
