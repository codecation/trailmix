class PromptEntry
  def initialize(entries)
    @entries = entries
  end

  def self.best(entries)
    new(entries).best
  end

  def best
    entries.random
  end

  private

  attr_reader :entries
end
