defmodule EggTimer.Alarm do
  defstruct ~w[duration name time fun]a

  def new(name, duration, fun \\ &default_fun/0)
      when is_atom(name) and is_integer(duration) and is_function(fun) do
    __struct__(
      time: DateTime.utc_now(),
      name: name,
      duration: duration,
      fun: fun,
    )
  end

  def trigger(alarm) do
    alarm.fun.()
    alarm
  end

  def status(alarm) do
    {alarm.name, alarm.duration, remaining(alarm)}
  end

  def remaining(alarm) do
    alarm.time
    |> DateTime.add(alarm.duration, :millisecond)
    |> DateTime.diff(DateTime.utc_now)
  end

  def default_fun do
    IO.puts("Alarm triggered!")
  end
end
