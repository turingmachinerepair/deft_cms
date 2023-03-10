PROJECT := deft_cms
VSN := 0.1.0

build:
	MIX_ENV=prod mix deps.get
	MIX_ENV=prod mix compile
	MIX_ENV=prod mix phx.digest
	MIX_ENV=prod mix release
	cp _build/prod/$(PROJECT)-$(VSN).tar.gz ./