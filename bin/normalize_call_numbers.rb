#!/usr/bin/env ruby


def final_numeric s
  parts = s.strip.downcase.split

  # handle values like 'MS Or 379' and 'MS Or 4A'
  num = parts.pop
  num =~ /^(\d+)([[:alpha:]]*)$/
  parts << sprintf("%03d%s", $1, $2)
  parts.join '_'
end

def columbia_x s
  parts = s.strip.split
  parts[0] = parts.first.sub '.', '_'
  parts.join('_').sub /\._/, ''
end

def columbia_uts s
  parts = s.strip.downcase.split
  parts[2] = sprintf "%03d", parts[2]
  parts.join '_'
end

def process_line line
  # return final_numeric line if line =~ /^Lewis/
  return columbia_x line    if line =~ /^X8/
  return columbia_uts line  if line =~ /^\w+\s+\w+\s+\d+\s+\w+$/
  return final_numeric line if line =~ /\d+[[:alpha:]]?$/

  "NOPE: #{line.strip}"
end

ARGF.each { |line| puts "#{line.strip}\t#{process_line line}" }
