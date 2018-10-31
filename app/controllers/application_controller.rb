require_relative '../../config/environment'
require "pry"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get "/posts/new" do
    erb :new
  end

  get "/posts" do
    @posts = Post.all
    erb :index
  end

  post "/posts" do
    # binding.pry
    Post.create(params)
    # @posts = Post.all
    erb :index
  end

  get "/posts/:id" do
    @post = Post.find(params[:id])
    # binding.pry
    erb :show
  end

  get "/posts/:id/edit" do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch "/posts/:id" do
    @post = Post.find(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    erb :show
  end

  delete "/posts/:id/delete" do
    # binding.pry
    Post.destroy(params[:id])
    redirect "/"
  end
end
