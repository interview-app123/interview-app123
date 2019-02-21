class Friendship < ApplicationRecord

  belongs_to :member
  belongs_to :friend, class_name: 'Member'

  after_create :update_friendship_graph

  private

  def update_friendship_graph
    graph = FriendshipGraph.first
    graph.data[member.id].push(friend.id)
    graph.data[friend.id].push(member.id)
    graph.save
  end

end
