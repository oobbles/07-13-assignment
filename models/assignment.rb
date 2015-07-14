require_relative "../database_class_methods.rb"

class Assignment
  extend DatabaseClassMethods
  attr_reader :id
  attr_accessor :description

  def to_hash
    {
      "description" => self.description
      #description: self.description
    }
  end
  # Initializes a new assignment object
  #
  # options{} - Hash of arguments
  #
  # id (optional) - Integer of the assignment in assignments table
  #
  # name (optional) - String of the name in the assignments table
  def initialize(options={})
    @id = options["id"]
    @description = options["description"]
  end

  # Check to see if name exisits
  #
  # name - String
  #
  # Returns Array with Assignment Object or if no such name exists, returns false
  def self.exist(description)
    get_descrip = CONNECTION.execute("SELECT id FROM assignments WHERE description = '#{description}';")
    if get_descrip.count != 0
      Assignment.find(get_descrip.first["id"])
    else
      false #run the self.add to add the name
    end
  end

  # CREATE Assignment record
  #
  # name - String
  #
  # Returns an Assignment Object
  def self.add(name)
    CONNECTION.execute("INSERT INTO assignments (description) VALUES ('#{description}');")
    id = CONNECTION.last_insert_row_id
    Assignment.find(id)
  end

  #Utility method to delete a current Assignment. Does not allow an Assignment to be
  #deleted if its ID is used in the albums_assignments table.

  #Returns Boolean.
  def delete
    assignments_in_table = CONNECTION.execute("SELECT COUNT(*) FROM albums_assignments WHERE assignment_id = #{@id};")
    if assignments_in_table.first[0] == 0
      CONNECTION.execute("DELETE FROM assignments WHERE id = #{@id};")
      true
    else
      false
    end
  end

  #Method goes to lookup table to get all links where there is a match with
  #the assignment id.

  #Returns an Array of Link Objects.
  def find_links
    link_ids =[]
    results = CONNECTION.execute("SELECT * FROM assignments_links WHERE assignment_id = #{@id};")
      results.each do |hash|
        link_ids << hash["link_id"]
      end
      Link.find_many(link_ids)
  end
  def find_collabs
    collab_ids =[]
    results = CONNECTION.execute("SELECT * FROM assignments_collabs WHERE assignment_id = #{@id};")
      results.each do |hash|
        collab_ids << hash["collab_id"]
      end
      Collab.find_many(collab_ids)
  end
end
