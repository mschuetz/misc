#!/usr/bin/env ruby

# creates audacity project from .au files such as the ones audacity writes to /tmp while recording 

class AU
  attr_reader :min, :max, :rms, :num_samples, :fn
  def initialize(fn)
    @fn = fn
    raw = IO.read(fn).force_encoding("ASCII-8BIT")
    header = raw.unpack("L"*10)
    raise ArgumentError.new("encoding must be 32bit ieee float") unless header[3]==6
    offset = header[1]
    data = raw[offset..-1].unpack("f"*((raw.size-offset) / 4))
    @min = data.min
    @max = data.max
    sum=0; data.each{|f| sum+=f**2}
    @rms = Math.sqrt(sum/data.size)
    @num_samples = data.size
  end
end

project_dir = ARGV[0].dup
project_dir.gsub!(/\/$/, '')
project_dir=~/(.+)_data/
proj_fn = $1

files = {}
Dir.glob(project_dir+"/*au").each{|fn|
  puts fn
  files[fn] = AU.new(fn)
}

num_samples=0; files.each_value{|au| num_samples += au.num_samples}
proj = open(proj_fn, "w")
begin
  proj.puts "<?xml version=\"1.0\"?>  <audacityproject projname=\"#{project_dir}\" version=\"1.1.0\" audacityversion=\"1.2.5\" sel0=\"0.0000000000\" sel1=\"0.0000
  000000\" vpos=\"0\" h=\"5495.3041269841\" zoom=\"86.1328125000\" rate=\"44100.000000\" >
       <tags title=\"\" artist=\"\" album=\"\" track=\"-1\" year=\"\" genre=\"-1\" comments=\"\" id3v2=\"1\" /> <wavetrack name=\"Audio Track\" channel=\"2\" linked=\"0\" offset=\"0.00000000\" rate=\"44100.000000\" gain=\"1.000000\" pan=\"0.000000\" >
  <sequence maxsamples=\"262144\" sampleformat=\"262159\" numsamples=\"#{num_samples}\" >"
  
  offset = 0
  files.keys.sort.each{|fn|
    au = files[fn]
    proj.puts "<waveblock start=\"#{offset}\" >
                   <simpleblockfile filename='#{au.fn}' len='#{au.num_samples}' min='#{au.min}' max='#{au.max}' rms='#{au.rms}'/>
               </waveblock>"
    offset += au.num_samples
  }
  
  proj.puts "</sequence><envelope numpoints='0'></envelope></wavetrack></audacityproject>"
ensure
  proj.close
end
