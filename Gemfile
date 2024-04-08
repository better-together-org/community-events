# Gemfile

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'activerecord-session_store', '1.1.3'
gem 'enumerations_mixin', :github => 'mrj/enumerations_mixin'
gem 'geocoder'
# gem 'i18n-active_record', :require => 'i18n/active_record'
gem 'nokogiri', '~> 1.8.5'
gem 'mysql2', '~> 0.5.3'
gem "i18n-js", ">= 3.0.0.rc11"
gem 'globalize', '~> 5.1.0' # Use the version compatible with your Rails version
gem 'globalize-accessors'

gem 'axlsx', '~> 3.0.0.pre', :github => 'randym/axlsx', :branch => 'release-3.0.0'

group :assets do
  gem 'sass-rails', '~> 5.0.7'
end

# group :development do
#   gem "better_errors"
#   gem "binding_of_caller"
# end

group :test do
  gem 'test-unit', '~> 3.0'
end

# group :development, :test do
#   gem 'rspec-rails', '~> 3.7.2'
#   gem 'factory_bot_rails', '~> 4.8.2'
# end

gemspec
