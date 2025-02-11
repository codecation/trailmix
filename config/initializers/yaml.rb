# Patch to address incompatability between Ruby 3.1 and Psych 4.x
# https://stackoverflow.com/a/71192990

module YAML
  class << self
    alias_method :load, :unsafe_load if YAML.respond_to? :unsafe_load
  end
end
