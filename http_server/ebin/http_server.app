{application, http_server,
  [{description, "example http server"},
   {vsn, "1.0"},
   {modules, [http_server, http_server_sup, http_handler]},
   {id, "http_server_v1"},
   {registered, [http_server]},
   {applications, [inets, kernel, stdlib]},
   {mod, {http_server, []}},
   {env, []}
]}.

