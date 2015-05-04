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

    def locate(id)
      prefix, _ = id.to_s.split('-', 2)
      if klass = registry[prefix]
        klass.find_by_mad_id(id)
      else
        nil
      end
    end

    def locate!(id)
      prefix, _ = id.to_s.split('-', 2)
      registry.fetch(prefix).find_by_mad_id!(id)
    end
  end

  included do
    extend(MadID::FinderMethods)
    def self.identify_with(value, options = {})
      self.mad_id_column = options[:column] || 'identifier'
      @identifier = value
      MadID.registry[value.to_s] = self
      self.send(:include, MadID::IdentityMethods)
    end
  end
end
