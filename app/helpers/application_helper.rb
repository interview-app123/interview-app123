module ApplicationHelper

  def search_result_connection(member)
    path = FriendshipGraph.first.search(@current_member.id, member.id)
    return 'no mutual friendships' unless path
    path.map {|id| Member.find(id).name }.join(' > ')
  end

  def search_result_match(member)
    member.content.flatten.select {|header| header.downcase.include? params[:query] }
      .join(', ')
  end

end
