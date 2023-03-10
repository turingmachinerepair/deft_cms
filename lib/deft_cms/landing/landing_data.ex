defmodule DeftCms.Landing.LandingData do
    @enforce_keys [:body, :date]
    defstruct [:body, :date]

    @type landing :: %__MODULE__{
        body: String.t,
        date: Date.t
    }

    @spec build(binary, map, any) :: __MODULE__.landing
    def build(filename, attrs, body) do
        {:ok, %{mtime: mtime}} = File.stat(filename)
        {date0, _} = mtime
        date = Date.from_erl!(date0)
        struct!(__MODULE__, [date: date, body: body] ++ Map.to_list(attrs))
    end
  end
