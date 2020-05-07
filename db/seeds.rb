require_relative '../config/environment'

names = %w[nancy bob sam ben wiel meghan evan adam]

names.each do |name|
    email = name + "@gmail.com"
    password = name + "123"
    user = User.new(username: name, email: email, password: password)
    3.times do 
        sentence = Faker::Quote.famous_last_words
        user.tweets.build(content: sentence)
    end
    user.save
end
