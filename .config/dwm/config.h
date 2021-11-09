#include <X11/XF86keysym.h>
#include "tcl.c"
#include "gaplessgrid.c"

/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 20;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;   	/* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 0;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 0;     /* 0 means no systray */
static const unsigned int gappih    = 10;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 10;       /* vert inner gap between windows */
static const unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 10;       /* vert outer gap between windows and screen edge */
static const int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const Bool viewontag         = True;     /* Switch view on tag switch */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:style:medium:size=10",
                                        "Material Design Icons-Regular:size=10",
                                      };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#1e222a";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#ffffff";
/*原颜色 #37474F*/
static const char col_cyan[]        = "#37474F";
static const char col_border[]        = "#caf6bb";
static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;


static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_border  },
	[SchemeHid]  = { col_cyan,  col_gray1, col_border  },
};
static const unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { "一", "二", "三", "四", "五", "六", "七", "八", "九" };
//static const char *tags[] = { "\ue795", "\uf61a", "\ue7b5", "\uf194", "\uf113", "\ue7a1", "\ufc58", "\ufb7e", "\uf27a" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Android Emulator", NULL,       NULL,       0,            1,           -1 },
	{ "Emulator", NULL,       NULL,       0,            1,           -1 },
	{ "quemu-system-i386", NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "Kael",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
  { "|||",      tcl },
  { "###",      gaplessgrid },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL }; 
static const char *termcmd[]  = { "st", NULL };
static const char *firefox[]  = { "firefox", NULL };

static const char *upvol[]   = { "/home/kael/scripts/vol-up.sh",  NULL };
static const char *downvol[] = { "/home/kael/scripts/vol-down.sh",  NULL };
static const char *mutevol[] = { "/home/kael/scripts/vol-toggle.sh",  NULL };

static const char *wpcmd[]  = { "/home/kael/scripts/wp-change.sh", NULL };
static const char *sktogglecmd[]  = { "/home/kael/scripts/sck-tog.sh", NULL };
static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "120x40", NULL };

static const char *setcolemakcmd[]  = { "/home/kael/scripts/setxmodmap-colemak.sh", NULL };

static const char *screenshotcmd[] = { "flameshot", "gui", NULL };

static const char *lockTool[] = { "/home/kael/scripts/lock.sh", NULL};
static const char *rofi[] = { "rofi", "-show", "drun", NULL };
static const char *tmuxSessions[] = { "/home/kael/.config/rofi/scripts/tmux/tmux_session.sh", NULL };
static const char *sshClient[] = { "/home/kael/.config/rofi/scripts/so/so.sh", NULL };
static const char *gpick[] = { "gpick", NULL };
static const char *todo[] = { "todo", "-v", NULL };
static const char *ranger[] = { "st", "ranger", NULL };
static const char *trans[] = { "/home/kael/scripts/trans.sh", NULL };
static const char *files[] = { "/home/kael/scripts/z_file.sh", NULL };
static const char *calendar[] = { "/home/kael/scripts/calendar.sh", NULL };

static Key keys[] = {
	/* modifier            key                      function        argument */
	{ MODKEY,              XK_d,                    spawn,          {.v = gpick } },
	{ MODKEY|ShiftMask,    XK_r,                    spawn,          {.v = ranger } },
	{ MODKEY,              XK_r,                    spawn,          {.v = rofi } },
	{ MODKEY,              XK_Return,               spawn,          {.v = termcmd } },
	{ MODKEY,              XK_c,                    spawn,          {.v = firefox } },
	{ MODKEY,              XK_e,                    spawn,          {.v = files } },
	{ MODKEY,              XK_y,                    spawn,          {.v = calendar } },
	{ MODKEY|ShiftMask,    XK_t,                    spawn,          {.v = tmuxSessions} },
	{ MODKEY|ShiftMask,    XK_m,                    spawn,          {.v = setcolemakcmd } },
	{ MODKEY|ShiftMask,    XK_s,                    spawn,          {.v = lockTool } },
	{ MODKEY,              XK_p,                    togglescratch,  {.v = scratchpadcmd } },
	{ MODKEY|ControlMask,  XK_s,                    spawn,          {.v = sktogglecmd } },
	{ ControlMask|ShiftMask,XK_0,                    spawn,         {.v = trans } },
	{ 0,                   XF86XK_AudioLowerVolume, spawn,          {.v = downvol } },
	{ 0,                   XF86XK_AudioMute,        spawn,          {.v = mutevol } },
	{ 0,                   XF86XK_AudioRaiseVolume, spawn,          {.v = upvol   } },
	{ MODKEY,              XK_bracketleft,          spawn,          {.v = downvol } },
	{ MODKEY,              XK_backslash,            spawn,          {.v = mutevol } },
	{ MODKEY,              XK_bracketright,         spawn,          {.v = upvol   } },
/*	{ MODKEY,              XK_b,                    spawn,          {.v = wpcmd } },*/
	{ MODKEY,              XK_b,                    spawn,          {.v = sshClient   } },
	{ MODKEY,              XK_a,                    spawn,          {.v = screenshotcmd } },
	{ MODKEY,              XK_w,                    spawn,          {.v = todo } },
	{ MODKEY|ShiftMask,    XK_l,                    rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,    XK_h,                    rotatestack,    {.i = -1 } },
	{ MODKEY,              XK_l,                    focusstackvis,  {.i = +1 } },
	{ MODKEY,              XK_h,                    focusstackvis,  {.i = -1 } },
	{ MODKEY,              XK_n,                    viewtoleft,     {0} },
	{ MODKEY,              XK_i,                    viewtoright,    {0} },
	{ MODKEY|ShiftMask,    XK_n,                    tagtoleft,      {0} },
	{ MODKEY|ShiftMask,    XK_i,                    tagtoright,     {0} },
	{ MODKEY|ShiftMask,    XK_q,                    incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,    XK_p,                    incnmaster,     {.i = -1 } },
	{ MODKEY|ControlMask,  XK_h,                    setmfact,       {.f = -0.05} },
	{ MODKEY|ControlMask,  XK_l,                    setmfact,       {.f = +0.05} },
	{ MODKEY,              XK_v,                    hide,           {0} },
	{ MODKEY|ShiftMask,    XK_v,                    show,           {0} },
	{ MODKEY,              XK_o,                    hideotherwins,  {0}},
	{ MODKEY|ShiftMask,    XK_o,                    restoreotherwins, {0}},
	{ MODKEY|ShiftMask,    XK_Return,               zoom,           {0} },
	{ MODKEY,              XK_Tab,                  view,           {0} },
	{ MODKEY,              XK_q,                    killclient,     {0} },
	{ MODKEY,              XK_t,                    setlayout,      {.v = &layouts[0]} },
	{ MODKEY,              XK_m,                    setlayout,      {.v = &layouts[2]} },
	{ MODKEY|ControlMask|ShiftMask,    XK_t,        setlayout,      {.v = &layouts[3]} },
	{ MODKEY,              XK_g,                    setlayout,      {.v = &layouts[4]} },
	{ MODKEY|ShiftMask,    XK_f,                    fullscreen,     {0} },
	{ MODKEY,              XK_space,                setlayout,      {0} },
	{ MODKEY|ShiftMask,    XK_space,                togglefloating, {0} },
	{ MODKEY,              XK_apostrophe,           togglescratch,  {.v = scratchpadcmd } },
	{ MODKEY,              XK_0,                    view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,    XK_0,                    tag,            {.ui = ~0 } },
	{ MODKEY,              XK_comma,                focusmon,       {.i = -1 } },
	{ MODKEY,              XK_period,               focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,    XK_comma,                tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,    XK_period,               tagmon,         {.i = +1 } },
  { MODKEY|ControlMask,  XK_q,                    quit,           {0} },
	TAGKEYS(               XK_1,                      0)
	TAGKEYS(               XK_2,                      1)
	TAGKEYS(               XK_3,                      2)
	TAGKEYS(               XK_4,                      3)
	TAGKEYS(               XK_5,                      4)
	TAGKEYS(               XK_6,                      5)
	TAGKEYS(               XK_7,                      6)
	TAGKEYS(               XK_8,                      7)
	TAGKEYS(               XK_9,                      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

