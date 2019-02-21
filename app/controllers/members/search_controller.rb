class Members::SearchController < ApplicationController

  def index
    @current_member = Member.find(params[:member_id])
    @members = Member.search_for(params[:query], @current_member)
  end

end
