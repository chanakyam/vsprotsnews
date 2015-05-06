-module(vsportsnews_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_',[
                {"/", home_page_handler, []},
            	{"/morenews", all_news_handler, []},
                {"/morevideos", all_videos_handler, []},
                {"/playvideo/:id", play_video_handler, []},
            	{"/api/news/count", news_count_handler, []},
                {"/about", about_page_handler, []},
                {"/termsandconditions", tnc_page_handler, []},
                {"/api/slideshows/channel", channel_slideshow_handler, []},
                {"/api/slideshows/:id", document_handler, []},
                {"/show/:id", single_slideshow_handler, []},               
                %%
                %% Release Routes
                %%
                {"/css/[...]", cowboy_static, {priv_dir, vsportsnews, "static/css"}},
                {"/images/[...]", cowboy_static, {priv_dir, vsportsnews, "static/images"}},
                {"/js/[...]", cowboy_static, {priv_dir, vsportsnews, "static/js"}},
				{"/fonts/[...]", cowboy_static, {priv_dir, vsportsnews, "static/fonts"}}
				%%
				%% Dev Routes
				%%
				% {"/css/[...]", cowboy_static, {dir, "priv/static/css"}},
    %             {"/images/[...]", cowboy_static, {dir, "priv/static/images"}},
    %             {"/js/[...]", cowboy_static, {dir,"priv/static/js"}},
				% {"/fonts/[...]", cowboy_static, {dir, "priv/static/fonts"}}
        ]}		
	]),    

	{ok, _} = cowboy:start_http(http,100, [{port, 11003}],[{env, [{dispatch, Dispatch}]}
              ]),
    vsportsnews_sup:start_link().

stop(_State) ->
    ok.
