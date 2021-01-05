require './lib/financial_statement/api'

run Rack::URLMap.new('/' => FinancialStatement::Api)