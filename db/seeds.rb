user1 = User.create(:username => "grampa", :email => "grampa@grampa.com", :password => "grampa")

user2 = User.create(:username => "ronnie", :email => "ronnie@grampa.com", :password => "ronnie")

user3 = User.create(:username => "jer", :email => "jer@grampa.com", :password => "jer")

tweet1 = Tweet.create(:content => "i am a tweet", :user_id => "1")

tweet2 = Tweet.create(:content => "i am another tweet", :user_id => "2")

tweet3 = Tweet.create(:content => "i love grampa", :user_id => "3")

tweet4 = Tweet.create(:content => "i'm a good boy", :user_id => "1")

tweet5 = Tweet.create(:content => "he's a good boy", :user_id => "2")

tweet6 = Tweet.create(:content => "he really is a good boy", :user_id => "3")