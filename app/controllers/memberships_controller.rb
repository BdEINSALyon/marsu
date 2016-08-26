class MembershipsController < ApplicationController
  def index
    @memberships = Student.find_by_id(params[:student_id]).memberships
  end
end
