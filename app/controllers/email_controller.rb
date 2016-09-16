class EmailController < ApplicationController

  def show
    if params[:key].nil?
      @student = nil
      @key = nil
    else
      @student = GlobalID::Locator.locate_signed params[:key]
      @key = @student.to_sgid
    end
    render :layout => false
  end

end
