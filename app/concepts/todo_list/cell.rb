class TodoList::Cell < Cell::Concept
	property :name

	def show
		render
	end

	class Table < Cell::Concept
		def show
			todo_lists = TodoList.all.order("id ASC")
			concept("todo_list/cell", collection: todo_lists)
		end
	end

private
	def edit_todo_list_link
		link_to "<span class='glyphicon glyphicon-pencil'></span>".html_safe, edit_todo_list_path(model), class: "btn btn-primary btn-sm", remote: true
	end

	def show_todo_list_link
		link_to name, todo_list_path(model)
	end

	def delete_todo_list_link
		link_to "<span class='glyphicon glyphicon-trash'></span>".html_safe, todo_list_path(model), method: :delete, 
							"data-confirm": "Are you sure you want to delete this?", class: "btn btn-danger btn-sm"
	end
end