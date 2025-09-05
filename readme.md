# Install

Make sure to login and clone with ssh or you'll need to change the remote-url to the ssh one to push later.

# New Computer Setup

## Mac Settings

1. Keyboard
    * Customize modifier keys: Caps -> Esc
    * Key Repeat - Minimize Delay
2. Desktop Dock Settings
    * Auto Hide - On
    * Magnification - Off
    * Animate Opening Applications - Off
    * Arrange Spaces - Off
    * Group Windows By App - On
3. Mouse Trackpad Settings
    * Natural Scrolling - Off
    * Spring Loading - Off
    * Pointer Acceleration - Off

## Software Installs

* Chrome - Set as Default Browser

### Dev Tools

*By having cloned this repo you should already have the dev tools installed, but that can take a while.
If that hasn't been kicked off initiate that process before proceeding to the actual setup.*

First, run the setup file: 
`zsh setup.sh`

*If you run into issues with `brew` not installing via the script due to user input not being captured, then do that manually.*

After running these, you should be able to start tmux and vim with the proper configurations using the shell command *ts* 


## Github

### SSH

At this stage you can setup Github SSH by following [these instructions](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

### Config

You will also need to set your global configs:

```
git config --global user.name "Connor Jerow"
git config --global user.email cgjerow@gmail.com
```
