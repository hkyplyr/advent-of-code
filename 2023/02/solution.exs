defmodule Solution do
  Code.require_file("helper.ex")

  def run do
    part_one()
    part_two()
  end

  defp part_one do
    load_and_prepare_input(1)
    |> parse_games()
    |> solve_part_one()
    |> IO.inspect(label: "Part One")
  end

  defp part_two do
    load_and_prepare_input(2)
    |> parse_games()
    |> solve_part_two()
    |> IO.inspect(label: "Part Two")
  end

  defp load_and_prepare_input(number) do
    __ENV__.file
    |> Helper.load_file(number)
    |> String.split("\n")
  end

  defp parse_games(input) do
    Enum.map(input, &parse_game/1)
  end

  defp parse_game(line) do
    ["Game " <> game, rest] = String.split(line, ":")

    game_total =
      rest
      |> String.split(";")
      |> Enum.flat_map(fn raw_sets ->
        raw_sets
        |> String.trim()
        |> String.split(", ")
      end)
      |> Enum.reduce(%{}, fn entry, acc ->
        [str_number, colour] = String.split(entry, " ")
        number = String.to_integer(str_number)

        if number > Map.get(acc, colour, 0) do
          Map.put(acc, colour, number)
        else
          acc
        end
      end)

    {String.to_integer(game), game_total}
  end

  defp solve_part_one(games) do
    games
    |> Enum.map(fn {game_id, game} ->
      %{"red" => red, "green" => green, "blue" => blue} = game
      if red <= 12 and green <= 13 and blue <= 14, do: game_id, else: 0
    end)
    |> Enum.sum()
  end

  defp solve_part_two(games) do
    games
    |> Enum.map(fn {_game_id, game} ->
      %{"red" => red, "green" => green, "blue" => blue} = game
      red * green * blue
    end)
    |> Enum.sum()
  end
end

Solution.run()
