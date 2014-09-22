require "mad_id/version"

require "active_record"
require "active_support"

require "mad_id/identity_methods"
require "mad_id/finder_methods"
require "mad_id/railtie" if defined?(Rails)

module MadID
  extend ActiveSupport::Concern

  included do
    def self.identify_with(value)
      @identifier = value
      self.send(:include, MadID::IdentityMethods)
    end
  end

end
