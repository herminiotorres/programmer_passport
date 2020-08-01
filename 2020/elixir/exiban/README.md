# How create and publish your package

I read in this days the article [How to create and publish Hex.pm package (Elixir)](https://medium.com/kkempin/how-to-create-and-publish-hex-pm-package-elixir-90cb33e2592d) by [Krzysztof Kempiński](https://medium.com/@kkempin), and I try to follow the article and replicate this steps, but the article are too old and I decide to write this readme more update.

It's very important to read the article because I'm doing in a short version in here.

Bassicly for Elixir and Erlang has a service for manager the packages. You must be enforce to read [the about Hex.pm page](https://hex.pm/about), and you get to know about what kind are Hex.pm.

This example is a very short version for [exiban package](https://hex.pm/packages/exiban).

## Requirements

You just install `erlang` `otp-22` or later and `elixir` `1.10` or later.

## Creating the project

Lets go how the `mix` works and getting fun.

```shell
mix new exiban
```

After create a new project called exiban, your list of files and directories its something like this:

```shell
$ tree .
.
├── deps
├── lib
│   └── exiban.ex
├── mix.exs
├── mix.lock
├── README.md
└── test
    ├── exiban_test.exs
    └── test_helper.exs

3 directories, 6 files
```

## mix.exs

Its your principal file for your project, in here you could add a dependencies, description and infos for you package. In here a use the [mix.exs at ex_doc](https://github.com/elixir-lang/ex_doc/blob/master/mix.exs) for example and to guide me to create my example. By the way we use the ex_doc as a dependency for our project, so if you have any douts you definitly consulting the ex_doc documentation.

```elixir
defp deps do
  [
    {:ex_doc, "~> 0.22", only: :dev, runtime: false}
  ]
end
```

**PS**: Open the `mix.exs` and look at there.

We almost finish, after do what we need to do in `mix.exs` we need to get our dependencies, so you need to run this command in your shell:

```shell
$ mix deps.get
Resolving Hex dependencies...
Dependency resolution completed:
Unchanged:
  earmark 1.4.5
  ex_doc 0.22.1
  makeup 1.0.3
  makeup_elixir 0.14.1
  nimble_parsec 0.6.0
* Getting ex_doc (Hex package)
* Getting earmark (Hex package)
* Getting makeup_elixir (Hex package)
* Getting makeup (Hex package)
* Getting nimble_parsec (Hex package)
```

This is are the dependencies after we get:

```shell
ls deps/
earmark  ex_doc  makeup  makeup_elixir  nimble_parsec
```

## lib/

Where the place you are put your business logic. When you create you `exiban` project propably it's quite different this in here.

Look at this file and after that we are change a little bit for creates a fake and short version for the original package.

```elixir
defmodule ExIban do
  @moduledoc """
  Documentation for `Exiban`.
  Validate and manipulate IBAN account number.
  """

  @doc """
  Returns country code extracted from IBAN.

  ## Examples

      iex> ExIban.country_code("GB82 WEST 1234 5698 7654 32")
      "GB"

  """
  def country_code(iban) do
    {country_code, _, _, _, _, _} =
      iban
      |> String.split()
      |> List.to_tuple()

    Regex.run(~r{[^\d].}, country_code) |> List.first()
  end
end
```

## the documentation

Generate the documentation:

```shell
$ mix docs
==> nimble_parsec
Compiling 4 files (.ex)
Generated nimble_parsec app
==> makeup
Compiling 44 files (.ex)
Generated makeup app
==> earmark
Compiling 1 file (.yrl)
Compiling 2 files (.xrl)
Compiling 3 files (.erl)
Compiling 33 files (.ex)
Generated earmark app
==> makeup_elixir
Compiling 4 files (.ex)
Generated makeup_elixir app
==> ex_doc
Compiling 22 files (.ex)
Generated ex_doc app
==> exiban
Compiling 1 file (.ex)
Generated exiban app
Generating docs...
View "html" docs at "doc/index.html"
View "epub" docs at "doc/exiban.epub"
```

## the test

```shell
Run the tests:

mix test
Compiling 1 file (.ex)
Generated exiban app
..

Finished in 0.02 seconds
1 doctest, 1 test, 0 failures

Randomized with seed 194632
```

## Publishing to Hex.pm

About this topic I suggest you read in the original article about.

Extra references you would like to see and read more.

- [Become a Hex Power User](https://medium.com/@toddresudek/hex-power-user-deb608e60935)
- [Hex Docs](https://hex.pm/docs/usage)
