class Todo::Cell < Cell::Concept
	property :title

	def show
		render
	end

	class Table < Cell::Concept
		def show
			todos = TodoList.find(params[:id]).todos.order("id ASC")
			concept("todo/cell", collection: todos)
		end
	end

private
	def edit_todo_link
		link_to "<span class='glyphicon glyphicon-pencil'></span>".html_safe, edit_todo_path(model), class: "btn btn-primary", remote: true
	end

	def delete_todo_link
		link_to "<span class='glyphicon glyphicon-trash'></span>".html_safe, todo_path(model), method: :delete, 
							"data-confirm": "Are you sure you want to delete this?", class: "btn btn-danger"
	end
end