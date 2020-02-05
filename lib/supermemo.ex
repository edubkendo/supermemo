defmodule Supermemo do
  @default_ef 2.5
  @min_ef 1.3
  @first_interval 1
  @second_interval 6
  @iteration_reset_boundary 0.4
  @repeat_boundary 4.0 / 5.0

  @doc """
  Given a value between 0.0 and 1.0, returns an initial `%Supermemo.Rep{}`.
  """
  def rep(score) do
    %Supermemo.Rep{
      due: first_due_date(),
      repeat: repeat?(score),
      e_factor: adjust_efactor_or_min(@default_ef, score),
      interval: @first_interval,
      iteration: 1
    }
  end

  @doc """
  Given a score between 0.0 and 1.0, and a `%Supermemo.Rep{}` struct, returns
  a new struct with updated `due` date, `interval`, `iteration` and `e_factor`.
  """
  def rep(score, %Supermemo.Rep{
                   e_factor: ef,
                   interval: interval,
                   iteration: iteration}) do
    new_interval = set_interval(score, iteration, interval, ef)
    new_ef = adjust_efactor_or_min(ef, score)
    _rep(score, new_ef, new_interval, iteration)
  end

  defp _rep(score, ef, interval, iteration) do
    %Supermemo.Rep{
      due: due_date(interval),
      repeat: repeat?(score),
      e_factor: ef,
      interval: interval,
      iteration: find_iteration(score, iteration) + 1
    }
  end

  def due_date(interval) do
    DateTime.utc_now()
    |> DateTime.add(days_to_seconds(interval))
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
      true -> iteration
    end
  end

  def first_due_date do
    DateTime.utc_now()
    |> DateTime.add(days_to_seconds(@first_interval))
  end

  def repeat?(score) do
    cond do
      score < @repeat_boundary -> true
      true -> false
    end
  end

  def adjust_efactor_or_min(ef, score) do
    adjusted = adjust_efactor(ef, score)

    cond do
      adjusted < @min_ef -> @min_ef
      true -> adjusted
    end
  end

  def adjust_efactor(ef, score) do
    (score * 5)
    |> adjust_efactor_formula(ef)
  end

  defp adjust_efactor_formula(q, ef) do
    ef + (0.1 - (5.0 - q) * (0.08 + (5.0 - q) * 0.02))
  end

  defp days_to_seconds(days) do
    days * 60 * 60 * 24
  end
end
