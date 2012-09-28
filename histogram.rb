#!/usr/bin/env ruby

if ARGV[0]=='--print-infty'
  $print_infty = true
  ARGV.shift
else
  $print_infty = false
end

re = Regexp.new(ARGV[0])
thresholds = ARGV[1].split(/\s/).map{|t| t.to_i}.sort
thresholds << 1.0/0.0 # infinity
histogram = {}
thresholds.each{|t| histogram[t] = 0}

STDIN.each_line{|line|
    if line=~re
      measurement = $1.to_i
      thresholds.each{|t|
        if measurement < t
          histogram[t]+=1
          if $print_infty && t==thresholds.last
            print line
          end
          break
        end
      }
    end
}

thresholds.each{|t|
  puts "#{t}: #{histogram[t]}"  
}
