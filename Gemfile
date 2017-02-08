source 'https://rubygems.org'

ruby '2.1.7'

gem 'rails', '~> 4.0.0'

gem 'jquery-rails'
gem 'pygments.rb'
gem 'twitter-bootstrap-rails'
gem 'less-rails'
gem 'warden-github'
gem 'passenger'

group :development do
  gem 'foreman'
  gem 'pg'
end

gem 'coffee-rails', '~> 4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', '~> 0.12.1'

gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'

# Use unicorn as the app server
group :production do
  gem 'pg'
  gem 'unicorn'

  # required for static asset serving and logging on Heroku
  gem 'rails_12factor', '~> 0.0.2'
end

gem 'rspec', group: [ :test, :development ]

group :test do
  gem 'capybara'
  gem 'rspec-rails'
end
