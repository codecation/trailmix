# Addresses a deprecation warning with json 1.8.6 and Ruby 2.7
# https://github.com/ruby/json/issues/399#issuecomment-734863279

module JSON
  module_function

  def parse(source, opts = {})
    Parser.new(source, **opts).parse
  end
end
