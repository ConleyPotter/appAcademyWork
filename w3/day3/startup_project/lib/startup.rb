require "employee"

class Startup
  attr_reader :name ,:funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name = name
    @funding = funding
    @salaries = salaries
    @employees = []
  end

  def valid_title?(title)
    @salaries.include?(title)
  end

  def >(startup)
    @funding > startup.funding
  end

  def hire(employee_name, title)
    if self.valid_title?(title)
      employee = Employee.new(employee_name, title)
      @employees << employee
    else
      raise "not valid title"
    end
  end

  def size
    @employees.length
  end

  def pay_employee(employee)
    salary = @salaries[employee.title]
    if salary < @funding
      employee.pay(salary)
      @funding -= salary
    else
      raise "not enough money to pay employee"
    end
  end

  def payday
    @employees.each { |employee| self.pay_employee(employee) }
  end

  def average_salary
    total_payroll = 0
    employees.each do |employee| 
      total_payroll += @salaries[employee.title]
    end
    total_payroll / @salaries.length * 1.0
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(another_startup)
    @funding += another_startup.funding
    @salaries = @salaries.merge(another_startup.salaries) { |key, oldval, newval| oldval }
    @employees.concat(another_startup.employees)
    another_startup.close
  end
end

