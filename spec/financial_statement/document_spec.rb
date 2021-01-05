# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FinancialStatement::Document do
  let(:subject) { described_class.new }

  it { is_expected.to be_mongoid_document }

  describe 'fields' do
    it { is_expected.to have_field(:date).of_type(DateTime) }
    it { is_expected.to have_field(:gross_profit).of_type(Integer) }
    it { is_expected.to have_field(:period).of_type(String) }
    it { is_expected.to have_field(:research_and_dev_expenses).of_type(Integer) }
    it { is_expected.to have_field(:general_administrative_expenses).of_type(Integer) }
    it { is_expected.to have_field(:selling_and_marketing_expenses).of_type(Integer) }
    it { is_expected.to have_field(:other_expenses).of_type(Integer) }
    it { is_expected.to have_field(:net_income).of_type(Integer) }
  end
end
