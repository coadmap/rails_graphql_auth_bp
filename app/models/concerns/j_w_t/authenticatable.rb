# frozen_string_literal: true

module JWT
  # Authenticatable
  module Authenticatable
    extend ActiveSupport::Concern

    included do
      # JWT失効させる
      def invalidate_jwt!(token)
        payload, _header = JWT::Helper.decode(token)
        _type, sub = GraphQL::Schema::UniqueWithinType.decode(payload['sub'], separator: ':')
        fail JWT::InvalidSubError if sub != id
      end

      # JWT発行
      def jwt
        iat = Time.now.to_i
        exp = iat + (3600 * 24 * 7) # 一週間

        payload = {
          iat: iat,
          exp: exp,
          sub: GraphQL::Schema::UniqueWithinType.encode(self.class.name, id, separator: ':')
        }

        JWT::Helper.encode(payload)
      end
    end

    class_methods do
      # 認証
      def authenticate!(token)
        begin
          payload, _header = JWT::Helper.decode(
            token,
            algorithm: 'HS256'
          )

          _type, sub = GraphQL::Schema::UniqueWithinType.decode(payload['sub'], separator: ':')
        rescue StandardError => e
          raise Exceptions::UnauthorizedError, e.message
        end

        begin
          find(sub)
        rescue ActiveRecord::RecordNotFound => e
          raise Exceptions::UnauthorizedError, e.message
        end
      end
    end
  end
end
