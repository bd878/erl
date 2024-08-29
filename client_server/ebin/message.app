{application, message,
  [{description, "example message server"},
   {vsn, "1.0.0"},
   {modules, [message_app, message_server, message_sup]},
   {id, "message_app_v1"},
   {registered, []},
   {applications, [kernel, stdlib]},
   {mod, {message_app, []}},
   {env, []}
]}.
