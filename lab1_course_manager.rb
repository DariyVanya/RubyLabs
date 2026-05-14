require "date"
require "json"
require "yaml"

module Lab1CourseManager
  module_function

  def next_id(collection)
    (collection.keys.max || 0) + 1
  end

  def add_course(collection, title, instructors, topics, category, start_date, end_date, duration_hours, price, status = "draft")
    id = next_id(collection)

    collection[id] = {
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

    collection
  end

  def edit_course(collection, id, new_data)
    course = collection[id]
    return nil unless course

    collection[id] = course.merge(new_data)
  end

  def delete_course(collection, id)
    collection.delete(id)
  end

  def list_courses(collection)
    collection.each do |id, course|
      puts "##{id}: #{course[:title]} (#{course[:status]})"
    end
  end

  def find_by_title(collection, query)
    query = query.to_s.downcase
    collection.select { |_id, course| course[:title].to_s.downcase.include?(query) }
  end

  def filter_by_status(collection, status)
    status = status.to_s.downcase
    collection.select { |_id, course| course[:status].to_s.downcase == status }
  end

  def filter_by_topic(collection, topic)
    topic = topic.to_s.downcase
    collection.select do |_id, course|
      course[:topics].any? { |value| value.to_s.downcase == topic }
    end
  end

  def save_to_json(collection, filename)
    File.write(filename, JSON.pretty_generate(collection))
  end

  def load_from_json(filename)
    data = JSON.parse(File.read(filename), symbolize_names: true)
    data.each_with_object({}) { |(id, course), memo| memo[id.to_i] = course }
  rescue Errno::ENOENT
    {}
  end

  def save_to_yaml(collection, filename)
    File.write(filename, YAML.dump(collection))
  end

  def load_from_yaml(filename)
    data = YAML.load_file(filename)
    data.each_with_object({}) { |(id, course), memo| memo[id.to_i] = course }
  rescue Errno::ENOENT
    {}
  end
end

if __FILE__ == $PROGRAM_NAME
  courses = {}

  Lab1CourseManager.add_course(
    courses,
    "Website Redesign",
    ["Ivan Petrenko", "Maria Koval"],
    ["Web", "Ruby", "Rails"],
    "Web Development",
    "2024-03-01",
    "2024-06-01",
    50,
    50_000.0,
    "active"
  )

  Lab1CourseManager.list_courses(courses)
end
