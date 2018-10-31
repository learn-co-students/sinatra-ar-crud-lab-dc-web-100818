
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    post_name = params[:name]
    post_content = params[:content]
    Post.create(:name => post_name, :content => post_content)
    redirect "/posts"
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @post.destroy
    redirect "/posts"
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update(:name => params[:name], :content => params[:content])
    redirect "/posts/#{@post.id}"
  end

  get '/posts/:id' do
    post_id = params[:id]
    @post = Post.find(post_id)
    erb :show
  end

end
