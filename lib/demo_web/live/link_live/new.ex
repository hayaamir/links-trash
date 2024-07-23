defmodule DemoWeb.LinkLive.New do
  use DemoWeb, :live_view

  alias Demo.Links
  alias Demo.Links.Link

  def mount(_params, _session, socket) do
    changeset = Link.changeset(%Link{})

    socket = socket
      |> assign(
        :form,
        to_form(changeset)
      )

    {:ok, socket}
  end

  def handle_event("submit", %{"link" => link_params}, socket) do
    params =
      link_params
        |> Map.put("user_id", socket.assigns.current_user.id)

    case Links.create_link(params) do
      {:ok, _link} ->
        socket =
          socket
          |> put_flash(:info, "Link created successfully.")
          |> push_navigate(to: ~p"/links")

          {:noreply, socket}

      {:error, chanset} ->
        socket =
          socket
            assign(
              :form,
              to_form(chanset)
              )

        {:noreply, socket}
    end
  end
end
