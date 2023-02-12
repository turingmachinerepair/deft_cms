defmodule DeftCms.Blog.Post do
    @enforce_keys [:id, :author, :title, :body, :description, :tags, :date]
    defstruct [:id, :author, :title, :body, :description, :tags, :date]

    def build(filename, attrs, body) do
      id = filename
      {:ok, %{mtime: mtime}} = File.stat(filename)
      {date0, _} = mtime
      date = Date.from_erl!(date0)
      struct!(__MODULE__, [id: id, date: date, body: body] ++ Map.to_list(attrs))
    end
  end
