# frozen_string_literal: true
require 'rails_helper'

Rspec.describe Types::AccountType do
  # described_class is the model written immediately after Rspec.describe
  subject { described_class }

  describe 'fields' do
    # is_expected = expected(subject)?
    it { is_expected.to have_field(:id).that_returns('ID!') }
    it { is_expected.to have_field(:username).that_returns('String!') }
    it { is_expected.to have_field(:email).that_returns('String!') }
  end
end
