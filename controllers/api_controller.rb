
get "/api/assignments" do
  @everything = Assignment.all
  json(@everything)

# @everything=[]
#   Assignment.all.each do |object|
#     @everything<<object.to_hash
 end
 get "/api/assignments/:id" do
   id = params["id"].to_i
   @assignment=Assignment.find(id).to_hash
   json(@assignment)
 end
#NONE OF THIS WORKS
# get "/api/assignments/:id" do
#   id = params["id"].to_i
#   assignment=Assignment.find(id)
#   link_array=assignment.find_links
#   json_array=assignment.to_hash
#   link_names=[]
#   link_array.each do |link_id|
#     link_names<<fin
#   links=Assignment.find(id).find_links
#   @links=[]
#   Assignment
#   # collabs=Assignment.find(id).find_collabs.to_hash
#   json(@one_assignment)
# return links.to_hash
#  end
#  get "/api/assignments/:id" do
#    assignment = Assignment.find(params["id"])
#    collaborator_array = assignment.find_collaborators
#    json_array = assignment.json_format
#    collaborator_names = []
#    collaborator_array.each do |collaborator_id|
#      collaborator_names << Collaborator.find(collaborator_id).collaborator_name
#    end
#    json_array["collaborators"] = collaborator_names
#    json json_array
#  end
