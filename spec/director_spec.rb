$:.unshift(File.dirname(__FILE__), ".")
require 'spec_helper'

class SomeTaskOrRole
end

class SomeTaskThatNeedsInformation
  attr_reader :information
  def initialize information
    @information = information
  end
end

describe Director do
  
  it "tells you how to perform something like a task or a role" do
    researcher = double("researcher")
    something = "description of the task or role"
    directives = SomeTaskOrRole
    director = Director.new researcher
    researcher.should_receive( :get_directives_for ).with( something ).and_return( directives )

    director.how_do_i_perform( something ).should be_instance_of directives
  end

  it "tells you how to do something with additional information" do
    researcher = double("researcher")
    something = "description of the task or role"
    with_details = "detail1 'detail one' detail2 'detail 2'"
    directives = SomeTaskThatNeedsInformation
    director = Director.new researcher
    researcher.should_receive( :get_directives_for ).with( something ).and_return( directives )

    task = director.how_do_i_perform( something, with_details )
    task.should be_instance_of directives
  end
end