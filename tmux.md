## What is tmux?
Tmux is a tool, combining the features of a terminal multiplexer and a window manager.
As a terminal multiplexer, it can open multiple command line prompts.
As a windows manager, it can organize multiple command line prompts 
as windows. Windows can also be split vertically and horizontally. 

## Tmux features
tmux is executed as background process. 
Typical scenario with tmux that shows its major features:
When the one is logged in with SSH, 
one starts a tmux process (session) and gets attached to tmux session.
In tmux command prompt, you execute long-during processes and then detach from tmux
session and log out from ssh, and  tmux child processes (copying backup, torrent exchange) are not terminated.

As necessary, you re-login with ssh and attach to your tmux session again and so you get back to 
your working context that you left.

## Advantages of tmux
An advantage over doing the jobs directly in ssh are child tmux jobs staying resident when you detach from tmux. Contrary to working directly in ssh, as terminating ssh or disconnecting from ssh 
will terminate the child processes too.

## Working with tmux
First, install tmux and then start tmux session with following command:

```
$tmux new -s default

```

where *default* is session name. 
Attach to the session named *default* using the command:

```
$tmux attach -t default
```
More useful tmux commands:

```
$tmux list-sessions

```
## Manoevring in tmux 
In tmux you're using a default prefix <Ctrl + b>
to type a command to trigger tmux action.

### Useful tmux commands
* CTRL + b, then c - Create new window.
* CTRL + b, then , - Rename window.
* CTRL + b, then n - Move to the next window.
* CTRL + b, then p - Move to the previous window.
* CTRL + b, then & - Kill current window.
* CTRL + b, then % - Split current pane into two (vertically).
* CTRL + b, then " - Split current pane into two (horizontally).
* CTRL + b, then o - Switch to next pane.
* CTRL + b, then q - Show pane numbers (then type a # to switch to it).
* CTRL + b, then d - Detach from current session.
* CTRL + b, then ? - List all key bindings. 

### Useful session commands
* $tmux list-sessions - List existing tmux sessions.
* $tmux new -s session-name - Create a new tmux session named session-name.
* $tmux attach -t session-name - Connect to an existing tmux session named session-name.
* $tmux switch -t session-name - Switches to an existing tmux session named session-name.


## Tmux best practice
When working with remote systems via SSH, it is safe practice to use tmux. It prevents you from losing your running processes and jobs when your ssh connection is suddenly dropped.
You can autostart tmux session when logging in to via ssh. You will need to add a scriptlet to your [~./bashrc](scripts/.baschrc) file (open the example file by link).

## Conclusion
Tmux is sure to increase your productivity when managing your administrative jobs.

