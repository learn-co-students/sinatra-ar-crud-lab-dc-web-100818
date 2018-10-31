require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    Post.create(name: params["name"], content: params["content"])

    redirect '/posts'
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])

    erb :show
  end

  get '/posts/:id/edit' do
    @edit_post = Post.find(params[:id])

    erb :edit
  end

  patch '/posts/:id' do
    @new_name = params["name"]
    @new_content = params["content"]
    @edited_post = Post.find(params["id"])

    if @new_name != nil
      @edited_post.update_attribute(:name, @new_name)
    end
    if @new_content != nil
      @edited_post.update_attribute(:content, @new_content)
    end

    redirect "/posts/#{@edited_post.id}"
  end

  delete '/posts/:id/delete' do
    @all_posts = Post.all

    @all_posts.destroy(params["id"])

    redirect '/posts'
  end

end
