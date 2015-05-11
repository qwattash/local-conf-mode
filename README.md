# local-conf-mode
Local configuration loader for emacs.
The minor mode attempts to load local file for every
buffer opened in a git repo.
Other vcs may be supported as well in the future.

# Installation
Just enable the mode in your .emacs or wherever you prefer
```elisp
(globalized-local-conf-mode t)
```
Or enable it from the buffer
```
M-x local-conf-mode
```
# Usage
Create a file named emacs-local.el in the root of your git repo
and add your local project definitions there.
This was designed to add project-related skeletons and templates.

# Customize
You can customize the name of the file:
```elisp
(custom-set-variables
  '(local-conf-mode-file "my_file_name.el"))
```

