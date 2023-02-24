defmodule DeftCmsWeb.CVController do
    use DeftCmsWeb, :controller
    alias DeftCms.CV

    def index(conn, _params) do
      data = CV.cv()
      render(conn, "index.html", data: data, page_title: "CV")
    end
  end
