require_relative "../database_class_methods.rb"

class Collab
  extend DatabaseClassMethods
  attr_reader :id
  attr_accessor :name

  # Initializes a new collab object
  #
  # options{} - Hash of arguments
  #
  # id (optional) - Integer of the collab in collabs table
  #
  # name (optional) - String of the name in the collabs table
  def initialize(options={})
    @id = options["id"]
    @name = options["name"]
  end

  # Check to see if name exisits
  #
  # name - String
  #
  # Returns Array with Collab Object or if no such name exists, returns false
  def self.exist(name)
    get_name = CONNECTION.execute("SELECT id FROM collabs WHERE name = '#{name}';")
    if get_name.count != 0
      Collab.find(get_name.first["id"])
    else
      false #run the self.add to add the name
    end
  end

  # CREATE Collab record
  #
  # name - String
  #
  # Returns an Collab Object
  def self.add(name)
    CONNECTION.execute("INSERT INTO collabs (name) VALUES ('#{name}');")
    id = CONNECTION.last_insert_row_id
    Collab.find(id)
  end

#  Utility method to delete a current Collab. Does not allow an Collab to be
#  deleted if its ID is used in the albums_collabs table.

#  Returns Boolean.
  def delete
    collabs_in_table = CONNECTION.execute("SELECT COUNT(*) FROM albums_collabs WHERE collab_id = #{@id};")
    if collabs_in_table.first[0] == 0
      CONNECTION.execute("DELETE FROM collabs WHERE id = #{@id};")
      true
    else
      false
    end
  end

  #Method goes to lookup table to get all assignments where there is a match with
  #the link id.

  #Returns an Array of Assignment Objects.
  def find_assignments
    assignment_ids =[]
    results = CONNECTION.execute("SELECT * FROM assignments_collabs WHERE collab_id = #{@id};")
      results.each do |hash|
        assignment_ids << hash["assignment_id"]
      end
      Assignment.find_many(assignment_ids)
  end
end
