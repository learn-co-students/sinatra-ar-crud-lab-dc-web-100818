
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

   # gets all the Post instances
  # loads index page
  get "/posts" do 
    @posts = Post.all
    erb :index
  end

  # loads a new form
  get "/posts/new" do 
    erb :new
  end

  # creates a post instance
  # redirect to get '/posts' 
  post "/posts" do
    name = params[:name]
    content = params[:content]
    Post.create(name: name, content: content)
    redirect to "/posts"
  end


  # gets id from url and uses it to find that (id) post instance from Post
  # loads show page
  get "/posts/:id" do
    post_id = params[:id]
    @post = Post.find(post_id)
    erb :show
  end

  # gets id from url and uses it to find that (id) post instance from Post
  # loads edit page
  get "/posts/:id/edit" do 
    @post = Post.find(params[:id])
    erb :edit
  end

  # gets id from url and uses it to find that (id) post instance from Post
  # Updates Post 
  patch "/posts/:id" do 
    post = Post.find(params[:id])
    post.update(name: params[:name], content: params[:content])
    redirect "/posts/#{post.id}"
  end

  delete "/posts/:id/delete" do 
    post = Post.find(params[:id])
    post.destroy
    erb :delete
  end
end
