defmodule FinanceApp.Credentials.CredentialProfile do
  use Ecto.Schema
  import Ecto.Changeset

  schema "credential_profiles" do
    field :status, :string
    field :address, :string
    field :full_name, :string
    field :ic, :string
    field :phone, :string
    field :date_of_birth, :date

    belongs_to :credential, FinanceApp.Credentials.Credential

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(credential_profile, attrs) do
    credential_profile
    |> cast(attrs, [:full_name, :ic, :status, :phone, :address, :date_of_birth])
    |> validate_required([:full_name, :ic, :status])
    |> validate_length(:full_name, min: 2, max: 100)
    |> validate_length(:ic, min: 12, max: 12)  # Assuming Malaysian IC format
    |> validate_format(:ic, ~r/^\d{12}$/, message: "must be 12 digits")
    |> unique_constraint(:ic, message: "IC number already exists")
    |> validate_inclusion(:status, ["active", "inactive", "pending"])
  end
end
