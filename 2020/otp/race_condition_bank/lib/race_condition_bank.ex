defmodule RaceConditionBank do
  @doc """

    ## Example 1 Manual Way:
    iex[1]> alias RaceConditionBank, as: RCB
    RaceConditionBank
    iex[2]> RCB.new_account(1, 100)
    {:ok, #PID<0.157.0>}
    iex[3]> RCB.credit(1, 50)
    :ok
    iex[4]> :sys.get_state(1 |> Integer.to_string |> String.to_atom)
    150
    iex[5]> RCB.debit(1, 50)
    :ok
    iex[6]> :sys.get_state(1 |> Integer.to_string |> String.to_atom)
    100

    ## Example 2 Async Way:
    iex[1]> alias RaceConditionBank, as: RCB
    RaceConditionBank
    iex[2]> RCB.async_mischief()
    299
    iex[3]> RCB.async_mischief()
    301
    iex[4]> RCB.async_mischief()
    306
    iex[5]> RCB.async_mischief()
    302
    iex[6]> RCB.async_mischief()
    316

    ## Example 3 Sync Way:
    iex[1]> alias RaceConditionBank, as: RCB
    RaceConditionBank
    iex[2]> RCB.sync_mischief()
    300
    iex[3]> RCB.sync_mischief()
    300
    iex[4]> RCB.sync_mischief()
    300
    iex[5]> RCB.sync_mischief()
    300
    iex[6]> RCB.sync_mischief()
    300
  """

  alias RaceConditionBank.Bank

  def new_account(account_number, balance) do
    Bank.start_link(account_number, balance)
  end

  def credit(account_number, amount) do
    Bank.credit(account_number, amount)
  end

  def debit(account_number, amount) do
    Bank.debit(account_number, amount)
  end

  def transfer(from_account_number, to_account_number, amount) do
    debit(from_account_number, amount)
    credit(to_account_number, amount)
  end

  def async_mischief() do
    Enum.each((1..3), & new_account(&1, 100))

    1..100
    |> Enum.map(fn _ ->
      (1..3)
      |> Enum.shuffle
      |> Enum.take(2)
      |> async_transfer(:random.uniform(3))
    end)
    |> Enum.map(&Task.await/1)

    # now get the total
    ~w[1 2 3]a
    |> Enum.map(fn n -> :sys.get_state(n) end)
    |> Enum.sum
  end

  def async_transfer([from_account_number, to_account_number], amount) do
    Task.async(fn ->
      transfer(from_account_number, to_account_number, amount)
    end)
  end

  def sync_mischief() do
    Enum.each((1..3), & new_account(&1, 100))

    1..100
    |> Enum.map(fn _ ->
      (1..3)
      |> Enum.shuffle
      |> Enum.take(2)
      |> sync_transfer(:random.uniform(3))
    end)

    # now get the total
    ~w[1 2 3]a
    |> Enum.map(fn n -> :sys.get_state(n) end)
    |> Enum.sum
  end

  def sync_transfer([from_account_number, to_account_number], amount) do
    transfer(from_account_number, to_account_number, amount)
  end
end
