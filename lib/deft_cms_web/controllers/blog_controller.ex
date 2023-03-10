defmodule DeftCmsWeb.BlogController do
    use DeftCmsWeb, :controller

    alias DeftCms.Blog

    def index(conn, %{"page" => page_str}) do
        all_posts = Blog.all_posts()
        case Integer.parse(page_str) do
            {page, ""} ->
                posts = list_posts(all_posts, page)
                render(conn, "index.html", posts: posts, page_title: "Blog" )
            _ ->
                conn
                |> put_flash(:error, "Invalid page.")
                |> redirect(to: Routes.blog_path(conn, :index))
        end
    end
    def index(conn, params) do
        index(conn, Map.put(params, "page", "1"))
    end

    def show(conn, %{"id" => id}) do
        post = Blog.get_post_by_id!(id)
        render(conn, "show.html", post: post, page_title: post.title)
    end


    defp list_posts(posts, requested_page) do
        posts_per_page = Application.get_env(:deft_cms, :posts_per_page)
        total_pages = ceil(length(posts) / posts_per_page )
        page = case total_pages do
            0 -> 1
            total_pages when requested_page > total_pages -> total_pages
            _ when requested_page <= 0 -> 1
            _ -> requested_page
        end

        offset = (page-1)*posts_per_page
        page_posts = Enum.slice(posts, offset, posts_per_page)

        %{
            current_page: page,
            results_per_page: posts_per_page,
            total_pages: total_pages,
            total_results: length(posts),
            data: page_posts
        }
    end

end
