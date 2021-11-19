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

## PREFIX-key

Default: ‘C-b’ (Ctrl-b)

## tmux resurrect

* CTRL-s : save sessions

* CTRL-r : restore sessions

## Session

* :new :[-s sessionname]
* :attach-session [-t session]
* s   : switch session
* $   : rename session
* d   : detach session
* :kill-session -a [-t <session>] kill all sessions but mine
* :kill-session -t <session> kill session
* (   : move to previous session
* )   : move to next tsession

## Window

* c   : create a window
* w   : switch windows in list
* 1-9 : switch window by #
* ,   : rename a window
* &   : end (kill) window
* p   : move to previous window
* n   : move to next window


## Pane

* %   : vertical split
* "   : horizontal split
* q   : show pane numbers
* q 0...9 : switch pane by number
* :   : toggle last pane
* +   : (toggle) convert panes into windows
* -   : (toggle) restore panes into windows
* x   : kill pane
* o   : toggle
* !   : break the pane out of the window
* {   : move current pane left
* }   : move current pane right
* <arrow>: switch up/down/left/right
* ctrl-<arrow>: resize

# How to copy & paste

## Direct interaction with system clipboard (not pane-aware)

Hold the SHIFT key while clicking mouse.

## Pane-aware copy (to both system clipboard and tmux buffer)

* Keyboard: PREFIX [ to start, [vimove], v, [vimove], y to copy

* Mouse : drag, y to copy

## Paste from tmux buffer

* Keyboard: PREFIX p

## Paste from system clipboard

* You may need to hold SHIFT to bypass tmux's own mouse mode

## Other notes

* X11 forwarding needs to be enabled for xclip/xsel to work across local and 
  remote machines [](https://stackoverflow.com/questions/19589844/set-up-x11-forwarding-over-ssh)

  * On remote machine: edit /etc/ssh/sshd_config and restart sshd

  * On local machine: DISPLAY=localhost:0.0 ssh -Y <servername>

* It may take many seconds for xsel to populate the copied content to local 
  machine (via X11 forwarding), so you may have to wait a few seconds beween 
  copy (y) and paste from local system clipboard

# How to change deault shell

```bash
# add following to .tmux.conf
set -g default-shell /bin/bash
set -g default-command /bin/bash
```

# Other notes on tmux

* `bind-key` is an alias of `bind`

* List all bind keys
```bash
tmux list-keys
```
* Change key bind

bind-key -T TABLE # Where TABLE can be prefix, copy-mode-vi, etc

* copy-mode-vi vs copy-mode (emac?)

* Copy to system clipboard

Example configuration (done in .tmux.conf)
```bash
bind-key    -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel -i -b"
```

