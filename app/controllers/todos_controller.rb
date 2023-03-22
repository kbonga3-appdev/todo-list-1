class TodosController < ApplicationController
  def index
    # matching_todos = Todo.all

    user_ids = session.fetch(:user_id)
    
    matching_todos = Todo.where({ :user_id => user_ids })

    @list_of_todos = matching_todos.order({ :created_at => :asc })


    render({ :template => "todos/todos_user_index.html.erb" })
  end

  def show
    # the_id = params.fetch("path_id")

    # matching_todos = Todo.where({ :id => the_id })

    # @the_todo = matching_todos.at(0)

    # render({ :template => "todos/show.html.erb" })

    render({ :template => "todos/todos_user_index.html.erb" })
  end

  def create
    the_todo = Todo.new
    the_todo.content = params.fetch("query_content")
     the_todo.status = params.fetch("query_status")
    # the_todo.status = $query_status
    # the_todo.user_id = params.fetch("query_user_id")
    the_todo.user_id = session.fetch(:user_id)

    if the_todo.valid?
      the_todo.save
      redirect_to("/", { :notice => "Todo created successfully." })
    else
      redirect_to("/", { :alert => the_todo.errors.full_messages.to_sentence })
    end
  end


  def update
    the_id = params.fetch("path_id")
    matching_todos = Todo.where({ :id => the_id }).at(0)
    matching_todos.status = params.fetch("query_status")

    if matching_todos.valid?
      matching_todos.save
      redirect_to("/", { :notice => "Todo updated successfully."} )
      
    else
      redirect_to("/todos/#{matching_todos.id}", { :alert => matching_todos.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_todo = Todo.where({ :id => the_id }).at(0)

    the_todo.destroy

    redirect_to("/todos", { :notice => "Todo deleted successfully."} )
  end
end
