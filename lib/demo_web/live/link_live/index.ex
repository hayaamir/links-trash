defmodule DemoWeb.LinkLive.Index do
  use DemoWeb, :live_view

  alias Demo.Links

  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_user.id
    changeset = Links.Link.changeset(%Links.Link{})

    socket =
      socket
      |> assign(:links, Links.list_links(user_id))
      |> assign(:form, to_form(changeset))

    {:ok, socket}
  end

  def handle_event("submit", %{"link" => link_params}, socket) do
    params = Map.put(link_params, "user_id", socket.assigns.current_user.id)

    case Links.create_link(params) do
      {:ok, link} ->
        socket = assign(socket, :links, [link | socket.assigns.links])
        {:noreply, socket}

      {:error, changeset} ->
        socket = assign(socket, :form, to_form(changeset))
        {:noreply, socket}
    end
  end

  def handle_event("delete", %{"link" => link}, socket) do
    IO.inspect(link, label: "Delete ID")

    case Links.delete_link(link) do
      {:ok, _link} ->
        updated_links = Enum.reject(socket.assigns.links, fn link -> link.id == link.id end)
        socket = assign(socket, :links, updated_links)
        {:noreply, socket}

      {:error, _reason} ->
        # Optionally handle the error case
        {:noreply, socket}
    end
  end
end
