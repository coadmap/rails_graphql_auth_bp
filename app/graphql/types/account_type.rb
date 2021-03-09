# frozen_string_literal: true
module Types
  # AccountType
  class AccountType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false
    field :email, String, null: false
  end
end
