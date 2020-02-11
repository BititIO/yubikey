module Yubikey
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a Yubikey::OTP::Verify
    VALID_OPTIONS_KEYS = [
      :api_id,
      :url,
      :api_key,
    ].freeze

    # By default, we want to point to Yubicloud
    DEFAULT_API_URL           = 'https://api.yubico.com/wsapi/2.0/'

    # By default, don't have an api_id
    DEFAULT_API_ID            = nil

    # By default, don't have an api_key
    DEFAULT_API_KEY           = nil

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.api_id            = DEFAULT_API_ID
      self.url               = DEFAULT_API_URL
      self.api_key           = DEFAULT_API_KEY
    end
  end
end
