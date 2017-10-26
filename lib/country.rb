require 'countries/global'
require 'yaml'

if defined?(Country)
  class CountryNotFoundError < StandardError
  end

  Country.class_eval do
    Country::ALIAS_FILE_PATH = File.join('data', 'address_aliases.yml')
    # add aliases for countries to their unofficial names
    Country::ALIASES = YAML.load_file(Country::ALIAS_FILE_PATH)['country'].freeze
    Country::ALPHA2 = Country.all.map(&:alpha2).freeze
    ALIASES.each do |name, code|
      Country[code].unofficial_names << name
    end

    # convert string into ISO 3166-1 alpha-2
    def self.find_alpha2(name)
        country = Country.try_find(name)
        unless country
          raise CountryNotFoundError, "Couldn't find country code for #{name}"
        end
        country.alpha2
    end

    def self.try_find(name)
      (Country.find_country_by_name(name) ||
      deep_search(name) ||
      Country[ALIASES[name]]) if name
    end

    def self.deep_search(name)
      Country.all do |code, _|
        other_names = (Country[code].unofficial_names || []).compact
        translated_names = (Country[code].translated_names || []).compact
        next unless other_names.any? { |other_name| other_name.casecmp(name).zero? } ||
          translated_names.any? { |t_name| t_name.casecmp(name).zero? }

        return Country[code]
      end
      nil
    end
  end
end
