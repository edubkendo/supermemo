Supermemo
=========

A library for calculating the next time a flashcard should be shown.

Based on the Supermemo 2 algorithm described [here](http://www.supermemo.com/english/ol/sm2.htm) and the Ruby implementation of it used in [dpwright/srs](https://github.com/dpwright/srs).

## Install

Add Supermemo to your mix.exs:

```elixir
def deps do
  [ {:supermemo, "~> 0.0.1"} ]
end
```

## Usage

```elixir
score = 1
rep = Supermemo.rep(score)

# Do a rep with the card and get a new score.
second_rep = Supermemo.rep(score, rep)

# Another rep

third_rep = Supermemo.rep(score, rep)
...
```

