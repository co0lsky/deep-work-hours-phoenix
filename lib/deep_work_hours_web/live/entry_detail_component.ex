defmodule DeepWorkHoursWeb.Components.EntryDetailComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    Phoenix.View.render(DeepWorkHoursWeb.PageView, "entry_detail_component.html", assigns)
  end

  def preload(list_of_assigns) do
    Enum.map(list_of_assigns, fn assigns ->
      Map.put(assigns, :hidden, true)
    end)
  end

  def handle_event("toggle", _params, socket) do
    {:noreply, socket
               |> assign(:hidden, !socket.assigns.hidden)
    }
  end
end
