class Search
  include ActiveModel::Model

  attr_accessor :term, :user

  def entries
    if term.blank?
      []
    else
      user.entries.by_date.where(
        "LOWER(body) LIKE ?",
        "%#{Entry.sanitize_sql_like(term.downcase)}%"
      )
    end
  end
end
