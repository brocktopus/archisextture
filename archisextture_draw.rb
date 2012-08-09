load_library 'context_free'
load_library 'control_panel'

require "rubygems"
require 'jdbc/sqlite3'
require "sequel"

=begin

This Ruby-Processing program makes use of OK Cupid profile scraping 
(see archisextture_scrape.rb for more) via trek's "lonely_coder" gem 
(https://github.com/trek/lonely_coder). As this program was meant to 
provide relatively quick rendering for our audience, we generated a 
separate DB output file (archisextture_data_output.rb) to provide us 
with static numbers with which to calculate our city blocks.

A more dynamic file (not reliant on basically-static variables like this 
one) will be forthcoming.

=end

# connect to db
DB = Sequel.jdbc('sqlite:matches.db')

# Sqlite is basically SQL put SQL query here
#this gets all
matches = DB.fetch("SELECT * FROM matches")

# the following numbers are based off a search & db crunch from 5/12/12
# for quicker rendering
$straightguys = 3680
$strguy_ral = 930
$strguy_nyc = 915
$strguy_boi = 928
$strguy_san = 907

$straightgals = 2978
$strgal_ral = 793 # got '0', extrapolated
$strgal_nyc = 809
$strgal_boi = 624
$strgal_san = 752

$gayguys = 1808
$gayguy_ral = 484
$gayguy_nyc = 594
$gayguy_boi = 136
$gayguy_san = 594

$gaygals = 832
$gaygal_ral = 187 # got '0', extrapolated
$gaygal_nyc = 318
$gaygal_boi = 42
$gaygal_san = 285

$biguys = 261
$biguy_ral = 87 # got '0', extrapolated
$biguy_nyc = 62
$biguy_boi = 31
$biguy_san = 81

$bigals = 965
$bigal_ral = 229 # got '0', extrapolated
$bigal_nyc = 268
$bigal_boi = 120
$bigal_san = 348

$ral_results = 2710.0
$nyc_results = 2966.0
$boi_results = 1881.0
$san_results = 2967.0
$totalresults = 10524.0

$currentcity = $ral_results
$currname = ""

$size_of_block = ($ral_results/$totalresults) * 2

$num_of_hoods = 5
$girls_looking_for_guys_color = [1.0, 0.2, 1.0]
$girls_looking_for_girls_color = [0.2, 1.0, 1.0]
$guys_looking_for_guys_color = [1.0, 1.0, 0.2]
$guys_looking_for_girls_color = [0.2, 0.2, 0.2]

$rot_block_quarter_a = rand(8)-4
$rot_block_quarter_b = rand(8)-4
$rot_block_quarter_c = rand(8)-4
$rot_block_quarter_d = rand(8)-4

$quarter_a = $girls_looking_for_girls_color
$quarter_b = $girls_looking_for_guys_color
$quarter_c = $guys_looking_for_girls_color
$quarter_d = $guys_looking_for_guys_color

  # Based heavily on jashkenas' context_free example syntax
  # https://github.com/jashkenas/context_free
def setup_the_city

  @city = ContextFree.define do

    rule :neighborhood do
      split do
    setupx = 0.25
    setupy = 0.25
        block :x => -setupx, :y => -setupy, :color => $quarter_a, :rotation => $rot_block_quarter_a
        rewind
        block :x => setupx, :y => -setupy, :color => $quarter_b,:rotation => $rot_block_quarter_b
        rewind
        block :x => setupx, :y => setupy, :color => $quarter_c,:rotation => $rot_block_quarter_c
        rewind
        block :x => -setupx, :y => setupy, :color => $quarter_d,:rotation => $rot_block_quarter_d
      end
    end  

    
    rule :block do
      buildings :size => $size_of_block
    end
    
    rule :block, $num_of_hoods do
      neighborhood :size => 0.5, :brightness => rand + 0.75
    end
    
    rule :block, 0.1 do
      # Do nothing
    end
    
    rule :buildings do
      square
    end
    
  end
end

def setup



  size 1000, 600
  smooth
  @background = color 255, 255, 255
    control_panel do |c|
      c.menu(:options, ['Raleigh', 'New York', 'Boise', 'San Francisco'], 'Raleigh') {|m| set_city(m) }
	c.checkbox "Girls Seeking Girls", :girls_looking_for_girls,true
	c.checkbox "Girls Seeking Guys", :girls_looking_for_guys,true
	c.checkbox "Guys Seeking Girls", :guys_looking_for_girls,true
	c.checkbox "Guys Seeking Guys", :guys_looking_for_guys,true
	c.button "Map It",:draw_it
    end
end

  # Control panel syntax based upon the example in
  # https://github.com/jashkenas/ruby-processing/wiki/Control-Panel


def set_city(city)
	$currname = city
	if(city == 'Raleigh')
		$currentcity = $ral_results
	elsif (city == 'New York')
		$currentcity = $nyc_results
	elsif (city == 'Boise')
		$currentcity = $boi_results
	else
		$currentcity = $san_results
	end
	$size_of_block = ($currentcity/$totalresults) * 2
	$num_of_hoods = 5
end

def set_rotation
	if($currname == 'Raleigh')
		if (@girls_looking_for_girls)
			$rot_block_quarter_a = rand($gaygal_ral/100)-($bigal_ral/100)
		end
		if (@girls_looking_for_guys)
			$rot_block_quarter_b = rand($strgal_ral/100)-($biguy_ral/100)
		end
		if (@guys_looking_for_girls)
			$rot_block_quarter_c = rand($strguy_ral/100)-($bigal_ral/100)
		end
		if (@guys_looking_for_guys)
			$rot_block_quarter_d = rand($gayguy_ral/100)-($biguy_ral/100)
		end

	elsif ($currname == 'New York')
		if (@girls_looking_for_girls)
			$rot_block_quarter_a = rand($gaygal_nyc/100)-($bigal_nyc/100)
		end
		if (@girls_looking_for_guys)
			$rot_block_quarter_b = rand($strgal_nyc/100)-($biguy_nyc/100)
		end
		if (@guys_looking_for_girls)
			$rot_block_quarter_c = rand($strguy_nyc/100)-($bigal_nyc/100)
		end
		if (@guys_looking_for_guys)
			$rot_block_quarter_d = rand($gayguy_nyc/100)-($biguy_nyc/100)
		end

	elsif ($currname == 'Boise')
		if (@girls_looking_for_girls)
			$rot_block_quarter_a = rand($gaygal_boi/100)-($bigal_boi/100)
		end
		if (@girls_looking_for_guys)
			$rot_block_quarter_b = rand($strgal_boi/100)-($biguy_boi/100)
		end
		if (@guys_looking_for_girls)
			$rot_block_quarter_c = rand($strguy_boi/100)-($bigal_boi/100)
		end
		if (@guys_looking_for_guys)
			$rot_block_quarter_d = rand($gayguy_boi/100)-($biguy_boi/100)
		end

	else
		if (@girls_looking_for_girls)
			$rot_block_quarter_a = rand($gaygal_san/100)-($bigal_san/100)
		end
		if (@girls_looking_for_guys)
			$rot_block_quarter_b = rand($strgal_san/100)-($biguy_san/100)
		end
		if (@guys_looking_for_girls)
			$rot_block_quarter_c = rand($strguy_san/100)-($bigal_san/100)
		end
		if (@guys_looking_for_guys)
			$rot_block_quarter_d = rand($gayguy_san/100)-($biguy_san/100)
		end

	end

end

def draw
  # Do nothing
end

def draw_it
	if (@girls_looking_for_girls)
	$quarter_a = $girls_looking_for_girls_color
	elsif (@girls_looking_for_guys)
	$quarter_a = $girls_looking_for_guys_color
	elsif (@guys_looking_for_girls)
	$quarter_a = $guys_looking_for_girls_color
	elsif (@guys_looking_for_guys)
	$quarter_a = $guys_looking_for_guys_color			
	end

	if (@girls_looking_for_guys)
	$quarter_b = $girls_looking_for_guys_color
	elsif (@girls_looking_for_girls)
	$quarter_b = $girls_looking_for_girls_color
	elsif (@guys_looking_for_girls)
	$quarter_b = $guys_looking_for_girls_color
	elsif (@guys_looking_for_guys)
	$quarter_b = $guys_looking_for_guys_color
	end

	if (@guys_looking_for_girls)
	$quarter_c = $guys_looking_for_girls_color
	elsif (@guys_looking_for_guys)
	$quarter_c = $guys_looking_for_guys_color
	elsif (@girls_looking_for_girls)
	$quarter_c = $girls_looking_for_girls_color
	elsif (@girls_looking_for_guys)
	$quarter_c = $girls_looking_for_guys_color
	end

	if (@guys_looking_for_guys)
	$quarter_d = $guys_looking_for_guys_color
	elsif (@girls_looking_for_girls)
	$quarter_d = $girls_looking_for_girls_color
	elsif (@girls_looking_for_guys)
	$quarter_d = $girls_looking_for_guys_color
	elsif (@guys_looking_for_girls)
	$quarter_d = $guys_looking_for_girls_color
	end
	
set_rotation

setup_the_city
  background @background
  @city.render :neighborhood, 
               :start_x => (width/2), :start_y => height/2, 
               :size => width/1.5, :color => [0.1, 0.1, 0.1]
end


