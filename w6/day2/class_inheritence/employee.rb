class Employee
    attr_reader :name, :title, :salary
    attr_accessor :boss

    def initialize(name, title, salary, boss)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
        @boss.subordinate(self) unless boss.nil?
    end

    def bonus(multiplier)
        bonus = salary *= multiplier
    end
end

class Manager < Employee
    
    def initialize(name, title, salary, boss)
        super(name, title, salary, boss)
        @assigned_employees_under_self = []
    end

    def bonus(multiplier)
        multiplier * subordinate_salary
    end

    def subordinate_salary
        sub_salary = 0
        @assigned_employees_under_self.each do |employee|
            if employee.is_a?(Manager)
                sub_salary += employee.salary + employee.subordinate_salary
            else
                sub_salary += employee.salary
            end
        end
        sub_salary
    end

    def subordinate(employee)
        employee.boss = self
        @assigned_employees_under_self << employee
    end
end

