class Export
  def initialize(user, today = Time.current.to_date)
    @user = user
    @today = today
  end

  def filename
    "trailmix-#{today}.json"
  end

  def to_json
    user.entries.to_json(only: [:body, :date])
  end

  private

  attr_reader :user, :today
end
