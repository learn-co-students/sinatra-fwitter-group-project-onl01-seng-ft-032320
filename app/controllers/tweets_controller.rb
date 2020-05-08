class TweetsController < ApplicationController

   get '/tweets' do
      if logged_in?(session)
         @user = current_user(session)
         @tweets = Tweet.all
         erb :"/tweets/tweets"
      else
         redirect '/login'
      end
   end

   get '/tweets/new' do
      if logged_in?(session)
         erb :"/tweets/new"
      else
         redirect '/login'
      end
   end

   get '/tweets/:id' do
      if logged_in?(session)
         @user = current_user(session)
         @tweet = Tweet.find_by(id: params[:id])
         erb :'/tweets/show_tweet'
      else
         redirect '/login'
      end
   end

   get '/tweets/:id/edit' do
      if logged_in?(session)
         @user = current_user(session)
         @tweet = Tweet.find_by(id: params[:id])
         erb :'/tweets/edit_tweet'
      else
         redirect '/login'
      end
   end

   post '/tweets' do
      if logged_in?(session)
         user = current_user(session)
         tweet = user.tweets.build(content: params[:content])
         if tweet.save
            redirect "/tweets/#{tweet.id}"
         else
            redirect '/tweets/new'
         end
      else
         redirect '/login'
      end
   end

   patch '/tweets/:id' do
      if logged_in?(session)
         user = current_user(session)
         tweet = user.tweets.find_by(id: params[:id])
         if tweet.update(content: params[:content])
            redirect "/tweets/#{tweet.id}"
         else
            redirect "/tweets/#{tweet.id}/edit"
         end 
      else
         redirect '/login'
      end
   end

   delete '/tweets/:id' do
      if logged_in?(session)
         user = current_user(session)
         tweet = user.tweets.find_by(id: params[:id])
         tweet.delete if user.tweets.include?(tweet)
         redirect'/tweets'
      else
         redirect '/login'
      end
   end
   
end
