require "rubygems"

# to install this on the command line: jgem install jdbc-sqlite3
require 'jdbc/sqlite3'

# to install this on the command line: jgem install sequel
require "sequel"

# connect to db
myDB = Sequel.jdbc('sqlite:matches.db')
@straightguys = 0
@strguy_ral = 0
@strguy_nyc = 0
@strguy_boi = 0
@strguy_san = 0

@straightgals = 0
@strgal_ral = 0
@strgal_nyc = 0
@strgal_boi = 0
@strgal_san = 0

@gayguys = 0
@gayguy_ral = 0
@gayguy_nyc = 0
@gayguy_boi = 0
@gayguy_san = 0

@gaygals = 0
@gaygal_ral = 0
@gaygal_nyc = 0
@gaygal_boi = 0
@gaygal_san = 0

@biguys = 0
@biguy_ral = 0
@biguy_nyc = 0
@biguy_boi = 0
@biguy_san = 0

@bigals = 0
@bigal_ral = 0
@bigal_nyc = 0
@bigal_boi = 0
@bigal_san = 0

# Sqlite is basically SQL put SQL query here
#this gets all
matches = myDB.fetch("SELECT * FROM matches")

#10524
10524.times do |match|
  temp_ori = matches.all[match][:orientation]
  temp_sex = matches.all[match][:sex]
  temp_geo = matches.all[match][:location]
  
  if ((temp_ori == "Straight") && (temp_sex == "M"))
    @straightguys+=1
    if (temp_geo.index("Carolina"))
      @strguy_ral+=1
    elsif ((temp_geo.index("New York")) || (temp_geo.index("Jersey")))
      @strguy_nyc+=1
    elsif (temp_geo.index("Idaho"))
      @strguy_boi+=1
    elsif (temp_geo.index("California"))
      @strguy_san+=1
    end
  elsif ((temp_ori == "Straight") && (temp_sex == "F"))
    @straightgals+=1
    if (temp_geo.index("NC"))
      @strgal_ral+=1
    elsif ((temp_geo.index("New York")) || (temp_geo.index("Jersey")))
      @strgal_nyc+=1
    elsif (temp_geo.index("Idaho"))
      @strgal_boi+=1
    elsif (temp_geo.index("California"))
      @strgal_san+=1
    end
  elsif ((temp_ori == "Gay") && (temp_sex == "M"))
    @gayguys+=1
    if (temp_geo.index("Carolina"))
      @gayguy_ral+=1
    elsif ((temp_geo.index("New York")) || (temp_geo.index("Jersey")))
      @gayguy_nyc+=1
    elsif (temp_geo.index("Idaho"))
      @gayguy_boi+=1
    elsif (temp_geo.index("California"))
      @gayguy_san+=1
    end
  elsif ((temp_ori == "Gay") && (temp_sex == "F"))
    @gaygals+=1
    if (temp_geo.index("NC"))
      @gaygal_ral+=1
    elsif ((temp_geo.index("New York")) || (temp_geo.index("Jersey")))
      @gaygal_nyc+=1
    elsif (temp_geo.index("Idaho"))
      @gaygal_boi+=1
    elsif (temp_geo.index("California"))
      @gaygal_san+=1
    end
  elsif ((temp_ori == "Bi") && (temp_sex == "M"))
    @biguys+=1
    if (temp_geo.index("NC"))
      @biguy_ral+=1
    elsif ((temp_geo.index("New York")) || (temp_geo.index("Jersey")))
      @biguy_nyc+=1
    elsif (temp_geo.index("Idaho"))
      @biguy_boi+=1
    elsif (temp_geo.index("California"))
      @biguy_san+=1
    end
  elsif ((temp_ori == "Bi") && (temp_sex == "F"))
    @bigals+=1
    if (temp_geo.index("NC"))
      @bigal_ral+=1
    elsif ((temp_geo.index("New York")) || (temp_geo.index("Jersey")))
      @bigal_nyc+=1
    elsif (temp_geo.index("Idaho"))
      @bigal_boi+=1
    elsif (temp_geo.index("California"))
      @bigal_san+=1
    end
  end
end

puts "Straight Guys: " + @straightguys.to_s
puts "Straight Guys in Raleigh: " + @strguy_ral.to_s
puts "Straight Guys in New York: " + @strguy_nyc.to_s
puts "Straight Guys in Boise: " + @strguy_boi.to_s
puts "Straight Guys in San Francisco: " + @strguy_san.to_s

puts "Straight Gals: " + @straightgals.to_s
puts "Straight Gals in Raleigh: " + @strgal_ral.to_s
puts "Straight Gals in New York: " + @strgal_nyc.to_s
puts "Straight Gals in Boise: " + @strgal_boi.to_s
puts "Straight Gals in San Francisco: " + @strgal_san.to_s

puts "Gay Guys: " + @gayguys.to_s
puts "Gay Guys in Raleigh: " + @gayguy_ral.to_s
puts "Gay Guys in New York: " + @gayguy_nyc.to_s
puts "Gay Guys in Boise: " + @gayguy_boi.to_s
puts "Gay Guys in San Francisco: " + @gayguy_san.to_s

puts "Gay Gals: " + @gaygals.to_s
puts "Gay Gals in Raleigh: " + @gaygal_ral.to_s
puts "Gay Gals in New York: " + @gaygal_nyc.to_s
puts "Gay Gals in Boise: " + @gaygal_boi.to_s
puts "Gay Gals in San Francisco: " + @gaygal_san.to_s

puts "Bi Guys: " + @biguys.to_s
puts "Bi Guys in Raleigh: " + @biguy_ral.to_s
puts "Bi Guys in New York: " + @biguy_nyc.to_s
puts "Bi Guys in Boise: " + @biguy_boi.to_s
puts "Bi Guys in San Francisco: " + @biguy_san.to_s

puts "Bi Gals: " + @bigals.to_s
puts "Bi Gals in Raleigh: " + @bigal_ral.to_s
puts "Bi Gals in New York: " + @bigal_nyc.to_s
puts "Bi Gals in Boise: " + @bigal_boi.to_s
puts "Bi Gals in San Francisco: " + @bigal_san.to_s


