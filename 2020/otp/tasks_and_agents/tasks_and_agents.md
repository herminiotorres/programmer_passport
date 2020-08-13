# Tasks and Agents

## Tasks

Conveniences for spawning and awaiting tasks.

Tasks are processes meant to execute one particular action throughout their
lifetime, often with little or no communication with other processes. The most
common use case for tasks is to convert sequential code into concurrent code by
computing a value asynchronously:

    task = Task.async(fn -> do_some_work() end)
    res = do_some_other_work()
    res + Task.await(task)

Tasks spawned with async can be awaited on by their caller process (and only
their caller) as shown in the example above. They are implemented by spawning a
process that sends a message to the caller once the given computation is
performed.

Besides async/1 and await/2, tasks can also be started as part of a supervision
tree and dynamically spawned on remote nodes. We will explore all three
scenarios next.

```elixir
iex> i task
Term
  %Task{owner: #PID<0.110.0>, pid: #PID<0.126.0>, ref: #Reference<0.3406273138.9437185.92001>}
Data type
  Task
Description
  This is a struct. Structs are maps with a __struct__ key.
Reference modules
  Task, Map
Implemented protocols
  IEx.Info, Inspect
```

```elixir
iex> exports Task
__using__/1        __struct__/0       __struct__/1       async/1            async/3            
async_stream/2     async_stream/3     async_stream/4     async_stream/5     await/1            
await/2            child_spec/1       find/2             shutdown/1         shutdown/2         
start/1            start/3            start_link/1       start_link/3       yield/1            
yield/2            yield_many/1       yield_many/2
```

```elixir
iex> long_work = fn -> Process.sleep(4000); 42 end
#Function<21.126501267/0 in :erl_eval.expr/5>

iex> long_work.()
42

iex> task = Task.async(long_work)
%Task{
  owner: #PID<0.110.0>,
  pid: #PID<0.116.0>,
  ref: #Reference<0.1365824277.3766222849.75307>
}

iex> 1 + Task.await(task)
43

iex> Process.alive?(task.pid)
false

iex> task = Task.async(long_work)
%Task{
  owner: #PID<0.110.0>,
  pid: #PID<0.121.0>,
  ref: #Reference<0.1365824277.3766222849.75396>
}

iex> Process.alive?(task.pid)    
true

iex> Process.alive?(task.pid)
false

iex> flush
{#Reference<0.1365824277.3766222849.75396>, 42}
{:DOWN, #Reference<0.1365824277.3766222849.75396>, :process, #PID<0.121.0>,
 :normal}
:ok

iex> Task.await(task)
** (exit) exited in: Task.await(%Task{owner: #PID<0.110.0>, pid: #PID<0.121.0>, ref: #Reference<0.1365824277.3766222849.75396>}, 5000)
    ** (EXIT) time out
    (elixir 1.10.4) lib/task.ex:607: Task.await/2
```

## Agents

Agents are a simple abstraction around state.

Often in Elixir there is a need to share or store state that must be accessed
from different processes or by the same process at different points in time.

The Agent module provides a basic server implementation that allows state to be
retrieved and updated via a simple API.

```elixir
iex> i agent
Term
  #PID<0.112.0>
Data type
  PID
Alive
  true
Name
  not registered
Links
  #PID<0.110.0>
Message queue length
  0
Description
  Use Process.info/1 to get more info about this process
Reference modules
  Process, Node
Implemented protocols
  IEx.Info, Inspect
```

```elixir
iex> exports Agent
__using__/1          cast/2               cast/4               child_spec/1         
get/2                get/3                get/4                get/5                
get_and_update/2     get_and_update/3     get_and_update/4     get_and_update/5     
start/1              start/2              start/3              start/4              
start_link/1         start_link/2         start_link/3         start_link/4         
stop/1               stop/2               stop/3               update/2             
update/3             update/4             update/5             
```

```elixir
iex> {:ok, agent} = Agent.start_link(fn -> 42 end)
{:ok, #PID<0.112.0>}

iex> agent
#PID<0.112.0>

iex> Agent.get(agent, &(&1))
42

iex> Agent.get(agent, &(&1 + 1))
43

iex> Agent.get(agent, &(&1))    
42

iex> Agent.update(agent, &(&1 + 1))
:ok

iex> Agent.update(agent, &(&1 + 1))
:ok

iex> Agent.get(agent, &(&1))       
44

iex> Process.alive?(agent)
true
```
