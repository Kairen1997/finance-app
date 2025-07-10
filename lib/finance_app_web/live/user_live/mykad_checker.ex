defmodule YourAppWeb.MykadFormComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div>
      <form phx-change="validate" phx-target={@myself}>
        <label>MyKad Number:</label>
        <input type="text" name="mykad" value={@mykad} placeholder="e.g., 900101-14-1234" />
      </form>

      <%= if @result do %>
        <div class="mt-4 p-2 bg-gray-100 rounded">
          <p><strong>Date of Birth:</strong> <%= @result.dob %></p>
          <p><strong>Gender:</strong> <%= @result.gender %></p>
          <p><strong>State:</strong> <%= @result.state %></p>
        </div>
      <% end %>

      <%= if @error do %>
        <p class="text-red-600 mt-2"><%= @error %></p>
      <% end %>
    </div>
    """
  end

  def update(assigns, socket) do
    {:ok, assign(socket, assigns) |> assign(:result, nil) |> assign(:error, nil) |> assign_new(:mykad, fn -> "" end)}
  end

  def handle_event("validate", %{"mykad" => mykad}, socket) do
    case check_mykad(mykad) do
      {:ok, result} -> {:noreply, assign(socket, mykad: mykad, result: result, error: nil)}
      {:error, msg} -> {:noreply, assign(socket, mykad: mykad, result: nil, error: msg)}
    end
  end

  defp check_mykad(mykad) do
    state_codes = %{
      "01" => "Johor", "02" => "Kedah", "03" => "Kelantan", "04" => "Melaka",
      "05" => "Negeri Sembilan", "06" => "Pahang", "07" => "Penang", "08" => "Perak",
      "09" => "Perlis", "10" => "Selangor", "11" => "Terengganu", "12" => "Sabah",
      "13" => "Sarawak", "14" => "Kuala Lumpur", "15" => "Labuan", "16" => "Putrajaya"
    }

    case Regex.run(~r/^(\d{2})(\d{2})(\d{2})-(\d{2})-(\d{4})$/, mykad) do
      [_, yy, mm, dd, state_code, seq] ->
        gender = if String.last(seq) |> String.to_integer() |> rem(2) == 0, do: "Female", else: "Male"
        state = Map.get(state_codes, state_code, "Unknown")
        dob = "19#{yy}-#{mm}-#{dd}"
        {:ok, %{dob: dob, gender: gender, state: state}}

      _ ->
        {:error, "Invalid MyKad format (use YYMMDD-SS-####)"}
    end
  end
end
