defmodule FinanceApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :age, :integer
    field :gender, :string
    field :address, :string
    field :date_of_birth, :date
    field :category, :string
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :age, :gender, :address, :date_of_birth, :category])
    |> validate_required([:name, :age])
    |> validate_inclusion(:gender, ["male", "female"])
    |> put_category()
  end

  defp put_category(changeset) do
    age = get_field(changeset, :age)
    category =
      cond do
        is_nil(age) -> nil
        age >= 1 and age <= 12 -> "Child"
        age >= 13 and age <= 19 -> "Teen"
        age >= 20 and age <= 64 -> "Adult"
        age >= 65 -> "Senior"
        true -> nil
      end
    put_change(changeset, :category, category)
  end
end
