require 'rubygems'
require "curb"
require 'json'

$blogname=corgiaddict
$api_key=""

def tumble(action, options="")
  JSON.parse(Curl::Easy.perform("http://api.tumblr.com/v2/blog/#{$blogname}.tumblr.com/#{action}?api_key=#{$api_key}#{options}").body_str)
end

def number_of_posts
  tumble("info")["response"]["blog"]["posts"]
end

def number_of_pages
  number_of_posts/20
end

def get_photos
  number_of_pages.times do |i|
    tumble("posts/photo", "&offset=#{i*20}")["response"]["posts"].each do |item|
      system "curl -O #{item["photos"][0]["alt_sizes"][1]["url"]}"
    end
  end
end

get_photos
