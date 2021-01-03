require './lib/financial_statement_api'

run Rack::URLMap.new('/' => FinancialStatementApi)