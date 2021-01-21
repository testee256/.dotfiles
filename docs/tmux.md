# Command line

```bash
* tmux new -s myname            # start new with session name
* tmux a [-t myname]            # attach
* tmux ls                       # list sessions
* tmux kill-session [-t myname] # kill a session
* tmux kill-server              # kill all
* tmux switch
```

# Shortcuts (CTRL-b *)

## tmux resurrect

* CTRL-s : save sessions

* CTRL-r : restore sessions

## Window

* c   : create window

* w   : list windows (and switch)

* ,   : rename window

* &   : kill window

## Session

* s   : switch session

* 1-9 : switch to window by #

* d   : detach session

* $   : rename session

## Pane

* %     : vertical split

* "     : horizontal split

* q     : show pane numbers

* +     : (toggle) convert panes into windows

* -     : (toggle) restore panes into windows

* x     : kill pane

* o     : toggle

* !     : break the pane out of the window

# How to copy & paste

* Keyboard: Ctrl-b [ to start, [vimove], v, [vimove], y to copy

* Mouse : drag, y to copy

# How to change deault shell

```bash
# add following to .tmux.conf
set -g default-shell /bin/bash
set -g default-command /bin/bash
```
