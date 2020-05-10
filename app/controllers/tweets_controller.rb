class TweetsController < ApplicationController
    get '/tweets' do 
        if !logged_in?
            redirect :'/users/login'
        else
        @tweets = Tweet.all
        erb :'/tweets/index'
        end
    end
    get '/tweets/new' do 
        if !logged_in?
            redirect :'/users/login'
        else
            erb :'/tweets/new'
        end
    end
    post '/tweets' do  
        unless params[:content] == ""
                @tweet = Tweet.new(id: params[:id], content: params[:content])
                @tweet[:user_id] = session[:user_id]
                @tweet.save  
                redirect "/tweets/#{@tweet.id}"
        end
           redirect '/tweets/new'
    end
    get '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        if !logged_in? 
        redirect '/login'
        end 
        erb :'/tweets/show'
    end 
    get '/tweets/:id/edit' do
        if !logged_in?
          redirect to '/login'
        end
        @tweet = Tweet.find_by_id(params[:id])
        if session[:user_id] != @tweet.user_id
          redirect to '/tweets'
        end
        erb :"/tweets/edit"
      end
    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if params["content"].empty?
          redirect to "/tweets/#{@tweet.id}/edit"
        end
        if session[:user_id] = @tweet.user_id
        @tweet.update(content: params[:content])
        @tweet.save
        end
        redirect to "/tweets/#{@tweet.id}"
    end
    
    delete '/tweets/:id' do
        if !logged_in?
          redirect to '/login'
        end
        @tweet = Tweet.find_by_id(params[:id])
        if session[:user_id] != @tweet.user_id
          redirect to '/tweets'
        end
        @tweet.destroy
        redirect to '/tweets'
    end
end