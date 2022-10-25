defmodule Mix.Tasks.App.Heexify do
  @moduledoc """
  Used to convert static SVGs to Heex components.

  command: `mix app.heexify`

  Inspired by: PetalFramework
  Git: https://github.com/petalframework/petal_components/blob/main/lib/mix/tasks/heroicons/generate.ex
  """

  @shortdoc "Used to enable usage of SVGs in project"

  @app_name "DerpyCoder"
  @svg_path "priv/static/icons/"

  use Mix.Task
  alias Phoenix.Naming

  @impl Mix.Task
  def run(_) do
    Mix.Task.run("app.start")

    crunch_svgs_folder()

    Mix.Task.run("format")
  end

  # ==============================================================================
  # It Crunches SVGs and for that, it:
  # - Goes over each file in SVGs folder.
  # - Segments modules based on folder structure by building hashmap.
  # - Assembles the module with helper functions.
  # - Writes them into Separate files.
  # ==============================================================================
  defp crunch_svgs_folder() do
    (@svg_path <> "**/*.svg")
    |> Path.wildcard()
    |> Enum.map(&String.replace(&1, @svg_path, ""))
    |> Enum.reduce(%{}, &build_hashmap/2)
    |> Enum.map(&assemble_module/1)
    |> Enum.each(&write_module/1)
  end

  # ==============================================================================
  # Hashmap
  # It goes over array of paths, which looks like:
  # ["hero-icons/solid/eye", "hero-icons/solid/code"]
  #
  # And groups them based on immediate containing folder.
  # Which looks like:
  # %{
  #   "hero-icons/solid => ["hero-icons/solid/eye", "hero-icons/solid/code"]
  # }
  #
  # This helps us with colocating each file inside their respective modules.
  # So the key in above hashmap becomes the module: HeroIcons.Solid
  # And the value becomes the HEEX Component: HeroIcons.Solid.code
  # ==============================================================================
  defp build_hashmap(path, acc) do
    value =
      case Map.get(acc, Path.dirname(path)) do
        nil -> [path]
        array -> [path | array]
      end

    Map.put(acc, Path.dirname(path), value)
  end

  # ==============================================================================
  # Module Assembler
  # It creates the file structure for the Module.
  # Adds sensible commments with examples.
  # And assimilates all the svgs withing as functions.
  # ==============================================================================
  defp assemble_module({module_path, file_paths}) do
    module_name = module_name(module_path)

    module = """
    defmodule #{module_name} do
      @moduledoc \"\"\"
      # #{module_name}
      Contains Heexified SVG Components, to ease usage of SVG without cluttering markup.

      ## Examples:
          <#{module_name}.svg class="w-5 h-5" />
      \"\"\"
      use Phoenix.Component

      # coveralls-ignore-start
      #{assimilate_svg(file_paths)}
      # coveralls-ignore-stop
    end
    """

    {module_path, module}
  end

  # ==============================================================================
  # Module Name Helper
  # ==============================================================================
  defp module_name(module_path) do
    module_path
    |> String.split("/")
    |> Enum.map(&Naming.camelize/1)
    |> case do
      nil -> ""
      module_name -> Enum.join(module_name, ".")
    end
  end

  # ==============================================================================
  # Loops over each file.
  # And Creates HEEX Components array.
  # ==============================================================================
  defp assimilate_svg(file_paths) do
    file_paths
    |> Enum.map(&create_component/1)
    |> Enum.join("\n")
  end

  # ==============================================================================
  # Creates HEEX Component.
  # Reads SVG Files.
  # Alters and Assemble it.
  # ==============================================================================
  defp create_component(file_path) do
    File.read!(@svg_path <> file_path)
    |> String.replace(~r/<svg /, "<svg class={@class} {@extra} ")
    |> assemble_component(file_path)
  end

  # ==============================================================================
  # Assembles the HEEX Component.
  # Adds Comments and Assigns to create flexible HEEX Component.
  # ==============================================================================
  defp assemble_component(svg, file_path) do
    module_name =
      file_path
      |> Path.dirname()
      |> module_name()

    function_name = function_name(file_path)

    """
      @doc \"\"\"
      # #{module_name}.#{function_name}
      A Heexified SVG component, that can be passed class, and extra attributes, to alter it.

      ## Examples:
          <#{module_name}.#{function_name} class="w-5 h-5" />
      \"\"\"
      def #{function_name}(assigns) do
        assigns =
          assigns
          |> assign_new(:class, fn -> nil end)
          |> assign_new(:extra, fn -> assigns_to_attributes(assigns, ~w(class)a) end)

        ~H\"\"\"
        #{svg}
        \"\"\"
      end
    """
  end

  # ==============================================================================
  # Function Name Helper
  # ==============================================================================
  defp function_name(file_path) do
    file_path
    |> Path.basename(".svg")
    |> String.replace("-", "_")
  end

  # ==============================================================================
  # Writes the Assembled Module to file.
  # ==============================================================================
  defp write_module({module_path, module}) do
    module_path = String.replace(module_path, "-", "_")
    destination = "lib/#{Naming.underscore(@app_name)}_web/components/_svg/#{module_path}.ex"

    unless File.exists?(destination) do
      File.mkdir_p(Path.dirname(destination))
    end

    File.write!(destination, module)
  end
end
