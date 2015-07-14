
get "/api/assignments" do
  @everything = Assignment.all
  json(@everything)

# @everything=[]
#   Assignment.all.each do |object|
#     @everything<<object.to_hash
 end

 #this gives you one assignment based on id
 get "/api/assignments/:id" do
   id = params["id"].to_i
   @assignment=Assignment.find(id).to_hash
   json(@assignment)
 end

#This gives you the links associated with a specific assignment
get "/api/assignment_links/:id" do
  id = params["id"].to_i
  assignment=Assignment.find(id) #an assignment object?
  link_array=assignment.find_links
  link_names=[]
  link_array.each do |link_object|
    link_names<<link_object.link
end
json link_names
end
