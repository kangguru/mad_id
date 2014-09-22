module MadID
  class Railtie < ::Rails::Railtie
    initializer 'mad_id.initialize' do |app|
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send(:include, MadID)
        ActiveRecord::Base.extend( MadID::FinderMethods)
      end
    end
  end
end
