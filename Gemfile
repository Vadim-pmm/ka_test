source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.0'
gem 'rails', '~> 5.0.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'carrierwave'

gem 'devise'
gem 'devise-bootstrap-views'
gem 'twitter-bootstrap-rails'

gem 'react-rails'
gem 'flux-rails-assets'
gem 'lodash-rails'
gem 'sprockets-es6'

#gem 'sprockets', '~> 4.x'
#gem 'babel-schmooze-sprockets'

group :development, :test do
  gem 'listen', '~> 3.0.5'

  gem 'rspec-rails'
  gem 'factory_girl_rails'
end
gem 'web-console', group: :development

group :test do
  gem 'faker'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'rails-controller-testing'
end

