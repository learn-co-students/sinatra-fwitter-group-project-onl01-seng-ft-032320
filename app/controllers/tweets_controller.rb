class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?(session)
            @user = current_user
            @tweets = Tweet.all
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if !params[:content].empty?
            @user = current_user
            @user.tweets.create(content: params[:content])
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/new' do
        if logged_in?(session)
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
        if logged_in?(session)
            erb :'/tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
        if current_user.id == @tweet.user_id
            @tweet.destroy
            redirect '/tweets'
        else
            redirect "/tweets/#{@tweet.id}"
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?(session)
            @tweet = Tweet.find_by(id: params[:id])
            erb :'/tweets/edit_tweet'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do

        if params[:content].empty?
            redirect "/tweets/#{params[:id]}/edit"
        else
            @tweet = Tweet.find_by(id: params[:id])
            @tweet.update(content: params[:content])
            redirect "/tweets/#{params[:id]}"
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @tweets = @user.tweets
        erb :'/tweets/tweets'
    end
end
