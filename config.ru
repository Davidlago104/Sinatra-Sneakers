require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#in order to patch and delete request with this.
use Rack::MethodOverride
# html and sinatra, only post and get, not patch and delete

#where I mount my controllers
run ApplicationController
use SneakersController
use UsersController
