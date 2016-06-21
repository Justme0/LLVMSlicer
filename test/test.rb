#!/usr/bin/env ruby

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: test.rb [options]"

  opts.on("-d", "--diff", "Show diff between original and sliced IR") do
    options[:diff] = true
  end

  # OPTIMIZE: remove option prefix
  opts.on("-f", "--file FILENAME", "Specify a file") do |src|
    options[:src] = src
  end

  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end
end.parse!

class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[21m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end

src = options[:src]			# e.g. main.c
base = File.basename("#{src}", ".*")	# main
ir = base + ".ll"			# main.ll

puts "compiling #{src} to #{ir}...".brown
`clang -S -emit-llvm #{src} -o #{ir}`	# OPTIMIZE: maybe unsafe
abort unless $?.success?

ir_sliced = base + "_sliced.ll"		# main_sliced.ll
puts "slicing #{ir} to #{ir_sliced}...".brown
# `opt -S -load=../llvm-slicer.so -create-hammock-cfg -slice-inter #{ir} -o #{ir_sliced}`
`opt -S -load=../llvm-slicer.so -slice-inter #{ir} -o #{ir_sliced}`
abort unless $?.success?

puts "\nfinished".green
puts "source file       : #{src}"
puts "IR before slicing : #{ir}"
puts "IR after slicing  : #{ir_sliced}"

if options[:diff]
  `which gvimdiff`
  if $?.success?
    system("gvimdiff #{ir} #{ir_sliced} &")
  else
    system("diff #{ir} #{ir_sliced} &")
  end
end
