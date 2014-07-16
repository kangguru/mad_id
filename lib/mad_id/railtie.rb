module MadId
  class Railtie < ::Rails::Railtie
    initializer 'mad_id.initialize' do |app|
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send(:include, MadId)
      end
    end
  end
end
