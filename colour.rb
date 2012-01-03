#!/usr/bin/env ruby

if ARGV.size<2
	STDERR.puts "Usage: #{$0} colour_spec regexp"
	exit 1
end

$colours = {
	:black =>  [0, 30],
	:dark_gray =>  [1, 30],
	:blue =>  [0,34],
	:light_blue =>  [1,34],
	:green =>  [0,32],
	:light_green =>  [1,32],
	:cyan =>  [0,36],
	:light_cyan =>  [1,36],
	:red =>  [0,31],
	:light_red =>  [1,31],
	:purple =>  [0,35],
	:light_purple =>  [1,35],
	:brown =>  [0,33],
	:yellow =>  [1,33],
	:light_gray =>  [0,37],
	:white =>  [1,37]
}

def reset_colours
	"\e(B\e[m" # from tput sgr0
end

def get_colour(str)
	c1, c2 = if str=~/bg_(.+)/
		c1, c2 = $colours[$1.to_sym]
		[c1, c2 + 10]
	else
		$colours[str.to_sym]
	end
	"\e[#{c1};#{c2}m"
end

def get_colours(str)
	str.split(/,/).map{|s| get_colour(s)}.join('')
end

colour = get_colours(ARGV[0])
regex = Regexp.new("(#{ARGV[1]})")

STDIN.each_line do  |line|
  print line.gsub(regex, "#{colour}\\1#{reset_colours}")
end
