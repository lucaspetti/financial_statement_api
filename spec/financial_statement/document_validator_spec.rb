# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FinancialStatement::DocumentValidator do
  let(:subject) { described_class.new(attributes) }

  describe '#valid?' do
    context 'when attributes are not a hash' do
      let(:attributes) { ['revenue', 2000] }

      it 'is not valid' do
        expect(subject).not_to be_valid
      end
    end

    context 'when no attributes are passed' do
      let(:attributes) { {} }

      it 'is not valid' do
        expect(subject).not_to be_valid
      end
    end

    context 'when attributes are correct' do
      let(:attributes) do
        { revenue: 2000 }
      end

      it 'is valid' do
        expect(subject).to be_valid
      end
    end
  end
end
