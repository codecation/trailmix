class OhlifeExportParser < Parslet::Parser
  rule(:integer) { match('[0-9]').repeat(1) }
  rule(:hyphen) { str('-') }
  rule(:date)  { integer.repeat(1,4).as(:year) >>
                 hyphen >>
                 integer.repeat(1,2).as(:month) >>
                 hyphen >>
                 integer.repeat(1,2).as(:day) >>
                 str("\n\n") }

  rule(:body) { any.repeat.as(:body) }
  rule(:entry) { date >> body }
  root(:entry)
end
