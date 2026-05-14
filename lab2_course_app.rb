require "json"
require "yaml"
require "date"

class Course
  attr_accessor :title, :instructors, :topics, :category, :start_date, :end_date, :duration_hours, :price, :status

  def initialize(title, instructors, topics, category, start_date, end_date, duration_hours, price, status = "draft")
    @title = title
    @instructors = instructors
    @topics = topics
    @category = category
    @start_date = start_date
    @end_date = end_date
    @duration_hours = duration_hours
    @price = price
    @status = status
  end

  def to_h
    {
      title: title,
      instructors: instructors,
      topics: topics,
      category: category,
      start_date: start_date,
      end_date: end_date,
      duration_hours: duration_hours,
      price: price,
      status: status
    }
  end

  def self.from_h(hash)
    new(
      hash[:title] || hash["title"],
      hash[:instructors] || hash["instructors"] || [],
      hash[:topics] || hash["topics"] || [],
      hash[:category] || hash["category"],
      hash[:start_date] || hash["start_date"],
      hash[:end_date] || hash["end_date"],
      hash[:duration_hours] || hash["duration_hours"],
      hash[:price] || hash["price"],
      hash[:status] || hash["status"] || "draft"
    )
  end
end

class CourseManager
  attr_reader :collection

  def initialize
    @collection = {}
  end

  def add_course(course)
    collection[next_id] = course
  end

  def edit_course(id, new_data)
    course = collection[id]
    return nil unless course

    new_data.each do |key, value|
      course.public_send("#{key}=", value) if course.respond_to?("#{key}=")
    end

    course
  end

  def delete_course(id)
    collection.delete(id)
  end

  def list_courses
    collection.values
  end

  def find_by_title(query)
    query = query.to_s.downcase
    collection.select { |_id, course| course.title.to_s.downcase.include?(query) }
  end

  def filter_by_status(status)
    status = status.to_s.downcase
    collection.select { |_id, course| course.status.to_s.downcase == status }
  end

  def filter_by_topic(topic)
    topic = topic.to_s.downcase
    collection.select do |_id, course|
      course.topics.any? { |value| value.to_s.downcase == topic }
    end
  end

  def save_to_json(filename)
    payload = collection.transform_values(&:to_h)
    File.write(filename, JSON.pretty_generate(payload))
  end

  def load_from_json(filename)
    parsed = JSON.parse(File.read(filename), symbolize_names: true)
    @collection = parsed.each_with_object({}) do |(id, course_hash), memo|
      memo[id.to_i] = Course.from_h(course_hash)
    end
  rescue Errno::ENOENT
    @collection = {}
  end

  def save_to_yaml(filename)
    File.write(filename, YAML.dump(collection))
  end

  def load_from_yaml(filename)
    parsed = YAML.load_file(filename)
    @collection = parsed.each_with_object({}) do |(id, course), memo|
      memo[id.to_i] = course
    end
  rescue Errno::ENOENT
    @collection = {}
  end

  private

  def next_id
    (collection.keys.max || 0) + 1
  end
end

class App
  def initialize(manager = CourseManager.new)
    @manager = manager
    load_data
  end

  def run
    loop do
      puts
      puts "1. List courses"
      puts "2. Add course"
      puts "3. Find by title"
      puts "4. Filter by status"
      puts "5. Filter by topic"
      puts "6. Save and exit"
      print "> "

      case gets&.chomp
      when "1"
        @manager.list_courses.each { |course| puts course.title }
      when "2"
        @manager.add_course(prompt_course)
      when "3"
        print "Title query: "
        p @manager.find_by_title(gets&.chomp || "")
      when "4"
        print "Status: "
        p @manager.filter_by_status(gets&.chomp || "")
      when "5"
        print "Topic: "
        p @manager.filter_by_topic(gets&.chomp || "")
      when "6"
        break
      else
        puts "Unknown command"
      end
    end
  ensure
    save_data
  end

  private

  def prompt_course
    print "Title: "
    title = gets&.chomp || ""
    print "Instructors (comma-separated): "
    instructors = (gets&.chomp || "").split(",").map(&:strip).reject(&:empty?)
    print "Topics (comma-separated): "
    topics = (gets&.chomp || "").split(",").map(&:strip).reject(&:empty?)
    print "Category: "
    category = gets&.chomp || ""
    print "Start date (YYYY-MM-DD): "
    start_date = gets&.chomp || ""
    print "End date (YYYY-MM-DD): "
    end_date = gets&.chomp || ""
    print "Duration hours: "
    duration_hours = gets&.chomp.to_i
    print "Price: "
    price = gets&.chomp.to_f
    print "Status (draft/active/archived): "
    status = gets&.chomp || "draft"
    Course.new(title, instructors, topics, category, start_date, end_date, duration_hours, price, status)
  end

  def load_data
    @manager.load_from_yaml("courses.yml")
    return unless @manager.collection.empty?

    @manager.load_from_json("courses.json")
  end

  def save_data
    @manager.save_to_yaml("courses.yml")
  end
end

if __FILE__ == $PROGRAM_NAME
  App.new.run
end
