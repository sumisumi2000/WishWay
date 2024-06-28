module ApplicationHelper
  def turbo_stream_flash
    turbo_stream.update "flash", partial: "shared/flash"
  end

  def turbo_stream_graph
    turbo_stream.update "graph", partial: "wish_lists/graph", locals: { wish_list: current_user.wish_list }
  end
end
