class FillInDateTransition
  def perform
    entries.find_each { |entry| set_date(entry) }
  end

  private

  def set_date(entry)
    entry.update_attributes!(date: entry.created_at.to_date)
  end

  def entries
    Entry.where(date: nil)
  end
end
