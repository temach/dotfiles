setup see: https://mitxela.com/projects/dotfiles_management


Starting with the basics, the repo needs to live somewhere, so we initialise a bare git repo in ~/.dotfiles. I named the default branch the same as this laptop's hostname (magma) with the vague idea that multiple machines can share the dotfiles repo with different branches. It may make sense to have a template branch, with most of the generic settings (like vimrc), and specific branches with machine-specific config, but that means a lot of merging between branches, which you may or may not have the patience for.

We make an alias:

alias dotfiles='git --git-dir=/home/mx/.dotfiles --work-tree=/'

Now typing dotfiles status or dotfiles log will show the status or log of the repo, regardless of if you're currently in another repo. Of course looking at the status will probably take forever as the work tree is /, so it will list every single file on the filesystem as untracked. There are a few ways to stop this, but I went with simply telling git not to show untracked files:

dotfiles config --local status.showUntrackedFiles no

The files are not ignored, you can just add them normally, but until then they won't be listed. This is 90% of the work done, you can now add some files, either local, in your home directory, or anywhere on the system, and commit them to the repo.

dotfiles add ~/.bashrc
dotfiles add /etc/udev/rules.d/70-ftdi.rules
dotfiles commit

