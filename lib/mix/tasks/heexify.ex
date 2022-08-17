defmodule Mix.Tasks.App.Heexify do
  @moduledoc """
  Used to convert static SVGs to Heex components.

  command: `mix app.heexify`

  Inspired by: PetalFramework
  Git: https://github.com/petalframework/petal_components/blob/main/lib/mix/tasks/heroicons/generate.ex
  """

  @shortdoc "Used to enable usage of SVGs in project"

  @app_name "DerpyCoder"
  @svg_path "priv/static/svgs/"

  use Mix.Task
  alias Phoenix.Naming

  @impl Mix.Task
  def run(_) do
    Mix.Task.run("app.start")

    heexify()
  end

  defp heexify() do
    @svg_path <> "**/*.svg"
    |> Path.wildcard()
    |> Enum.map(fn path ->
      path
      |> String.replace(@svg_path, "")
    end)
    |> Enum.reduce(%{}, fn (path, acc) ->
      value = case Map.get(acc, Path.dirname(path)) do
        nil -> [path]
        array -> [path | array]
      end

      Map.put(acc, Path.dirname(path), value)
    end)
    |> Enum.each(fn {module_path, file_paths} -> build_module(module_path, file_paths) end)
  end

  defp build_module(module_path, file_paths) do
    module_name =
      module_path
      |> String.replace("-", "_")
      |> String.split("/")
      |> Enum.map(&Naming.camelize/1)

    module_name = if length(module_name) > 0 do
      Enum.join(module_name, ".")
    else
      ""
    end

    module_start = """
      defmodule #{module_name} do
        @moduledoc \"\"\"
        Usage.
            <#{module_name}.svg class="w-5 h-5" />
            <#{module_name}.svg title="Optional title for accessibility" class="w-5 h-5" />
        \"\"\"
        use Phoenix.Component
        alias #{@app_name}Web.SVG

        # coveralls-ignore-start
      """

    functions = build_functions(file_paths)
    # IO.puts(functions)

    module_end =
      """
        # coveralls-ignore-stop
      end
      """

    module = module_start <> functions <> module_end

    destination = "lib/#{Naming.underscore(@app_name)}_web/components/_svg/#{module_path}.ex"

    unless File.exists?(destination) do
      File.mkdir_p(Path.dirname(destination))
    end

    File.write!(destination, module)
  end

  defp build_functions(file_paths) do
    file_paths
      |> Enum.map(fn src_path ->
        create_component(src_path)
      end)
      |> Enum.join("\n")
  end

  defp create_component(src_path) do
    svg =
      File.read!(@svg_path <> src_path)
      |> String.trim()
      |> String.replace(~r/<svg /, "<svg class={@class} {@rest} ")
      |> String.replace(~r/<path/, "\n      <SVG.title title={@title} />\n      <path")
      |> String.replace(~r/<\/svg/, "\n     <\/svg")

    build_component(src_path, svg)
  end

  defp build_component(src_path, svg) do
    function_name =
      src_path
      |> Path.basename(".svg")
      |> String.replace("-", "_")

    """
      def #{function_name}(assigns) do
        assigns = assigns
          |> assign_new(:title, fn -> nil end)
          |> assign_new(:class, fn -> nil end)
          |> assign_new(:rest, fn ->
            assigns_to_attributes(assigns, ~w(
              class
            )a)
          end)

        ~H\"\"\"
        #{svg}
        \"\"\"
      end
    """
  end
end
