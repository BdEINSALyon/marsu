unless @student.nil?
  json.extract! @student, :id, :first_name, :last_name, :email, :phone
  json.study_year @student.study_year.name if @student.study_year
  json.department @student.department.name if @student.department
  json.memberships do
    json.array! @student.memberships do |membership|
      json.extract! membership, :name, :price, :start_date, :end_date
    end
  end
end