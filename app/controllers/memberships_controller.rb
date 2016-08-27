class MembershipsController < ApplicationController
  before_action :authenticate_user!
  def index
    @memberships = Student.find_by_id(params[:student_id]).memberships
  end
end
