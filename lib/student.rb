require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize (name, grade,id=nil)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.new_from_db(row)
    id,name,grade = row
    student = self.new(name,grade,id)
    student
  end
  
  def save 
    if self.id.nil?
      sql = <<-SQL
      INSERT INTO students(name,grade) VALUES (?,?)
      SQL
      DB[:conn].execute(sql,self.name,self.grade)
      
      @id = DB[:conn].execute("SELECT * FROM students").last.first
      # DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    else
      sql = <<-SQL
      UPDATE students SET name = ?,grade = ? WHERE id = ?
      SQL
      DB[:conn].execute(sql,self.name,self.grade,self.id)
    end
  end
  
  def self.find
  def self.create(name,grade)
    student = Student.new(name,grade)
    student.save
    student
  end
  
  
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT 
      )
    SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS students
    SQL
    DB[:conn].execute(sql)
  end
  
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]


end
