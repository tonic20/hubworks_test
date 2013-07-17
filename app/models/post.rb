class Post < ActiveRecord::Base
  def generate_permalink
    p = title.to_slug.normalize.to_s
    unless check_uniqueness(p)
      v = 0
      while !check_uniqueness("#{p}-#{v}")
        v += 1
      end
      p = "#{p}-#{v}"
    end
    self.permalink = p
  end

  def check_uniqueness(p)
    # try to use new cool feature where.not
    !Post.where(permalink: p).where.not(id: id).exists?
  end
end