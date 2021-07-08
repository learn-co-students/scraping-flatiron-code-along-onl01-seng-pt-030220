require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    doc = get_page
    doc.css(".post")
  end

  def make_courses
    doc = get_courses
    doc.each do |course|
      instance = Course.new
      instance.title = course.css("h2").text
      instance.schedule = course.css(".date").text
      instance.description = course.css("p").text
    end
  end
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end



