{application, messages,
  [{description, "example message server"},
   {vsn, "1.0"},
   {modules, [messages, messages_server, messages_sup]},
   {id, "messages_v1"},
   {registered, []},
   {applications, [kernel, stdlib]},
   {mod, {messages, []}},
   {env, []}
]}.
