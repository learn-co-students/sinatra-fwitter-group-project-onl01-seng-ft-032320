class UsersController < ApplicationController
    get '/signup' do 
        if logged_in?
            redirect '/tweets'
        end
        erb :"users/create_user"
    end

    post '/signup' do
        unless params[:username] == "" || params[:email] == "" 
            user = User.new(username: params[:username], email: params[:email], password: params[:password])
            if user.save
                session[:user_id] = user.id
                redirect '/tweets'
            end
        end
        redirect '/signup'
    end

    get '/login' do 
        unless logged_in?
            erb :'users/login'
        else 
            redirect '/tweets'
        end
    end

    post '/login' do 
        user = User.find_by(username: params[:username])
        #binding.pry

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else 
            redirect '/login'
        end
    end

    get '/logout' do 
        if logged_in?
            session.clear 
        end
        redirect '/login'
    end

    post '/logout' do 
        session.clear
        redirect '/login'
    end

    get '/users/:slug' do
        # if logged_in?
            @user = User.find_by_slug(params[:slug])
            erb :'users/show'
        # else 
        #     redirect '/login'
        # end 
    end 

end
