require 'nokogiri'
require 'open-uri'
require_relative './course.rb'


class Scraper

    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    html = open('http://learn-co-curriculum.github.io/site-for-scraping/courses')
    doc = Nokogiri::HTML(html)
  end

  def get_courses
    doc = self.get_page
    courses = doc.css(".posts-holder .post")
  end

  def make_courses
    courses = []

    self.get_courses.each { |course_data|
      course = Course.new
      course.title = course_data.css("h2").text
      course.schedule = course_data.css("em").text
      course.description = course_data.css("p").text
      courses << course
    }
    courses

  end

end
