defmodule Helper do

  @filename "input.txt"

  def load_file(directory, number) do
    directory
    |> file_name(number)
    |> File.read!()
  end

  defp file_name(directory, number) do
    directory = String.replace(directory, "solution.exs", "")

    file_name =
      case System.argv() do
        [] -> @filename
        [name] -> "#{name}#{number}-#{@filename}"
      end

    Path.join(directory, file_name)
  end
end
