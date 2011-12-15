module ApplicationHelper
def show_path path,id
 "/" + path + "/" + id 
end

def edit_path path,id
 "/" + path + "/" + id +  "/" + "edit"
end

def path_for path,id,action
  "/" + path + "/" + id +  "/" + action
end

end
