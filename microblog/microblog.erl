%% A micro-blog, which sets up a frame with menus, and allows an
%% "about" box to be displayed.

-module(microblog).
-compile(export_all).

-include_lib("wx/include/wx.hrl").

-define(ABOUT,?wxID_ABOUT).
-define(EXIT,?wxID_EXIT).

%% Top-level function: create the wx-server, the graphical objects,
%% show the application,process and clean up on termination.

start() ->
  wx:new(),
  Frame = wxFrame:new(wx:null(), ?wxID_ANY, "MicroBlog"),
  setup(Frame),
  wxFrame:show(Frame),
  loop(Frame),
  wx:destroy.

%% Top-level frame: create a menu bar, two menus, two menu items
%% and a status bar. Connect the frame to handle events.

setup(Frame) ->
  MenuBar = wxMenuBar:new(),
  File = wxMenu:new(),
  Help = wxMenu:new(),

  wxMenu:append(Help,?ABOUT,"About MicroBlog"),
  wxMenu:append(File,?EXIT,"Quit"),

  wxMenuBar:append(MenuBar,File,"&File"),
  wxMenuBar:append(MenuBar,Help,"&Help"),

  wxFrame:setMenuBar(Frame,MenuBar),

  wxFrame:createStatusBar(Frame),
  wxFrame:setStatusText(Frame,"Welcome to wxErlang"),

  wxFrame:connect(Frame,command_menu_selected),
  wxFrame:connect(Frame,close_window).

loop(Frame) ->
  receive
    #wx{id=?ABOUT, event=#wxCommand{}} ->
      Str = "MicroBlog is a minimal WxErlang example.",
      MD = wxMessageDialog:new(Frame,Str,
        [{style, ?wxOK bor ?wxICON_INFORMATION},
         {caption,"About microBlog"}]},
    wxDialog:showModal(MD),
    wxDialog:destroy(MD),
    loop(Frame);

    #wx{id=?EXIT, event=#wxCommand{type=command_menu_selected}} ->
      wxWindow:close(Frame,[])
  end.
