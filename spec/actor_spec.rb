$:.unshift(File.dirname(__FILE__), ".")
require 'spec_helper'

module SetThePlaceAtTheTable

  def follow_instructions
    place = []
    place_the_fork_on_the_left_of place
    place_the_knife_on_the_right_of place
    place
  end
end

module Butler

  def place_the_fork_on_the_left_of place
    place.unshift "fork"
  end

  def place_the_knife_on_the_right_of place
    place.push "knife"
  end

end

describe Actor do

  #TODO: We'd like to refactor this some more. It's not as clear as we'd like it. Needs simplification.

  it "gets into character" do
    director = double("director")
    role_description = "Butler"
    director.should_receive( :how_do_i_perform ).with( role_description ).and_return( Butler )
    
    actor = Actor.new role_description, director
  end  

  it "performs a simple task as that character" do
    role_description = "Butler"
   
    task_description = "set the place at the table"
    
    director = double("director")
    director.should_receive( :how_do_i_perform ).with( role_description ).and_return( Butler )
    director.should_receive( :how_do_i_perform ).with( task_description ).and_return( SetThePlaceAtTheTable )
   
    actor = Actor.new role_description, director
    
    actor.perform(task_description).should == ["fork","knife"]
  end

  it "can perform a task that answers a question" do
    role_description = "description of the role"
    role = double( role_description )

    some_question = "some question to ask"
    the_answer = "the answer to the question"
    question = double( some_question )
    question.should_receive( :perform_as ).with( role ).and_return( the_answer )
    
    director = double("director")
    director.should_receive( :how_do_i_perform ).with( role_description ).and_return( role )
    director.should_receive( :how_do_i_perform ).with( some_question ).and_return( question )

    actor = Actor.new role_description, director

    actor.answer( some_question ).should == the_answer
  end

  it "can perform a task that requires certain details" do
    role_description = "description of the role"
    role = double( role_description )
    
    task_description = "some description of a task"
    details = "info it needs \"the info\"" 
    task = double( task_description )
    task.should_receive( :perform_as ).with( role )

    director = double("director")
    director.should_receive( :how_do_i_perform ).with( role_description ).and_return( role )
    director.should_receive( :how_do_i_perform ).with( task_description ).and_return( task )

    actor = Actor.new role_description, director

    actor.perform task_description, details
  end
end

