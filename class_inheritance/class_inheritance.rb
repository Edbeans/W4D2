class Employee 
    attr_reader :name, :title, :salary, :bose
    def initialize(name, title, salary, boss = nil)
        @name = name
        @title = title
        @salary = salary 
        @boss = boss 
    end
    
    def bonus(multiplier)
        salary * multiplier
    end
end

class Manager < Employee
    attr_reader :employees
    def initialize(name, title, salary, boss = nil, employees)
        super(name, title, salary, boss)
        @employees = employees  #array
    end
    
    def bonus(multiplier)
        total_sub_salary = 0
        employees.each { |employee| total_sub_salary += employee.salary }
        total_sub_salary * multiplier
    end
end