require './lib/financial_statement'

run Rack::URLMap.new('/' => FinancialStatement::Api)