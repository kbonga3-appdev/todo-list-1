class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :created_at => :desc })

    # render({ :template => "users/index.html.erb" })

    render({ :template => "todos/todos_user_index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_users = User.where({ :id => the_id })

    @the_user = matching_users.at(0)

    render({ :template => "users/show.html.erb" })
  end

  def create
    the_user = User.new
    the_user.email = params.fetch("query_email")
    the_user.password = params.fetch("query_password")
    the_user.password_confirmation = params.fetch("query_password_confirmation")
    

    # if the_user.email != nil
    #   the_user.save
   save_status =  the_user.save

   if  save_status == true
    session.store(:user_id, the_user.id)

      redirect_to("/users", { :notice => "User created successfully." })
    else
      redirect_to("/user_sign_up", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.email = params.fetch("query_email")
    the_user.password_digest = params.fetch("query_password_digest")

    if the_user.valid?
      the_user.save
      redirect_to("/users/#{the_user.id}", { :notice => "User updated successfully."} )
    else
      redirect_to("/users/#{the_user.id}", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.destroy

    redirect_to("/users", { :notice => "User deleted successfully."} )
  end

  def sign_in
    render({ :template => "users/signin_form.html.erb" })
  end

  def sign_up
    render({ :template => "users/signup_form.html.erb" })
  end

  def sign_out
    reset_session
 
    redirect_to("/user_sign_in", { :notice => "You have successfully logged out"})
   end

   def authenticate
    un = params.fetch("query_email")
    pw = params.fetch("query_password")

    user = User.where({ :email => un }).at(0)

    if user == nil
      redirect_to("/user_sign_in", { :alert => "Username not found! "})
    else
     if user.authenticate(pw)
      session.store(:user_id, user.id)

      # redirect_to("/todos/#{user.id}", { :notice => "Welcome back " + user.email + "!"})
      redirect_to("/", { :notice => "Welcome back " + user.email + "!"})
     else
      redirect_to("/user_sign_in", { :alert => "Wrong Password!"})
     end
    end
  end
  

end
