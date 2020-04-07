require 'nokogiri'
require 'open-uri'
require "pry"

require_relative './course.rb'

class Scraper
  

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

  def get_page
    doc = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    doc_with_nokogiri = Nokogiri::HTML(doc)
    end
    
    def get_courses
      doc_n = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
      courses = doc_n.css('.post') 
    end 

    def make_courses
      get_courses.each do |a|
      course_name = a.css("h2").text
      course_schedule = a.css(".date").text
      course_description = a.css("p").text
      new_course = Course.new
      new_course.title = course_name
      new_course.schedule = course_schedule
      new_course.description = course_description
        end  
    end



end



