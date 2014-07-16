module MadId

  module IdentityMethods
    extend ActiveSupport::Concern

    included do
      before_save :set_identifier, on: :create

      def self.object_identifier_prefix
        @identifier
      end
    end

    def set_identifier
      self.identifier = "#{self.class.object_identifier_prefix}-#{SecureRandom.uuid}"[0..34]
    end

    def short_identifier
      self.identifier[0..11]
    end

    def to_param
      self.identifier
    end

  end

end
