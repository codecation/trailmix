class OhlifeExportParser < Parslet::Parser
  rule(:digit) { match('[0-9]') }
  rule(:hyphen) { str('-') }
  rule(:linebreak) { str("\r\n").repeat }

  rule(:date)  { linebreak >>
                 (digit.repeat(4) >>
                  hyphen >>
                  digit.repeat(2) >>
                  hyphen >>
                  digit.repeat(2)).as(:date) >>
                 linebreak }

  rule(:body) { (date.absent? >> any).repeat.as(:body) }

  rule(:entry) { date >> body }

  rule(:entries) { entry.repeat }

  root(:entries)
end
