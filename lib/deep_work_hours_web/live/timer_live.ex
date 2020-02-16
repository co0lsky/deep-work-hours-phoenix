defmodule DeepWorkHoursWeb.TimerLive do
  @moduledoc false

  use Phoenix.LiveView
  use Phoenix.HTML

  def render(assigns) do
    Phoenix.View.render(DeepWorkHoursWeb.PageView, "timer.html", assigns)
  end

  def mount(_params, %{}, socket) do
    current_time = ~T[00:00:00]

    {:ok, socket
               |> assign(:current_time, current_time)
               |> assign(:playing, false)
    }
  end

  def handle_info(:update, socket) do
    current_time = socket.assigns.current_time
                   |> Time.add(1)
                   |> Time.truncate(:second)

    {:noreply, assign(socket, :current_time, current_time)}
  end

  def handle_event("start", _params, socket) do
    {:ok, time_ref} = :timer.send_interval(1000, self(), :update)

    {:noreply, socket
               |> assign(:time_ref, time_ref)
               |> assign(:playing, true)
    }
  end

  def handle_event("stop", _params, socket) do
    :timer.cancel(socket.assigns.time_ref)

    {:noreply, socket
               |> assign(:playing, false)
    }
  end
end
