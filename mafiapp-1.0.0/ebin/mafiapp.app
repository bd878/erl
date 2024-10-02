{application, mafiapp,
  [{description, "Keep track of our friends"},
   {vsn, "1,0.0"},
   {modules, [mafiapp, mafiapp_sup]},
   {applications, [stdlib, kernel, mnesia]}]}.
