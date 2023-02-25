

build:
	MIX_ENV=prod mix deps.get
	MIX_ENV=prod mix compile
	MIX_ENV=prod mix phx.digest
	MIX_ENV=prod mix release
