require "pry"
require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

  def print_courses
    #make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
     doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
     #binding.pry
  end

  def get_courses
      self.get_page.css(".posts-holder")  #or .css(".post")
  end

  def make_courses
      get_courses.each do |postholder|
        course = Course.new
        course.title = postholder.css("h2").text
        course.schedule = postholder.css("date").text
        course.description = postholder.css("p").text
      end
  end

end
