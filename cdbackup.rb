#!/usr/bin/env ruby
require 'fileutils'
include FileUtils::Verbose
#include FileUtils::DryRun
 
$target = ARGV[0]
 
puts "backing up removable disks to #{$target}"
 
def backup(mount_point)
  puts "backing up from #{mount_point}"
  Thread.new{
    begin
      d = Dir.open(mount_point)
      d.each {|f|
        next if f=~/^\./
        puts "copying #{f}"
        cp_r mount_point+'/'+f, $target, :preserve=>true
      }
    rescue =>ex
      puts "exception while backing up from #{mount_point}"
      p ex
      puts ex.backtrace.join("\n")
    ensure
      d.close
      puts "ejecting #{mount_point}"
      system "eject #{mount_point}"
    end
  }
end
 
while s=STDIN.gets
  next unless s=~/member=MountAdded/
  8.times{ s=STDIN.gets }
  next unless s=~/file:\/\/(\/[^"]+)/
  mount_point = $1
  puts "#{mount_point} was mounted"
  backup mount_point
end