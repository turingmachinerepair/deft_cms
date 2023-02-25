defmodule DeftCms.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DeftCmsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DeftCms.PubSub},
      # Start the Endpoint (http/https)
      DeftCmsWeb.Endpoint,
      # Start a worker by calling: DeftCms.Worker.start_link(arg)
      # {DeftCms.Worker, arg}
      {DeftCms.Updater, dirs: [Path.dirname(Application.get_env(:deft_cms, :blog_directory))]}
    ]

    load_content()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DeftCms.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DeftCmsWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp load_content() do
    DeftCms.Blog.load_posts()
    DeftCms.Landing.load_landing()
  end
end
