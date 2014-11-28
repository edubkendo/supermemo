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
# Initial rep

    rep = Supermemo.rep(1)
    # %Supermemo.Rep{due: %Timex.DateTime{calendar: :gregorian, day: 29, hour: 5,
    #   minute: 45, month: 11, ms: 0, second: 18,
    #   timezone: %Timex.TimezoneInfo{dst_abbreviation: "UTC", dst_end_day: :undef,
    #    dst_end_time: {0, 0}, dst_name: "UTC", dst_start_day: :undef,
    #    dst_start_time: {0, 0}, full_name: "UTC", gmt_offset_dst: 0,
    #    gmt_offset_std: 0, standard_abbreviation: "UTC", standard_name: "UTC"},
    #   year: 2014}, e_factor: 2.6, interval: 1, iteration: 1, repeat: false}

# Do a rep with the card and get a new score.
    
    rep = Supermemo.rep(1, rep)
    # %Supermemo.Rep{due: %Timex.DateTime{calendar: :gregorian, day: 4, hour: 5,
    #   minute: 45, month: 12, ms: 0, second: 23,
    #   timezone: %Timex.TimezoneInfo{dst_abbreviation: "UTC", dst_end_day: :undef,
    #    dst_end_time: {0, 0}, dst_name: "UTC", dst_start_day: :undef,
    #    dst_start_time: {0, 0}, full_name: "UTC", gmt_offset_dst: 0,
    #    gmt_offset_std: 0, standard_abbreviation: "UTC", standard_name: "UTC"},
    #   year: 2014}, e_factor: 2.7, interval: 6, iteration: 2, repeat: false}

# Another rep

    third_rep = Supermemo.rep(0.8, rep)
# ...
```

