class UsersController < ApplicationController

    configure do
        enable :sessions
        set :session_secret, "secret"
      end

      get "/" do
        if logged_in?
          redirect "/tweets"
        end  
        erb :"/users/home"
      end

      get "/signup" do 
        if logged_in?
          redirect "/tweets"
        else 
          erb :"/users/signup"
        end 
      
      end 

      post "/signup" do
        #binding.pry 
        
        if params[:username].blank? || params[:email].blank? || params[:password].blank?
          redirect to "/signup"

             #username && user.email && user.password 
        end 
        user = User.create(params)
        session[:user_id] = user.id
        
        redirect "/tweets"

      end 

      get "/login" do
        if logged_in?
          redirect "/tweets"
        end  
        erb :"/users/login"
      end 

      post "/login" do 
        user = User.find_by(username: params[:username])

		    if user && user.authenticate(params[:password])
			    session[:user_id] = user.id
              redirect "/tweets"
		    else
			      redirect "/failure"
		    end
      end
      
      get "/logout" do
        if logged_in?
        session.clear
        redirect "/login"
        else 
          redirect "/"
        end 
        
      end
      
      get "/users/:slug" do
        slug = params[:slug]
        @user = User.find_by(slug)
        erb :"/users/show"
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
