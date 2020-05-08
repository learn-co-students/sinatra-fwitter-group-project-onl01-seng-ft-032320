class TweetsController < ApplicationController

    #create
    get '/tweets/new' do
        if logged_in?
            #create a new tweet so send to a form
            erb :"/tweets/new"
        else 
            redirect "/login"
        end 
    
    end 

    post '/tweets' do
        if logged_in? 
            #create tweet that belongs to user
            if !params[:content].empty?
                tweet = current_user.tweets.build(content: params[:content])
                if tweet.save
                    redirect "/tweets"
                else
                    redirect "/tweets/new"
                end 
            else
                redirect "/tweets/new" 
            end 
        else  

        end
    end 

    #read
    get "/tweets" do 
        if logged_in?
            @tweets = Tweet.all
            erb :"/tweets/tweets"
        else   
            redirect "/login"
        end
    end

    get "/tweets/:id" do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :"/tweets/show_tweet"
        else
            redirect "/login"
        end
    end

    #update
    get '/tweets/:id/edit' do 
        if logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            if current_user.tweets.include?(@tweet)
                erb :"/tweets/edit_tweet"
            else
                redirect "/tweets"
            end
        else 
            redirect "/login"
        end
        
    end
  
    patch '/tweets/:id' do 
        if logged_in? 
            if !params[:content].empty?
                #update the tweet
                @tweet = Tweet.find_by_id(params[:id])
                    if current_user.tweets.include?(@tweet)
                        @tweet.update(content: params[:content])
                    else  
                        redirect "/tweets/#{params[:id]}/edit"
                    end 
                redirect "/tweets/#{@tweet.id}"
            else
                 redirect "/tweets/#{params[:id]}/edit"
            end 
        else
            redirect "/login"
        end
    end

    delete '/tweets/:id' do  #delete is the verb
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id]) # this is use so if not found a nil is returned. 
            if current_user.tweets.include?(@tweet)
                @tweet.delete
            else  
                redirect "/tweets"
            end 
        else 
            redirect 'login'
        end
    end 


end
