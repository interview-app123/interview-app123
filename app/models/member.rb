class Member < ApplicationRecord

  serialize :content, Array

  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :full_url
  validate :url_is_shortened

  after_create :set_content
  after_create :update_graph

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship',
    foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :member

  def friend_count
    friends.count + inverse_friends.count
  end

  def self.search_for(query, member)
    self.where("content LIKE :query", query: "%#{sanitize_sql_like(query)}%")
      .where.not(id: [member.id] + member.friend_ids )
  end

  def friend_ids
    friends.map {|friend| friend.id } +
      inverse_friends.map {|friend| friend.id }
  end

  private

  def url_is_shortened
    errors.add(:url, 'must be shortened') unless Embiggen::URI(url).shortened?
  end

  def set_content
    document = Nokogiri::HTML.parse(Net::HTTP.get(URI(full_url)))
    puts document.css('h1').children.map {|el| el.content }
    puts document.css('h2').children.map {|el| el.content }
    puts document.css('h3').children.map {|el| el.content }

    update_attribute(:content, [
      document.css('h1').children.map {|el| el.content },
      document.css('h2').children.map {|el| el.content },
      document.css('h3').children.map {|el| el.content }
    ])
  end

  def update_graph
    graph = FriendshipGraph.first
    graph.data[id] = []
    graph.save
  end

end
