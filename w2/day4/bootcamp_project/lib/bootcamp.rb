class Bootcamp
    def initialize(name, slogan, student_capacity)
      @name = name
      @slogan = slogan
      @student_capacity = student_capacity
      @teachers = []
      @students = []
      @grades = Hash.new { |hash, key| hash[key] = [] }
    end

    def name
      @name
    end

    def slogan 
      @slogan
    end

    def teachers
      @teachers
    end

    def students
      @students
    end

    def hire(teacher)
      @teachers << teacher
    end

    def enroll(student)
      if @student_capacity > @students.length
        @students << student
        return true
      else
        return false
      end
    end

    ### WALKTHROUGH SOLUTION ###

    # def enroll(student)
    #   if @students.length < @student_capacity
    #     @students << student
    #     return true
    #   end

    #   false
    # end

    def enrolled?(student)
      if @students.include?(student)
        return true
      else
        return false
      end
    end

    def student_to_teacher_ratio
      return @students.length / @teachers.length
    end

    def add_grade(student, grade)
      if self.enrolled?(student)
        @grades[student] << grade
        return true
      else
        return false
      end
    end

    def num_grades(student)
      return @grades[student].length
    end

    def average_grade(student)
      sum_of_grades = @grades[student].sum
      if sum_of_grades > 0
        return @grades[student].sum / self.num_grades(student)
      else
        return nil
      end
    end
end
