# config/initializers/00_debug_db_configs.rb
if Rails.env.production?
  Rails.application.config.after_initialize do
    puts "DEBUG: ActiveRecord configurations after application initialization:"
    puts ActiveRecord::Base.configurations.inspect
    puts "--- End of DEBUG ---"
  end
end
