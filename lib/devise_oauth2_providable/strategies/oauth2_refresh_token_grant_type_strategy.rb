require 'devise_oauth2_providable/strategies/oauth2_grant_type_strategy'

module Devise
  module Strategies
    class Oauth2RefreshTokenGrantTypeStrategy < Oauth2GrantTypeStrategy
      def grant_type
        'refresh_token'
      end

      def authenticate!
        if client && refresh_token = client.refresh_tokens.valid.find_by_token(params[:refresh_token])
          success! refresh_token.user
        elsif !halted?
          oauth_error! :invalid_grant, 'invalid refresh token'
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_refresh_token_grant_type, Devise::Strategies::Oauth2RefreshTokenGrantTypeStrategy)
