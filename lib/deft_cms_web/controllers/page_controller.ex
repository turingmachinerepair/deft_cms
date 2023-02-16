defmodule DeftCmsWeb.PageController do
  use DeftCmsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", data: <<"">>)
  end
end
