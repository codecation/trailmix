class AdminDashboard
  def users_by_day_since(date)
    users_created_since(date).group_by_day(:created_at).count
  end

  def entries_by_day_since(date)
    Entry.where("date >= ?", date).group_by_day(:date).count
  end

  def users_created_since(date)
    User.where("created_at >= ?", date)
  end

  def entries_per_day_for(user)
    (entry_count_for(user) / account_age_for(user)).to_f.round(1)
  rescue ZeroDivisionError
    0
  end

  def trial_status_for(user)
    entries_per_day = entries_per_day_for(user)

    if entries_per_day <= 0.3
      "danger"
    elsif entries_per_day <= 0.5
      "warning"
    else
      "great"
    end
  end

  private

  def entry_count_for(user)
    user.entries.where("created_at >= ?", user.created_at.to_date).count
  end

  def account_age_for(user)
    Time.zone.now.to_date - user.created_at.to_date
  end
end
