defmodule DeftCms.Blog do
    alias DeftCms.Blog.Post

    @tags_term_name {__MODULE__, :tags}
    @posts_term_name {__MODULE__, :posts}

    @spec all_posts :: [Post.post]
    def all_posts, do: :persistent_term.get(@posts_term_name)

    @spec all_tags :: [Post.tag]
    def all_tags, do: :persistent_term.get(@tags_term_name)

    @spec get_post_by_id!(Post.id) :: Post.post
    def get_post_by_id!(id) do
        Enum.find(all_posts(), &(&1.id == id)) ||
            raise NotFoundError, "post with id=#{id} not found"
    end

    @spec get_posts_by_tag!(Post.tag) :: [Post.post]
    def get_posts_by_tag!(tag) do
        case Enum.filter(all_posts(), &(tag in &1.tags)) do
            [] -> raise NotFoundError, "posts with tag=#{tag} not found"
            posts -> posts
        end
    end

    @spec load_posts :: :ok
    def load_posts() do
        blog_directory = Application.get_env(:deft_cms, :blog_directory)
        posts0 = DeftCms.Publisher.Press.render(blog_directory, Post, highlighters: [:makeup_elixir, :makeup_erlang])
        posts = Enum.sort_by(posts0, & &1.date, {:desc, Date})
        tags = posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()
        :persistent_term.put(@posts_term_name, posts)
        :persistent_term.put(@tags_term_name, tags)
    end
end

defmodule NotFoundError, do: defexception [:message, plug_status: 404]
