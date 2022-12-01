defmodule Solution do
  Code.require_file("helper.ex")

  def run do
    part_one()
    part_two()
  end

  defp part_one do
    load_and_prepare_input(1)
    |> calculate_calibration_values(:v1)
    |> IO.inspect(label: "Part One")
  end

  defp part_two do
    load_and_prepare_input(2)
    |> calculate_calibration_values(:v2)
    |> IO.inspect(label: "Part Two")
  end

  defp load_and_prepare_input(number) do
    __ENV__.file
    |> Helper.load_file(number)
    |> String.split("\n")
  end

  defguardp is_digit(char) when char in ?0..?9

  defp calculate_calibration_values(input, version) do
    input
    |> Enum.map(fn line ->
      first_digit = find_first_digit(line, version)
      last_digit = find_last_digit(line, version)

      Integer.undigits([first_digit, last_digit])
    end)
    |> Enum.sum()
  end

  defp find_first_digit(<<_, rest::binary>> = str, version),
    do: if(digit = find_digit(str, version), do: digit, else: find_first_digit(rest, version))

  defp find_last_digit(input, version), do: find_first_digit(String.reverse(input), version)

  defp find_digit(<<char, _::binary>>, _version) when is_digit(char), do: char - ?0
  defp find_digit(<<"one", _::binary>>, :v2), do: 1
  defp find_digit(<<"eno", _::binary>>, :v2), do: 1
  defp find_digit(<<"two", _::binary>>, :v2), do: 2
  defp find_digit(<<"owt", _::binary>>, :v2), do: 2
  defp find_digit(<<"three", _::binary>>, :v2), do: 3
  defp find_digit(<<"eerht", _::binary>>, :v2), do: 3
  defp find_digit(<<"four", _::binary>>, :v2), do: 4
  defp find_digit(<<"ruof", _::binary>>, :v2), do: 4
  defp find_digit(<<"five", _::binary>>, :v2), do: 5
  defp find_digit(<<"evif", _::binary>>, :v2), do: 5
  defp find_digit(<<"six", _::binary>>, :v2), do: 6
  defp find_digit(<<"xis", _::binary>>, :v2), do: 6
  defp find_digit(<<"seven", _::binary>>, :v2), do: 7
  defp find_digit(<<"neves", _::binary>>, :v2), do: 7
  defp find_digit(<<"eight", _::binary>>, :v2), do: 8
  defp find_digit(<<"thgie", _::binary>>, :v2), do: 8
  defp find_digit(<<"nine", _::binary>>, :v2), do: 9
  defp find_digit(<<"enin", _::binary>>, :v2), do: 9
  defp find_digit(_, _version), do: nil
end

Solution.run()
