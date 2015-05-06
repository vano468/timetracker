module Service
  class DeleteDepartment
    def initialize(department)
      @department = department
    end

    def delete
      cleanup_department(@department)
    end

    private

    def cleanup_department(department)
      reset_users(department)
      department.children.each do |c|
        cleanup_department(c)
      end
      department.destroy
    end

    def reset_users(department)
      department.employees.each do |e|
        e.update_attribute :department, nil
      end
    end
  end
end