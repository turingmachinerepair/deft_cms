defmodule DeftCms.Blog do
    alias DeftCms.Blog.Post

    # And finally export them
    def all_posts() do
        :persistent_term.get(:posts)
    end

    def all_tags() do
        :persistent_term.get(:tags)
    end

    def get_post_by_id!(id) do
        Enum.find(all_posts(), &(&1.id == id)) ||
            raise NotFoundError, "post with id=#{id} not found"
    end

    def get_posts_by_tag!(tag) do
        case Enum.filter(all_posts(), &(tag in &1.tags)) do
            [] -> raise NotFoundError, "posts with tag=#{tag} not found"
            posts -> posts
        end
    end

    def load_posts() do
        blog_directory = Application.get_env(:deft_cms, :blog_directory)
        posts0 = DeftCms.Publisher.Press.render(blog_directory, Post, highlighters: [:makeup_elixir, :makeup_erlang])
        posts = Enum.sort_by(posts0, & &1.date, {:desc, Date})
        tags = posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()
        :persistent_term.put(:posts, posts)
        :persistent_term.put(:tags, tags)
    end

  end


 defmodule NotFoundError, do: defexception [:message, plug_status: 404]
