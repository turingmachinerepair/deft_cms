defmodule DeftCms.Landing do
    alias DeftCms.Landing.LandingData

    @landing_term_name {__MODULE__, :landing}

    def landing, do: :persistent_term.get(@landing_term_name)

    def load_landing() do
        landing_file = Application.get_env(:deft_cms, :landing_file)
        [landing] = DeftCms.Publisher.Press.render(landing_file, LandingData, highlighters: [:makeup_elixir, :makeup_erlang])
        :persistent_term.put(@landing_term_name, landing)
    end

  end
