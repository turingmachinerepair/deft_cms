defmodule DeftCms.Blog.Post do
    @enforce_keys [:id, :author, :title, :body, :description, :tags, :date]
    defstruct [:id, :author, :title, :body, :description, :tags, :date]

    @type body :: String.t
    @type tag  :: String.t
    @type id   :: String.t

    @type post :: %__MODULE__{
        id:     __MODULE__.id,
        author:   String.t,
        title: String.t,
        body: __MODULE__.body,
        description: String.t,
        tags: [__MODULE__.tag],
        date: Date.t
    }

    @spec build(binary, map, any) :: __MODULE__.post
    def build(filename, attrs, body) do
        {:ok, %{mtime: mtime}} = File.stat(filename)
        {date0, _} = mtime
        date = Date.from_erl!(date0)
        struct!(__MODULE__, [date: date, body: body] ++ Map.to_list(attrs))
    end
  end
