class Export
  def initialize(user)
    @user = user
  end

  def filename
    "trailmix-#{Date.current}.json"
  end

  def to_json
    user.entries.to_json(only: [:body, :date])
  end

  private

  attr_reader :user
end
