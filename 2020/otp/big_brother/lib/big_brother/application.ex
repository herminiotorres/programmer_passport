defmodule BigBrother.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @doc """

    #####
    ## Check if the supervisor its running and whats your PID:
    #####
    iex> GenServer.whereis(BigBrother.Supervisor)
    #PID<0.154.0>
    iex> Process.alive?(GenServer.whereis(BigBrother.Supervisor))
    true

    #####
    ## Start a GenServer in IEX session without put this child in the supervisor hands to watch:
    #####
    iex> alias BigBrother.Actor
    BigBrother.Actor
    iex> {:ok, julia} = Actor.start_link(:julia)
    {:ok, #PID<0.189.0>}
    iex> Actor.say(julia)
    :ok
    Julia, says: Let's play
    iex> Actor.crash(julia)
    :ok
    {"Julia", "Let's play"}
    iex>
    09:26:08.260 [error] GenServer :julia terminating
    ** (Protocol.UndefinedError) protocol String.Chars not implemented for {"Julia", "Let's play"} of type Tuple. This protocol is implemented for the following type(s): NaiveDateTime, Float, Date, BitString, Time, DateTime, List, Version.Requirement, URI, Atom, Integer, Version

    Last message: {:"$gen_cast", :crash}
    State: {"Julia", "Let's play"}
    ** (EXIT from #PID<0.156.0>) shell process exited with reason: an exception was raised:
        ** (Protocol.UndefinedError) protocol String.Chars not implemented for {"Julia", "Let's play"} of type Tuple. This protocol is implemented for the following type(s): NaiveDateTime, Float, Date, BitString, Time, DateTime, List, Version.Requirement, URI, Atom, Integer, Version

    #####
    ## Start a IEX session after define declare some children for supervisor watch with :one_for_one strategy:
    #####

    Big Brother is Watching!
    Starting the character julia
    Starting the character winston
    Starting the character syme

    iex> pid = GenServer.whereis(:julia)
    #PID<0.155.0>
    iex> alias BigBrother.Actor
    BigBrother.Actor
    iex> Actor.say(:julia)
    :ok
    Julia, says: Let's play
    iex> Actor.say(pid)
    :ok
    Julia, says: Let's play

    iex> alias BigBrother.Actor
    iex> Actor.say(:winston)
    Winston, says: Welcome to the revolution
    :ok
    iex> GenServer.cast(:winston, :say)
    :ok
    Winston, says: Welcome to the revolution
    iex> Actor.crash(:winston)
    :ok
    iex> {"Winston", "Welcome to the revolution"}
    Winston shut down!

    10:22:19.670 [error] GenServer :winston terminating
    ** (Protocol.UndefinedError) protocol String.Chars not implemented for {"Winston", "Welcome to the revolution"} of type Tuple. This protocol is implemented for the following type(s): NaiveDateTime, Float, Date, BitString, Time, DateTime, List, Version.Requirement, URI, Atom, Integer, Version

    Last message: {:"$gen_cast", :crash}
    State: {"Winston", "Welcome to the revolution"}
    Starting the character winston

    #####
    ## Start a IEX session after define declare some children for supervisor watch with :one_for_all strategy:
    #####

    iex> alias BigBrother.Actor
    BigBrother.Actor
    iex> Actor.crash(:winston)
    :ok
    iex> {"Winston", "Welcome to the revolution"}
    Winston shut down!

    10:30:19.199 [error] GenServer :winston terminating
    ** (Protocol.UndefinedError) protocol String.Chars not implemented for {"Winston", "Welcome to the revolution"} of type Tuple. This protocol is implemented for the following type(s): NaiveDateTime, Float, Date, BitString, Time, DateTime, List, Version.Requirement, URI, Atom, Integer, Version

    Last message: {:"$gen_cast", :crash}
    State: {"Winston", "Welcome to the revolution"}
    Starting the character julia
    Starting the character winston
    Starting the character syme

    #####
    ## Start a IEX session after define declare some children for supervisor watch with :rest_for_one strategy:
    #####

    iex> alias BigBrother.Actor
    BigBrother.Actor
    iex> Actor.crash(:syme)
    :ok
    iex> {"Syme", "I'd say something witty but you'd likely miss the point"}
    Syme shut down!

    10:32:30.148 [error] GenServer :syme terminating
    ** (Protocol.UndefinedError) protocol String.Chars not implemented for {"Syme", "I'd say something witty but you'd likely miss the point"} of type Tuple. This protocol is implemented for the following type(s): NaiveDateTime, Float, Date, BitString, Time, DateTime, List, Version.Requirement, URI, Atom, Integer, Version

    Last message: {:"$gen_cast", :crash}
    State: {"Syme", "I'd say something witty but you'd likely miss the point"}
    Starting the character syme

    nil
    iex> Actor.crash(:winston)
    :ok
    {"Winston", "Welcome to the revolution"}
    iex> Winston shut down!

    10:32:37.833 [error] GenServer :winston terminating
    ** (Protocol.UndefinedError) protocol String.Chars not implemented for {"Winston", "Welcome to the revolution"} of type Tuple. This protocol is implemented for the following type(s): NaiveDateTime, Float, Date, BitString, Time, DateTime, List, Version.Requirement, URI, Atom, Integer, Version

    Last message: {:"$gen_cast", :crash}
    State: {"Winston", "Welcome to the revolution"}
    Starting the character winston
    Starting the character syme

    nil
    iex> Actor.crash(:julia)
    :ok
    {"Julia", "Let's play"}
    iex> Julia shut down!

    10:32:47.834 [error] GenServer :julia terminating
    ** (Protocol.UndefinedError) protocol String.Chars not implemented for {"Julia", "Let's play"} of type Tuple. This protocol is implemented for the following type(s): NaiveDateTime, Float, Date, BitString, Time, DateTime, List, Version.Requirement, URI, Atom, Integer, Version
    Last message: {:"$gen_cast", :crash}
    State: {"Julia", "Let's play"}
    Starting the character julia
    Starting the character winston
    Starting the character syme

  """

  use Application
  alias BigBrother.Actor

  def start(_type, _args) do
    IO.puts("Big Brother is Watching!")
    children = [child_spec(:julia), child_spec(:winston), child_spec(:syme)]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: BigBrother.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp child_spec(character_name) do
    %{
      id: character_name,
      start: {Actor, :start_link, [character_name]}
    }
  end
end
