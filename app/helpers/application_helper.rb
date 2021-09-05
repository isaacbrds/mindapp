module ApplicationHelper
  def flash_class(level)
       
    if level == "alert"
         "alert alert-warning alert-dismissible fade show"
    elsif level == "notice"     
         "alert alert-success alert-dismissible fade show"
    elsif level == "error" 
         "alert alert-danger alert-dismissible fade show"
    else
         "alert alert-primary alert-dismissible fade show"
    end
  end
end
