class TweetsController < ApplicationController

    configure do
        enable :sessions
        set :session_secret, "secret"
      end



    get "/tweets" do
        if !logged_in?
            redirect "/login"
        end 
        @user = Helpers.current_user(session)
        @tweets = Tweet.all
        erb :"/tweets/index"
        
    end

    get "/tweets/new" do 
        if logged_in?
          erb :"/tweets/new"
        else
          redirect "/login"
        end
    end 

    post "/tweets" do
      #binding.pry
      if !logged_in?
        
      end 

      tweet = current_user.tweets.new(content: params["content"])
      if logged_in?
      
        if params[:content].empty? 
          redirect "/tweets/new"
        else tweet.save
          redirect "/tweets"
          
        end 
      else

      redirect "/login"
      end  
    end 

    get "/tweets/:id" do
      if !logged_in?
        redirect "/login"
      end 
      @tweet = Tweet.find(params[:id]) 
      erb :"/tweets/show"
      
    end

    get "/tweets/:id/edit" do 
      if !logged_in?
        redirect "/login"
      end 
      #binding.pry
      @tweet = Tweet.find(params[:id])

      if current_user.id != @tweet.user_id
        redirect "/tweets"
      end 
      erb :"/tweets/edit"

    end 

    patch "/tweets/:id" do
      if !logged_in?
        redirect "/login"
      end 
      #binding.pry
      @tweet = Tweet.find(params[:id])
      if params[:content].empty?
        redirect "/tweets/#{@tweet.id}/edit"
      else @tweet
        @tweet.content = params[:content]
        @tweet.save
        redirect "/tweets"
      end 
      
    end 
    
    delete '/tweets/:id/delete' do #delete action
      if !logged_in?
        redirect "/login"
      end 
     
      @tweet = Tweet.find(params[:id])
      if current_user.id != @tweet.user_id
        redirect "/tweets"
      end 
      @tweet.delete
      redirect to '/tweets'
    end
    

    helpers do
        def logged_in?
          !!session[:user_id]
        end
    
        def current_user
          User.find(session[:user_id])
        end
      end

end
