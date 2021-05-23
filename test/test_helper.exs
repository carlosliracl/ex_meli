Application.ensure_all_started(:hackney)
Application.ensure_all_started(:jsx)
Application.ensure_all_started(:bypass)

Mox.defmock(ExMeli.Request.HttpMock, for: ExMeli.Request.HttpClient)

ExUnit.start()
