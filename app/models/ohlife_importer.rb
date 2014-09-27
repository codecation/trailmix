class OhlifeImporter
  def initialize(user, import)
    @user = user
    @import = import
  end

  def run
    OhlifeExportParser.new.parse(export).map do |entry|
      Entry.new(created_at: entry[:date].to_s,
                body: entry[:body].to_s,
                user: user,
                import: import)
    end.map(&:save!)
  end

  private

  attr_reader :user, :import

  def export
    ohlife_export = import.ohlife_export

    if ohlife_export.file.is_a?(CarrierWave::SanitizedFile)
      ohlife_export.read
    else
      open(ohlife_export.url)
    end
  end
end
