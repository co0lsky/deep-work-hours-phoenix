defmodule DeepWorkHoursWeb.TimerLive do
  @moduledoc false

  use Phoenix.LiveView
  use Phoenix.HTML

  def render(assigns) do
    Phoenix.View.render(DeepWorkHoursWeb.PageView, "timer.html", assigns)
  end

  def mount(_params, %{}, socket) do
    {:ok, reset_timer socket}
  end

  def handle_info(:update, socket) do
    current_time = socket.assigns.current_time
                   |> Time.add(1)
                   |> Time.truncate(:second)

    {:noreply, assign(socket, :current_time, current_time)}
  end

  def handle_event("start", _params, socket) do
    {:ok, time_ref} = :timer.send_interval(1000, self(), :update)
    {:ok, start_time} = DateTime.now("Etc/UTC")

    {:noreply, socket
               |> assign(:start_time, start_time)
               |> assign(:time_ref, time_ref)
               |> assign(:playing, true)
    }
  end

  def handle_event("stop", _params, socket) do
    :timer.cancel(socket.assigns.time_ref)

    save_timer_entry socket

    {:noreply, reset_timer socket}
  end

  def terminate(reason, socket) do

  end

  defp reset_timer(socket) do
    current_time = ~T[00:00:00]

    socket
    |> assign(:current_time, current_time)
    |> assign(:playing, false)
  end

  defp save_timer_entry(socket) do
    {:ok, end_time} = DateTime.now("Etc/UTC")

    time_entry = %DeepWorkHours.TimeEntry{
      date: Date.utc_today(),
      start_date_time: DateTime.truncate(socket.assigns.start_time, :second),
      end_date_time: DateTime.truncate(end_time, :second),
      total_time: socket.assigns.current_time
    }

    DeepWorkHours.Repo.insert time_entry
  end
end
