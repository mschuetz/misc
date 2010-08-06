#!/usr/bin/env ruby
require 'open-uri'
require 'rexml/document'

module Podcast2M3U
	def self.enclosures(url, restrict=[:http])
		url = URI.parse(url) if url.is_a? String
		raise ArgumentError, "needs a String or a URI" unless url.is_a? URI
		if !restrict.respond_to?(:include?) && !restrict.is_a?(FalseClass)
			raise ArgumentError, "restrict must be an Array or FalseClass"
		end
		if restrict && !restrict.include?(url.scheme)
			raise ArgumentError, "URL scheme must be one of #{restrict}" 
		end

		out = []
		open(url.to_s){ |url_f|
			doc = REXML::Document.new(url_f.read)
			doc.each_element("//enclosure"){ |el|
				out << el.attributes["url"]
			}
		}
		out
	end
end

if $0==__FILE__
	open(ARGV[1], "w"){ |out|
		Podcast2M3U::enclosures(ARGV[0], false).each{|url|
			out.puts url
		}
	}
end
