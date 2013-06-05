source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0.rc1'
gem 'pg'

gem 'active_model_serializers'
gem 'attribute_normalizer'
gem 'default_value_for', github: 'firien/default_value_for', branch: 'master'
gem 'enumerize'
gem 'escape_utils'
gem 'faraday'
gem 'oj'
gem 'rails_config'
gem 'sorcery', github: 'NoamB/sorcery', branch: 'master'
gem 'twilio-ruby'
gem 'validates_email_format_of'
gem 'validates_telephone'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'

group :development do
  gem 'annotate'
end

group :development, :test do
  gem 'http_logger'
  gem 'letters'
  gem 'rspec-rails'
end

group :staging, :production do
  gem 'unicorn'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'valid_attribute'
  gem 'vcr'
end
