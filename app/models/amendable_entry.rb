class AmendableEntry
  def self.create!(attributes)
    new(attributes).save!
  end

  def initialize(attributes)
    @attributes = attributes
  end

  def save!
    entry.body = amended_body
    entry.save!
  end

  private

  attr_reader :attributes

  def amended_body
    [entry.body, body].compact.join("\n\n")
  end

  def entry
    @entry ||= Entry.find_or_initialize_by(user: user, date: date)
  end

  def body
    attributes.fetch(:body)
  end

  def user
    attributes.fetch(:user)
  end

  def date
    attributes.fetch(:date)
  end
end
