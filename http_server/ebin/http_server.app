{application, http_server,
  [{description, "example http server"},
   {vsn, "1.0"},
   {modules, [http_server]},
   {id, "http_server_v1"},
   {registered, [http_server]},
   {applications, [kernel, stdlib]},
   {mod, {http_server, [
     {inets, [{services, [{httpd, [{proplist_file,
               "/var/tmp/server_root/conf/8080_props.conf"}]
     }] }] }
   ] }},
   {env, []}
]}.

{}.
