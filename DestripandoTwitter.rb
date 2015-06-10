require "nokogiri"
require "open-uri"

class TwitterScrapper
	# attr_reader :number_of_tweets, :number_of_followers

  def initialize(url)
		# @html_file = open(url)
  	@file = open_file(url)
  	@number_of_tweets = nil
  	@number_of_followers = nil
  end

  def open_file(url)
		Nokogiri::HTML(open(url))
#		Nokogiri::HTML(File.open('twitter_account.html'))
  end

  def extract_username
  	@username = @file.search(".ProfileHeaderCard-name > a")
  	@username.first.inner_text
  end

  def extract_tweets(n)
  	@couple = []
  	@tweets = []
  	for i in 1..n

	   	@time_stamp = @file.search(".stream-container > .stream > .stream-items > .js-stream-item:nth-child(#{i}) > .tweet > .content > .stream-item-header > .time > .tweet-timestamp > span").first.inner_text 
	   	@couple << @time_stamp
		  @tweet = @file.search(".stream-container > .stream > .stream-items > .js-stream-item:nth-child(#{i}) > .tweet > .content > p").inner_text
	   	@couple << @tweet
	   	# Retweets
	  	# @retweets = @file.search(".stream-container > .stream > .stream-items > .js-stream-item > .tweet > .content > .stream-item-footer > .ProfileTweet-actionList > .ProfileTweet-action > .ProfileTweet-actionButton > .ProfileTweet-actionCount > span.ProfileTweet-actionCountForPresentation").inner_text 
	  	# p @retweets


	  	@tweets << @couple
	  	@couple = []
  	end
  	for i in 0...n
  		print "#{@tweets[i][0]}.: #{@tweets[i][1]}\n"
  	end
  	return
  end

  def extract_stats
  	@stats = []

  	@number_of_tweets = @file.search(".ProfileNav-list > .ProfileNav-item:nth-child(1) > .ProfileNav-stat > span:nth-child(2)")
  	@stats << @number_of_tweets.first.inner_text
  	@following = @file.search(".ProfileNav-list > .ProfileNav-item:nth-child(2) > .ProfileNav-stat > span:nth-child(2)")
  	@stats << @following.first.inner_text
  	@followers = @file.search(".ProfileNav-list > .ProfileNav-item:nth-child(3) > .ProfileNav-stat > span:nth-child(2)")
  	@stats << @followers.first.inner_text
  	@favorites = @file.search(".ProfileNav-list > .ProfileNav-item:nth-child(4) > .ProfileNav-stat > span:nth-child(2)")
  	@stats << @favorites.first.inner_text
  end

	def work_flow(file)
		
	end
end

# twitter = TwitterScrapper.new("twitter_account.html")

twitter = TwitterScrapper.new("https://twitter.com/codeacamp")

puts "Username: #{twitter.extract_username}"
puts "-" * 80
print "Stats: ", "\tTweets: #{twitter.extract_stats[0]}", 
"\tSiguiendo: #{twitter.extract_stats[1]}", 
"\tSeguidores: #{twitter.extract_stats[2]}",
"\tFavoritos: #{twitter.extract_stats[3]}", "\n"
puts "-" * 80
puts "Tweets:"
# puts "\t#{twitter.extract_tweets[0]}: twitter.extract_tweets[0]"
puts "Cuantos tweets quieres?"
respuesta = gets.chomp.to_i
#puts respuesta.to_i.class
puts "#{twitter.extract_tweets(respuesta)}"


# p twitter.extract_tweets(5)








