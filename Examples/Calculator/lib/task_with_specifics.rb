$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
require 'rubygems'
require 'bundler'
require 'ostruct'
Bundler.setup

class TaskWithSpecifics
  def initialize detail
    @info = with_specifics_from( detail )
  end
  
  def value_of(symbol)
    @info.send symbol
  end

  def with_specifics_from detail
    specifics_pattern = /('[^']+')/
    OpenStruct.new Hash[*detail.split(specifics_pattern).collect { |e| e.gsub('\'', '').strip.gsub(' ', '_') }]
  end

end
