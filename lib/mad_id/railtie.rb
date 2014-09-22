module MadID
  class Railtie < ::Rails::Railtie
    initializer 'mad_id.initialize' do |app|
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send(:include, MadID)
      end
    end
  end
end
