defmodule FinanceApp.Credentials.CredentialProfileTest do
  use FinaanceApp.DataCase

  alias FinanceApp.Credentials.CredentialProfile

  describe "changeset/2" do
    test "validates required fields" do
      changeset = CredentialProfile.changeset(%CredentialProfile{}, %{})

      assert %{
        full_name: ["can't be blank"],
        ic: ["can't be blank"],
        status: ["can't be blank"]
      } = errors_on(changeset)
    end

    test "validates IC format" do
      attrs = %{full_name: "John Doe", ic: "invalid", status: "active"}
      changeset = CredentialProfile.changeset(%CredentialProfile{}, attrs)

      assert %{ic: ["must be 12 digits"]} = errors_on(changeset)
    end

    test "validates status inclusion" do
      attrs = %{full_name: "John Doe", ic: "123456789012", status: "invalid"}
      changeset = CredentialProfile.changeset(%CredentialProfile{}, attrs)

      assert %{status: ["is invalid"]} = errors_on(changeset)
    end
  end
end
