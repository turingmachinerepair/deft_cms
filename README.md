# DeftCms

Simple CMS for my personal site.  

## Features
- Two tabs - landing and blog
- Landing and post - one markdown file starting with elixir map with post attributes, followed by actual post body.
- Directory with blog posts is watched and content is automatically updated if files are added/deleted/modified.

## Configuration
1. `posts_per_page` - number of posts per page.
2. `landing_file` - md file for landing page.
3. `blog_directory` - list of blog posts.

## Content format
```elixir
%{
    #post attributes, list depends on type
}
---
#post body, regular markdown.
```

## Plans
- [ ] Search (text, titles, tags)
- [ ] Localization
- [ ] Personal projects tab (with fancy layout (and when they will be ready))
- [ ] Refactor paginator
- [ ] Tests
- [ ] CI pipeline with linter, dialyzer and tests
- [ ] Flexible fs change watcher setup (maybe a behaviour which exports list of events and on_update callback)
- [ ] More configurability: list of tabs, favicon and title suffix are hardcoded (you can modify them though).

## Credits
General concept, DeftCms.Publisher.Highliter and DeftCms.Publisher.Press from: https://github.com/dashbitco/nimble_publisher  
Started with this tutorial: https://elixirschool.com/en/lessons/misc/nimble_publisher   
Paginator from here: https://dev.to/ricardoruwer/create-a-paginator-using-elixir-and-phoenix-1hnk  
Idea to store posts in `persistent_term`: https://www.erlang.org/blog/persistent_term/#large-constant-data
