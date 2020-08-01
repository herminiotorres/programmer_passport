# Hello

## IEx

Create your own configuration about the `.iex.exs`.
The best option it's read more about in [IEx Docs](https://hexdocs.pm/iex/IEx.html) and the Alchemist Camp has a screencast about configure your own [The .iex.exs file](https://www.youtube.com/watch?v=E0bmtcYrz9M).

```shell
$ cat $HOME/.iex.exs
IEx.configure(history_size: 50)
```

So another options it's connection remotly in your production enviroment using your IEx, here another greate screencast where you could watch and learn more about it. [Using remote console to access IEx in production](https://www.youtube.com/watch?v=RcTJ66tXsK0)

## mix - hex

It's turn the mix and hex your good friend you could run in your terminal a command `mix hex` and see the list hex we could to use and if I would like to search about exist any package for run performance benchmarks? How the way you could find something?

```shell
mix hex.search benchmark
Package            Description                                            Version   URL
benchee            Versatile (micro) benchmarking that is extensible....  1.0.1     https://hex.pm/packages/benchee
benchee_json       JSON formatter for the (micro) benchmarking librar...  1.0.0     https://hex.pm/packages/benchee_json
benchee_html       HTML formatter with pretty graphs for the (micro) ...  1.0.0     https://hex.pm/packages/benchee_html
benchwarmer        Benchwarmer is an Elixir micro-benchmarking utilit...  0.0.2     https://hex.pm/packages/benchwarmer
benchee_csv        Get CSV from your benchee benchmarks to turn them ...  1.0.0     https://hex.pm/packages/benchee_csv
eministat          Basic statistics for comparing datasets from bench...  0.10.1    https://hex.pm/packages/eministat
bmark              A benchmarking tool for Elixir with a focus on com...  1.0.3     https://hex.pm/packages/bmark
benchee_markdown   Markdown formatter for the (micro) benchmarking li...  0.2.4     https://hex.pm/packages/benchee_markdown
bunny              This was an april's fools joke of a benchmarking l...  2.4.2019  https://hex.pm/packages/bunny
benchmark_ips      A tool to run benchmarks to determine iteration pe...  0.2.0     https://hex.pm/packages/benchmark_ips
belixir            Benchmark ips tool for elixir-lang. Runs given cod...  0.2.0     https://hex.pm/packages/belixir
agility            Agility is a benchmark suite framework.                0.0.0     https://hex.pm/packages/agility
ex_bench           An application you can use for benchmarking, read ...  0.3.1     https://hex.pm/packages/ex_bench
logistic_map       Benchmark of Logistic Map using integer calculatio...  1.1.1     https://hex.pm/packages/logistic_map
gen_metrics_bench  An Elixir GenMetrics benchmarking tool for GenServ...  0.1.0     https://hex.pm/packages/gen_metrics_bench
lasp_bench         Lasp Benchmarking Suite                                0.0.1     https://hex.pm/packages/lasp_bench
janky_bench        JankyBench does janky benchmarking.  For robust be...  0.1.0     https://hex.pm/packages/janky_bench
mybench            micro-benchmark tool.                                  0.0.0     https://hex.pm/packages/mybench
erlperf            Erlang Performance & Benchmarking Suite                1.0.0     https://hex.pm/packages/erlperf
```

If we would like to find something related web http, we put the right words and see how its works.

```shell
mix hex.search http
...
```

How creates a mix project with supervisor?

```shell
$ mix new hello --sup
```

What kind are between mix projects with and without supervisor?

```shell
$ cat mix.exs
# Run "mix help compile.app" to learn about applications.
def application do
  [
    extra_applications: [:logger],
    mod: {Hello.Application, []}
  ]
end
```

and...

```shell
$ cat lib/hello/application.ex
defmodule Hello.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: HelloS.Worker.start_link(arg)
      # {Hello.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hello.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```
