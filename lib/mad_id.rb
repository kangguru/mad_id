require "mad_id/version"

require "active_record"
require "active_support"

require "mad_id/identity_methods"
require "mad_id/finder_methods"
require "mad_id/railtie" if defined?(Rails)

module MadID
  extend ActiveSupport::Concern

  @registry = {}
  class << self
    attr_accessor :registry
  end

  included do
    def self.identify_with(value)
      @identifier = value
      MadID.registry[value.to_s] = self
      self.send(:include, MadID::IdentityMethods)
    end
  end
end
