require 'twitter'

module Tw

  CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key    = "0288EjrqBYfDYlCu6KKuCg"
    config.consumer_secret = "vsoPYgiHrqaNy0qXebyCi0DMsNgkmzOy04FvsGUUwI"
    config.access_token        = "1621066105-8h9Wm8zxgGz3Zfopa3vIx2ckNnfyrq9VQf4LlRZ"
    config.access_token_secret = "LEn4qH9SYuGajKbufnE46CpuidVVncobL8K1QeFvxK4W8"
    end

  def self.get_10_tweets_from(user)
    CLIENT.user_timeline(user, {:count => 10})
  end

  def self.print_ten_tweets_from(user)
    puts
    self.get_10_tweets_from(user).each_with_index { |tweet, i| puts; puts "#{i+1}. #{tweet.full_text}"; puts}
    puts
  end
end

Tw.print_ten_tweets_from("BarackObama")