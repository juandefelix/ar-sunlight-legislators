require 'csv'
require 'pp'
require 'debugger'
require_relative '../app/models/legislator'
class LegislatorsImporter
  FIELDS = ["state",
            "title",
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
      row.each do |field, value|
        legislator.update_attribute(field, value) if FIELDS.include? field
        # raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
        # TODO: end
      end
    end
  end
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
