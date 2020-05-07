class TweetsController < ApplicationController

    get '/tweets' do 
        
        if logged_in?   
            @tweets = Tweet.all
            @user = current_user
            @logged_in = logged_in?
            
            erb :'tweets/tweets'
        else 
            redirect '/login'
        end
    end

    post '/tweets' do 
        if params[:content] == ""
            redirect '/tweets/new'
        else 
            current_user.tweets.create(content: params[:content])
            if current_user.save
                #go where we go on successful save
                redirect "/users/#{current_user.slug}"
            else 
                redirect '/tweet/new'
            end
        end 
    end

    get '/tweets/new' do
        if logged_in?
            @logged_in = logged_in?
            erb :"tweets/new"
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            @user = current_user
            erb :'tweets/show_tweet'
        else 
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            @logged_in = logged_in?
            erb :"tweets/edit_tweet"
        else 
            redirect '/login'
        end 
    end 

    delete '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user == current_user
            @tweet.destroy
        end
        redirect '/tweets'
    end

    patch '/tweets/:id' do 
        tweet = Tweet.find_by_id(params[:id])
        if params[:content] != ""
            tweet.update(content: params[:content])
            redirect "/tweets/#{params[:id]}"
        else 
            redirect "/tweets/#{tweet.id}/edit"
        end
    end
    

    

end
