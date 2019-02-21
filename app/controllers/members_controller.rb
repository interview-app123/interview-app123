class MembersController < ApplicationController

  def index
    @members = Member.all
  end

  def new
    @member = Member.new
  end

  def create
    begin
      member = Member.new(create_params)

      unless member.save
        flash[:error] = member.errors.full_messages.join(', ')
        redirect_to new_member_path and return
      end

      redirect_to member_path(member)
    rescue ActionController::ParameterMissing => exception
      flash[:error] = exception.message
      redirect_to new_member_path
    rescue Embiggen::TooManyRedirects => exception
      flash[:error] = 'Shortened URL has too many redirects'
      redirect_to new_member_path
    rescue Embiggen::BadShortenedURI => exception
      flash[:error] = 'The URL is invalid. Please try another shortened url'
      redirect_to new_member_path
    rescue Embiggen::NetworkError => exception
      flash[:error] = 'There was an error processing the URL. Please try again'
      redirect_to new_member_path
    end
  end

  def show
    @member = Member.find(params[:id])
    @h1_contents = @member.content.first
    @h2_contents = @member.content.second
    @h3_contents = @member.content.third
    @friends = @member.friends + @member.inverse_friends
  end

  private

  def create_params
    accepted_params = params.require(:member).permit(:name, :url)
    accepted_params.merge({
      full_url: Embiggen::URI(accepted_params[:url]).expand
    })
  end

end
