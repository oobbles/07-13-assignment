require_relative "../database_class_methods.rb"

class Link
  extend DatabaseClassMethods
  attr_reader :id
  attr_accessor :link

  # Initializes a new link object
  #
  # options{} - Hash of arguments
  #
  # id (optional) - Integer of the link in links table
  #
  # name (optional) - String of the name in the links table
  def initialize(options={})
    @id = options["id"]
    @link = options["link"]
  end

  # Check to see if name exisits
  #
  # name - String
  #
  # Returns Array with Link Object or if no such name exists, returns false
  def self.exist(link)
    get_link = CONNECTION.execute("SELECT id FROM links WHERE link = '#{link}';")
    if get_link.count != 0
      Link.find(get_link.first["id"])
    else
      false #run the self.add to add the name
    end
  end

  # CREATE Link record
  #
  # name - String
  #
  # Returns an Link Object
  def self.add(name)
    CONNECTION.execute("INSERT INTO links (link) VALUES ('#{link}');")
    id = CONNECTION.last_insert_row_id
    Link.find(id)
  end

  #Utility method to delete a current Link. Does not allow an Link to be
#  deleted if its ID is used in the albums_links table.

#  Returns Boolean.
  def delete
    links_in_table = CONNECTION.execute("SELECT COUNT(*) FROM assignments_links WHERE link_id = #{@id};")
    if links_in_table.first[0] == 0
      CONNECTION.execute("DELETE FROM links WHERE id = #{@id};")
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
    results = CONNECTION.execute("SELECT * FROM assignments_links WHERE link_id = #{@id};")
      results.each do |hash|
        assignment_ids << hash["assignment_id"]
      end
      Assignment.find_many(assignment_ids)
  end
end
