class Members::FriendshipsController < ApplicationController

  def create
    @member = Member.find(params[:member_id])
    friend = Member.find_by(id: params[:id])

    if friend
      friendship = Friendship.create(member: @member, friend: friend)

      unless friendship.valid?
        flash[:error] = friendship.errors.full_messages.join(', ')
      end
    else
      flash[:error] = 'Invalid friend id'
    end

    redirect_to member_path(@member)
  end

end
