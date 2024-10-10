{application, store,
  [{description, "distributed store built with OTP principles"},
   {id, "dist_store"},
   {vsn, "1.0.0"},
   {modules, []},
   {registered, [store, store_server, store_sup]},
   {applications, [kernel, stdlib]},
   {mod, {store, []}}
]}.
