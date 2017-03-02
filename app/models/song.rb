class Song < ActiveRecord::Base
  validates :title, presence: true
  validate :is_released?
  validate :not_future?
  validate :already_this_year?

  def is_released?
    # binding.pry
    if released && release_year == nil
      errors.add(:release_year, "must exist if released")
    end
  end

  def not_future?
    # binding.pry
    if released && release_year != nil
      if release_year > 2017
        errors.add(:release_year, "must be this year or earlier")
      end
    end
  end

  def already_this_year?
    # binding.pry
    @song = Song.find_by(title: self.title)
    if @song && @song != self
      if [self.title, self.released, self.release_year, self.artist_name] == [@song.title, @song.released, @song.release_year, @song.artist_name]
        errors.add(:release_year, "already released that year")
      end
    end
  end

end
