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

    def to_param
      self.identifier
    end

    def identifier=(value)
      write_attribute(self.class.mad_id_column, value)
    end
    def identifier
      read_attribute(self.class.mad_id_column)
    end
  end

end
