class TweetsController < ApplicationController

    get '/tweets' do
        @tweets = Tweet.all
        if logged_in?
            @user = current_user
            erb :'/tweets/tweets'
        else 
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect to '/login'
        end
    end

    post '/tweets' do
        if !logged_in?
            redirect '/login'
        else
            @user = current_user
            if params["content"] == ""
                redirect '/tweets/new'
            else
                @tweet = Tweet.create(content: params[:content], user_id: @user.id)
                erb :'/users/show'
            end
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in? 
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/edit_tweet'
        else
            redirect '/login'
        end
    end
    
    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if !logged_in?
            redirect '/login'
        elsif params["content"] == ""
            redirect "/tweets/#{@tweet.id}/edit"
        else
            @tweet.update(content: params[:content])
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        end
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if logged_in?
            @user = current_user
            @tweet.delete if @user.id == @tweet.user_id
            redirect '/tweets'
        else
            redirect '/login'
        end
    end
end
