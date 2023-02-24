defmodule DeftCmsWeb.PageController do
  use DeftCmsWeb, :controller
  alias DeftCms.Landing

  def index(conn, _params) do
    data = Landing.landing()
    render(conn, "index.html", data: data)
  end
end
