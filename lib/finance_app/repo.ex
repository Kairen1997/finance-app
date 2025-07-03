defmodule FinanceApp.Repo do
  use Ecto.Repo,
    otp_app: :finance_app,
    adapter: Ecto.Adapters.Postgres
end
