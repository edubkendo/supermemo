defmodule Supermemo do  
  @default_ef 2.5
  @min_ef 1.3
  @first_interval 1
  @second_interval 6
  @iteration_reset_boundary 3.0 / 5.0
  @repeat_boundary 4.0 / 5.0

  def rep(score) do
    %Supermemo.Rep{
                    due: first_due_date,
                    repeat: repeat?(score),
                    e_factor: adjust_efactor_or_min(@default_ef, score),
                    interval: @first_interval,
                    iteration: 1
                  }
  end

  def rep(score, %Supermemo.Rep{
                   e_factor: ef,
                   interval: interval,
                   iteration: iteration,
                   repeat: repeat}) do
    new_interval = set_interval(score, iteration, interval, ef)
    new_ef = adjust_efactor_or_min(ef, score)
    _rep(score, new_ef, new_interval, iteration)
  end

  def rep(score, %Supermemo.Rep{
                   e_factor: ef,
                   interval: interval,
                   iteration: iteration,
                   repeat: false}) do
    _rep(score, ef, interval, iteration)
  end

  defp _rep(score, ef, interval, iteration) do
    %Supermemo.Rep{
                  due: due_date(interval),
                  repeat: repeat?(score),
                  e_factor: ef,
                  interval: interval,
                  iteration: find_iteration(score, iteration)
              }
  end

  def due_date(interval) do
    Timex.Date.universal
      |> Timex.Date.shift(days: interval)
  end

  def set_interval(score, iteration, interval, ef) do
    case find_iteration(score, iteration) do
      0 -> @first_interval
      1 -> @second_interval
      _ -> adjust_interval(interval, ef)
    end
  end

  def adjust_interval(interval, ef) do
    round(interval * ef)
  end

  def find_iteration(score, iteration) do
    cond do
      score < @iteration_reset_boundary -> 0
                                      _ -> iteration
    end
  end

  def first_due_date do
    Timex.Date.universal
      |> Timex.Date.shift(days: @first_interval)
  end

  def repeat?(score) do
    cond do
      score < @repeat_boundary -> true
      _ -> false
    end
  end

  def adjust_efactor_or_min(ef, score) do
    adjusted = adjust_efactor(ef, score)
    cond do
      adjusted < @min_ef -> @min_ef
      _ -> adjusted
    end
  end
  
  defp adjust_efactor(ef, score) do
    score * 5
    |> adjust_efactor_formula(ef)
  end

  def adjust_efactor_formula(q, ef) do
    ef + (0.1 - (5.0 - q) * (0.08 + (5.0 - q) * 0.02))
  end
end
