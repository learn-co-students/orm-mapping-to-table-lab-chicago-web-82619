class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end



  def self.create_table

    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save

    sql = <<-SQL
        INSERT INTO students (name, grade) VALUES (?,?);
      SQL

      DB[:conn].execute(sql, self.name, self.grade)

    get_id = <<-SQL
        SELECT MAX(id) FROM STUDENTS
        SQL

        DB[:conn].execute(get_id) { |row|

          @id = row.first
        }

  end

  def self.create(params = {})
    student = Student.new(params[:name], params[:grade], params[:id])
    student.save
    student
  end


end
