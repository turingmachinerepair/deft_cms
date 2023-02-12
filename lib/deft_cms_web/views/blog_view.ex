defmodule DeftCmsWeb.BlogView do
    use DeftCmsWeb, :view

    def title("show.html", assigns) do
        assigns.post.title
    end
end
