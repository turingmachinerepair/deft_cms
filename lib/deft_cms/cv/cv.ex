defmodule DeftCms.CV do
    alias DeftCms.CV.CVData

    use NimblePublisher,
        build: CVData,
        from: Application.app_dir(:deft_cms, "priv/cv/*.md"),
        as: :cv

    @cv List.first(@cv)

    def cv, do: @cv

  end


 defmodule NotFoundError, do: defexception [:message, plug_status: 404]
