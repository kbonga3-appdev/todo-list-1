Rails.application.routes.draw do



  # Routes for the User resource:
        
  get("/user_sign_in", { :controller => "users", :action => "sign_in" })
  get("/user_sign_up", { :controller => "users", :action => "sign_up" })
  post("/user_verify_credentials", { :controller => "users", :action => "authenticate" })

  get("/user_sign_out", { :controller => "users", :action => "sign_out" })

  

  # CREATE
  post("/insert_user", { :controller => "users", :action => "create" })
          
  # READ
  get("/users", { :controller => "users", :action => "index" })
  
  get("/users/:path_id", { :controller => "users", :action => "show" })
  
  # UPDATE
  
  post("/modify_user/:path_id", { :controller => "users", :action => "update" })
  
  # DELETE
  get("/delete_user/:path_id", { :controller => "users", :action => "destroy" })

  #------------------------------

  # Routes for the Todo resource:

  # CREATE
  post("/insert_todo", { :controller => "todos", :action => "create" })
          
  # --> READ
  get("/todos", { :controller => "users", :action => "create" })

  get("/", { :controller => "todos", :action => "index" })

  post("/", { :controller => "todos", :action => "update" })
  
  get("/todos/:path_id", { :controller => "todos", :action => "show" })
  
  # UPDATE
  
  post("/modify_todo/:path_id", { :controller => "todos", :action => "update" })
  
  # DELETE
  get("/delete_todo/:path_id", { :controller => "todos", :action => "destroy" })

  #------------------------------

end
