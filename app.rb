require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "repository/cookbook.rb"
require_relative "model/recipe.rb"
# set :method_override, true

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
  # use Rack::MethodOverride
end

# Hot to inherit templates!
# get "/" do
#   @usernames = [ "ssaunier", "Papillard" ]
#   erb :index, :layout => :lay
# end

def cookbook
  Cookbook.new('repository/recipes.csv')
end

get '/' do
  cookbook
  @recipes = cookbook.all
  erb :index
end

get '/recipe/create' do
  erb :new
end

post '/recipe/store' do
  cookbook
  name = params[:name]
  description = params[:description]
  prep_time = params[:prep_time]
  rating = params[:rating]
  attributes = { name: name,
                 description: description,
                 prep_time: prep_time,
                 rating: rating }
  recipe = Recipe.new(attributes)
  cookbook.add_recipe(recipe)
  redirect('/')
end

delete '/recipe/delete/:id' do
  cookbook
  index = params[:id].to_i
  cookbook.remove_recipe(index)
  redirect('/')
end

get '/recipe/edit/:id' do
  cookbook
  @index = params[:id].to_i
  @recipe = cookbook.find(@index)
  erb :edit
end

put '/recipe/:id' do
  cookbook
  @index = params[:id].to_i
  attributes = { name: params[:name],
                 description: params[:description],
                 prep_time: params[:prep_time],
                 rating: params[:rating] }
  cookbook.update(@index, attributes)
  redirect('/')
end

put '/recipe/mark/:id' do
  cookbook
  index = params[:id].to_i
  cookbook.mark_recipe(index)
  redirect('/')
end

get '/import' do
  erb :import
end
