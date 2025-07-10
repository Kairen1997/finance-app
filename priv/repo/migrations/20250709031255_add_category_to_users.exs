defmodule FinanceApp.Repo.Migrations.AddCategoryToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :category, :string
    end
  end
end
