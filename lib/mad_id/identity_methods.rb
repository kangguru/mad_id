module MadID

  module IdentityMethods
    extend ActiveSupport::Concern

    included do
      before_create :set_identifier
      attr_readonly :identifier

      def self.object_identifier_prefix
        @identifier
      end
    end

    def set_identifier
      self.identifier = "#{self.class.object_identifier_prefix}-#{SecureRandom.uuid}"[0..34].downcase
    end

    def short_identifier
      self.identifier[0..11]
    end

    module UrlMethods
      def to_param
        self.identifier
      end
    end

  end

end
