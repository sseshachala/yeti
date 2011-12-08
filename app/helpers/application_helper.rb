module ApplicationHelper
def show_path path,id
 "/" + path + "/" + id 
end

def edit_path path,id
 "/" + path + "/" + id +  "/" + "edit"
end

end
