require 'csv'
require 'pp'
# require 'debugger'
require_relative '../app/models/legislator'
module LegislatorsImporter
  FIELDS = ["state",
            "type",
            "firstname",
            "middlename",
            "lastname",
            "name_suffix",
            "phone",
            "fax",
            "website",
            "webform",
            "party",
            "gender",
            "birthdate",
            "twitter_id"]

  def self.import(filename=File.dirname(__FILE__) + "/../db/data/legislators.csv")
    csv = CSV.new(File.open(filename), :headers => true)

    csv.each do |row|
      # Here we have to create instances of the Legislator class with the csv.each provide.
      legislator = Legislator.create!
      legislator.update_attribute("state", row["state"])
      legislator.update_attribute("type", row["title"])
      # puts row["title"]
      legislator.update_attribute("firstname", row["firstname"])
      legislator.update_attribute("middlename", row["middlename"])
      legislator.update_attribute("lastname", row["lastname"])
      legislator.update_attribute("name_suffix", row["name_suffix"])
      legislator.update_attribute("phone", row["phone"])
      legislator.update_attribute("fax", row["fax"])
      legislator.update_attribute("website", row["website"])
      legislator.update_attribute("webform", row["webform"])
      legislator.update_attribute("party", row["party"])
      legislator.update_attribute("gender", row["gender"])
      legislator.update_attribute("birthdate", row["birthdate"])
      legislator.update_attribute("twitter_id", row["twitter_id"])
      legislator.update_attribute("in_office", row["in_office"])
    end
  end

  # def self.to_bool char
  #   return false if char == "0"
  #   return true if char == "1"
  # end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
