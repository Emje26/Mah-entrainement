# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

# French inflections
ActiveSupport::Inflector.inflections(:fr) do |inflect|
  inflect.plural(/^(eau)$/i, '\1x')
  inflect.plural(/^(eu)$/i, '\1x')
  inflect.plural(/^(au)$/i, '\1x')
  inflect.singular(/^(eau)x$/i, '\1')
  inflect.singular(/^(eu)x$/i, '\1')
  inflect.singular(/^(au)x$/i, '\1')
end
