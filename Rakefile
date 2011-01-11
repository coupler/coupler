if RUBY_PLATFORM != 'java'
  puts "ERROR: JRuby is required to run Coupler."
  exit
end

require 'rake'
require 'rubygems'
require 'bundler'
Bundler.setup(:default, :development)

def confirm(prompt)
  answer = nil
  while answer != "y" && answer != "n"
    print "#{prompt} Are you sure? [yn] "
    $stdout.flush
    answer = $stdin.gets.chomp.downcase
  end
  exit if answer == "n"
end

alias :original_ruby :ruby
def ruby(*args, &block)
  # turn on objectspace (for nokogiri)
  unless String === args[0]
    args = [""] + args
  end
  args[0] = "-X+O #{args[0]}"
  original_ruby(args, &block)
end

Dir['tasks/*.rake'].sort.each { |f| import f }

task :default => :test
