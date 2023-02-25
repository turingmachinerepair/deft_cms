defmodule DeftCmsWeb.PaginatorHelpers do
    @moduledoc """
    Renders the pagination with a previous button, the pages, and the next button.
    """

    use Phoenix.HTML

    def render(_, %{:total_pages => 0}, _) do

    end
    def render(conn, data, class: class) do
      start = start_button(conn, data)
      prev = prev_button(conn, data)
      pages = page_buttons(conn, data)
      next = next_button(conn, data)
      finish = finish_button(conn, data)

      content_tag(:ul, [start, prev, pages, next, finish], class: class)
    end


    defp prev_button(conn, data) do
      page = data.current_page - 1
      disabled = data.current_page == 1
      params = build_params(conn, page)

      content_tag(:li, disabled: disabled) do
        link to: "?#{params}", rel: "prev" do
          "<"
        end
      end
    end

    defp page_buttons(conn, data) do
      for page <- 1..data.total_pages do
        class = if data.current_page == page, do: "active"
        disabled = data.current_page == page
        params = build_params(conn, page)

        content_tag(:li, class: class, disabled: disabled) do
          link(page, to: "?#{params}")
        end
      end
    end

    defp next_button(conn, data) do
      page = data.current_page + 1
      disabled = data.current_page >= data.total_pages
      params = build_params(conn, page)

      content_tag(:li, disabled: disabled) do
        link to: "?#{params}", rel: "next" do
          ">"
        end
      end
    end

    defp start_button(conn, data) do
        page = 1
        disabled = data.current_page == page
        params = build_params(conn, page)

        content_tag(:li, disabled: disabled) do
          link to: "?#{params}", rel: "start" do
            "<<"
          end
        end
    end

    defp finish_button(conn, data) do
        page = data.total_pages
        disabled = data.current_page == page
        params = build_params(conn, page)

        content_tag(:li, disabled: disabled) do
          link to: "?#{params}", rel: "finish" do
            ">>"
          end
        end
    end

    defp build_params(conn, page) do
      conn.query_params |> Map.put("page", page) |> URI.encode_query()
    end
  end
