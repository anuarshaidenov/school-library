require './person.rb'

class Teacher < Person
    def initialize(name="unknown", age, specialization, parent_permission: true)
        super(name, age, parent_permission: true)
        @specialization = specialization
    end

    def can_use_services?
        true
    end
end

