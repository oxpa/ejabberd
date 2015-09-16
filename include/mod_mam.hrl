%%%----------------------------------------------------------------------
%%%
%%% ejabberd, Copyright (C) 2002-2015   ProcessOne
%%%
%%% This program is free software; you can redistribute it and/or
%%% modify it under the terms of the GNU General Public License as
%%% published by the Free Software Foundation; either version 2 of the
%%% License, or (at your option) any later version.
%%%
%%% This program is distributed in the hope that it will be useful,
%%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%%% General Public License for more details.
%%%
%%% You should have received a copy of the GNU General Public License along
%%% with this program; if not, write to the Free Software Foundation, Inc.,
%%% 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
%%%
%%%----------------------------------------------------------------------

-record(muc_online_room,
        {name_host = {<<"">>, <<"">>} :: {binary(), binary()} | '$1' |
                                         {'_', binary()} | '_',
         pid = self()                 :: pid() | '$2' | '_' | '$1'}).

-record(archive_msg,
        {us = {<<"">>, <<"">>}                :: {binary(), binary()} | '$2',
         id = <<>>                            :: binary() | '_',
         timestamp = now()                    :: erlang:timestamp() | '_' | '$1',
         peer = {<<"">>, <<"">>, <<"">>}      :: ljid() | '_' | '$3',
         bare_peer = {<<"">>, <<"">>, <<"">>} :: ljid() | '_' | '$3',
         packet = #xmlel{}                    :: xmlel() | '_',
         nick = <<"">>                        :: binary(),
         type = chat                          :: chat | groupchat}).

-record(archive_prefs,
        {us = {<<"">>, <<"">>} :: {binary(), binary()},
         default = never       :: never | always | roster,
         always = []           :: [ljid()],
         never = []            :: [ljid()]}).

-record(html_msg,
       {type = text            :: text | action | join | leave | kick | ban | nick | subject | none,
        nick = <<"">>          :: binary(),
        text = <<"">>          :: binary(),
        timestamp = calendar:local_time() :: calendar:datetime(),
        ms   = 0               :: 0..999999 }).

-define(CT_HTML,
        {<<"Content-Type">>, <<"text/html; charset=utf-8">>}).
-define(HEADER, [?CT_HTML]).
-define(OK(Data), {200, ?HEADER, Data}).
-define(BAD_REQUEST, {400, ?HEADER, #xmlel{name = <<"h1">>,
                 children = [{xmlcdata,<<"400 Bad Request">>}]}}).
-define(ACC_DENIED, {403, ?HEADER, #xmlel{name = <<"h1">>,
                 children = [{xmlcdata,<<"403 Access Denied">>}]}}).
-define(NOT_FOUND, {404, ?HEADER, #xmlel{name = <<"h1">>,
                 children = [{xmlcdata,<<"404 Not Found">>}]}}).
-define(SERVER_ERROR, {503, ?HEADER, #xmlel{name = <<"h1">>,
                 children = [{xmlcdata,<<"503 Internal Server Error">>}]}}).

