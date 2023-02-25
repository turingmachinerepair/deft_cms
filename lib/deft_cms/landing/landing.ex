defmodule DeftCms.Landing do
    alias DeftCms.Landing.LandingData

    use NimblePublisher,
        build: LandingData,
        from: Application.app_dir(:deft_cms, "priv/landing/*.md"),
        as: :landing


    @landing List.first(@landing)

    def landing, do: @landing

  end
