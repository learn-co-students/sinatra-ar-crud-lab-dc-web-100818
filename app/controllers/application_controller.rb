require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  set :views, "app/views"
  use Rack::MethodOverride

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/posts" do
     #load a list of all my posts
     @posts = Post.all
     erb :index
  end

  get "/posts/new" do
    erb :new
  end

  post "/posts" do
    @post = Post.create(name: params["name"], content: params["content"])
    redirects to "/posts"
  end

  get "/posts/:id" do
    @post = Post.find_by_id(params[:id])
   erb :show
  end

  get "/posts/:id/edit" do
    @post = Post.find_by_id(params[:id])
    erb :edit
  end

  patch "/posts/:id" do #edit action
   @post = Post.find_by_id(params[:id])
   @post.name = params[:name]
   @post.content = params[:content]
   @post.save
   redirect to "/posts/#{@post.id}"
  end

  delete "/posts/:id" do
     @post = Post.find_by_id(params[:id])
     @post.delete
     redirect to "/posts"
  end

end
