class FriendshipGraph < ApplicationRecord

  serialize :data, Hash

  def search(from, to)
    return nil unless data[from].present?

    queue = Queue.new
    data[from].each { |id| queue.push([id]) }

    seen = []

    until queue.empty?
      path = queue.pop

      data[path.last].each do |id|
        new_path = path + [id]
        return new_path if id == to

        unless seen.include? id
          seen.push(id)
          queue.push(new_path)
        end
      end
    end

    return nil
  end

end
