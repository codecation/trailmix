class FixFutureDatedEntriesTransition
  def self.perform
    new.perform
  end

  def perform
    entries_with_dates_in_the_future.each do |entry|
      entry.update_attribute(:date, entry.date - 1.year)
    end
  end

  private

  def entries_with_dates_in_the_future
    Entry.where("date > ?", Date.today)
  end
end
