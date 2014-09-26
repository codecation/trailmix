class OhlifeImporter
  def initialize(user, import)
    @user = user
    @import = import
  end

  def run
    export.each_line(separator) do |line|
      if is_start_of_entry?(line)
        process_new_entry(line)
      else
        append_to_existing_entry(line)
      end
    end

    save_entry
  end

  private

  attr_reader :user, :import

  def is_start_of_entry?(line)
    line =~ /\d\d\d\d-\d\d-\d\d/
  end

  def process_new_entry(line)
    if @entry
      save_entry
    end

    @entry = Entry.new(body: "", user: user, import: import)
    @entry.created_at = line
  end

  def save_entry
    @entry.body.strip!
    @entry.save!
  end

  def append_to_existing_entry(line)
    line = convert_to_unix_line_endings(line)
    @entry.body.concat(line)
  end

  def convert_to_unix_line_endings(line)
    line.strip.concat("\n")
  end

  def export
    import.ohlife_export.file.to_file
  end

  def separator
    "\r\n"
  end
end
