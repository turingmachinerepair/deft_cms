defmodule DeftCms.Updater do
    use GenServer

    require Logger

    @effective_events [:created, :deleted, :closed, :moved_from, :moved_to]

    def start_link(args) do
        GenServer.start_link(__MODULE__, args)
    end

    def init(args) do
        {:ok, watcher_pid} = FileSystem.start_link(args)
        FileSystem.subscribe(watcher_pid)
        {:ok, %{watcher_pid: watcher_pid}}
    end

    def handle_info({:file_event, watcher_pid, {_path, events}}, %{watcher_pid: watcher_pid} = state) do
        case (events -- @effective_events) do
            ^events -> :ok
            _diff -> DeftCms.Blog.load_posts()
        end

       {:noreply, state}
    end

    def handle_info({:file_event, watcher_pid, :stop}, %{watcher_pid: watcher_pid} = state) do
        {:noreply, state}
    end
  end
