defmodule FinanceApp.Repo.Migrations.AddNewUserDetails do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :address, :string
      add :gender, :string
      add :date_of_birth, :date
    end
  end
end
