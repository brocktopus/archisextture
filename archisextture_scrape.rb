$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/library' )

require 'lonely_coder'
require "rubygems"

#install with gem install sequel
require "sequel"

# connect to an in-memory database
DB = Sequel.connect('sqlite://matches.db')

# create an items table
DB.create_table :matches do
  primary_key :id
  String :location
  String :orientation
  String :sex
end

okc = OKCupid.new('username', 'password')

matches = Array.new()

#[1,2,3,4,5].each do |thispage|
['guys who like guys', 'guys who like girls', 'both who like bi guys', 'girls who like guys', 'girls who like girls', 'both who like bi girls'].each do |orients|
  ['Raleigh, NC', 'New York, NY', 'Boise, ID', 'San Francisco, CA'].each do |locale|
matches += okc.search({
 # :page => 'thispage',
  :pagination => {
    :page => 1, 
    :per_page => 500
    },
  :min_age => 18,
  :max_age => 99,
  :gentation => orients,
  :order_by => 'Match %',
  :match_limit => 1000,
  :last_login => 'last month',
  :location => locale,
}).results()
  end
end


# create a dataset from the items table
# you will need to delete/move previous database file
items = DB[:matches]

#insert each found object. 
matches.each do |match|
  items.insert(:location => match.location, :orientation => match.orientation, :sex => match.sex)
end

# print out the number of records
puts "Item count: #{items.count}"

