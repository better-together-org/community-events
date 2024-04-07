# planner-core.gemspec

$:.push File.expand_path('../lib', __FILE__)

require 'planner_core/version'

Gem::Specification.new do |s|
  s.name        = 'planner-core'
  s.version     = PlannerCore::VERSION
  s.authors     = ['Henry Balen', 'Ruth Leibig', 'Ian Stockdale', 'Cathy Mullican', 'Janice Gelb', 'Terry Fong', 'Philippe Hache']
  s.email       = ['info@grenadine.co']
  s.summary     = 'Core for the planning system.'
  s.description = 'Core of the planning system.'
  s.homepage    = 'http://www.myconferenceplanning.org'
  s.licenses    = ['Apache']
  s.files       = Dir['{app,config,db,lib}/**/*'] + %w(LICENSE Rakefile)
  s.test_files  = Dir["spec/**/*"]

  # Runtime dependencies
  s.add_dependency 'actionmailer'
  s.add_dependency 'activerecord'
  s.add_dependency 'activerecord-session_store', '1.1.3'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'audited-activerecord'
  s.add_dependency 'axlsx', '~> 3.0.0.pre'
  s.add_dependency 'axlsx_rails'
  s.add_dependency 'bcrypt'
  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'bootstrap3-datetimepicker-rails', '~> 4.7.14'
  s.add_dependency 'browser'
  s.add_dependency 'carrierwave'
  s.add_dependency 'cells', '~> 3.11.3'
  s.add_dependency 'ckeditor_rails', '4.17.0'
  s.add_dependency 'cloudinary'
  s.add_dependency 'connection_pool'
  s.add_dependency 'd3_rails'
  s.add_dependency 'dalli', '~> 2.7.6'
  s.add_dependency 'declarative_authorization'
  s.add_dependency 'deep_cloneable'
  s.add_dependency 'delayed_job'
  s.add_dependency 'delayed_job_active_record'
  s.add_dependency 'devise'
  s.add_dependency 'encoding_sampler'
  s.add_dependency 'figaro'
  s.add_dependency 'font_assets'
  s.add_dependency 'geocoder'
  s.add_dependency 'globalize'
  s.add_dependency 'globalize-accessors'
  s.add_dependency 'http_accept_language'
  s.add_dependency 'i18n'
  s.add_dependency 'i18n-js', '>= 3.0.0.rc11'
  s.add_dependency 'jbuilder'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'jpbuilder'
  s.add_dependency 'jqgrid-jquery-rails', '~> 4.5.200'
  s.add_dependency 'log4r'
  s.add_dependency 'loofah', '~> 2.1.1'
  s.add_dependency 'mysql2', '~> 0.5.3'
  s.add_dependency 'nokogiri', '~> 1.8.5'
  s.add_dependency 'power_enum'
  s.add_dependency 'prawn_rails'
  s.add_dependency 'prawn-table'
  s.add_dependency 'protected_attributes'
  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency 'rails-i18n', '~> 4.0.0'
  s.add_dependency 'ranked-model'
  s.add_dependency 'recaptcha'
  s.add_dependency 'responders', '~> 2.0'
  s.add_dependency 'routing-filter'
  s.add_dependency 'scrypt'
  s.add_dependency 'select2-rails'
  s.add_dependency 'shoulda-matchers'  # Assuming this is a runtime dependency, else move to development dependencies
  s.add_dependency 'time_diff'
  s.add_dependency 'twitter-typeahead-rails'
  s.add_dependency 'will_paginate'

  # Development dependencies
  s.add_development_dependency 'better_errors'
  s.add_development_dependency 'binding_of_caller'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_bot_rails', '~> 4.8.2'
  s.add_development_dependency 'rspec-rails', '~> 3.7.2'
end
