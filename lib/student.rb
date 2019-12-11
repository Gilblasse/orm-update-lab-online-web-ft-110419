require_relative "../config/environment.rb"

class Student

  def initialize (name, grade)
    @id = nil
    @name = name
    @grade = grade
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end
