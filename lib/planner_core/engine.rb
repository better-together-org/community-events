#
#
#
require 'active_support/all'
require 'acts-as-taggable-on'
require 'audited-activerecord'
require 'axlsx_rails'
require 'bootstrap-sass'
require 'bootstrap3-datetimepicker-rails'
require 'browser'
require 'carrierwave'
require 'cells'
require 'ckeditor_rails'
require 'cloudinary'
require 'connection_pool'
require 'd3_rails'
require 'declarative_authorization'
require 'deep_cloneable'
require 'devise'
require 'dalli'
require 'encoding_sampler'
require 'figaro'
require 'font_assets'
require 'geocoder'
require 'i18n'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'jbuilder'
require 'jpbuilder'
require 'jqgrid-jquery-rails'
require 'log4r'
# require 'momentjs-rails'
require 'mysql2'
require 'power_enum'
require 'protected_attributes'
require 'prawn_rails'
require 'prawn/table'
require 'recaptcha'
require 'recaptcha/rails'
require 'routing-filter'
require 'ranked-model'
require 'select2-rails'
require 'time_diff'
require 'twitter-typeahead-rails'
require 'http_accept_language'
require 'will_paginate'
# require 'country_select'
# require 'authority'
# require 'i18n/js'


module PlannerCore
  class Engine < ::Rails::Engine

    # Add the assets in the engine to those to be precompiled
    initializer :assets do |app|
      app.config.assets.precompile += %W(
        pages/*.js
        pages/*.css
        panels/*.js
        panels/*.css
        survey_respondents/*.js
        survey_respondents/*.css
        surveys/*.js
        surveys/*.css
        users/*.js
        grenadine/ckeditor-edit.css
        jquery.js
        iframeResizer.contentWindow.js
        images/*.png
      )
    end

    config.to_prepare do
      Dir.glob(PlannerCore::Engine.config.paths["lib"].expanded[0] + "/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
      Dir.glob(PlannerCore::Engine.config.paths["lib"].expanded[0] + "/planner/**/*.rb").each do |c|
        require_dependency(c)
      end
    end

    # RAILS 3 mechanism so parent app use the migrations in this engine
    # see http://pivotallabs.com/leave-your-migrations-in-your-rails-engines/
    # initializer :append_migrations do |app|
      # # unless the engine is the multi-tenant planner_front
      # unless (app.root.to_s.match root.to_s) || (app.engine_name == "planner_front_application")
        # app.config.paths["db/migrate"] += config.paths["db/migrate"].expanded
      # end
    # end

    #
    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    #
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    initializer :before_initialize do
      ActionController::Base.send(:include, Planner::ControllerAdditions)
      Cell::Rails.send(:include, Devise::Controllers::Helpers)
      Cell::Rails.send(:include, Planner::ControllerAdditions)
      ActionMailer::Base.send(:include, Planner::ControllerAdditions)
    end

    initializer :after_initialize do
      Cell::Rails.prepend_view_path(PlannerCore::Engine.config.paths["app/views"].expanded[0])
      ActiveRecord::Base.send(:include, Planner::Linkable)
      Planner::Linkable.setup
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        load PlannerCore::Engine.root.join('db', 'seeds.rb')
      end
    end
  end
end
