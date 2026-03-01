This grimoire is meant to keep all of my coding environment in one place.

You will need [witchesbrew](https://github.com/globz/witchesbrew) in order to use it.


==TODO==

- [ ] tempel ~ https://github.com/minad/tempel
- [ ] eglot-tempel ~ https://github.com/fejfighter/eglot-tempel
- [ ] Lisp [SBCL]
- [ ] Python + LS
- [ ] HTML language server ~ https://github.com/hrsh7th/vscode-langservers-extracted
- [x] Upgrade asdf install script to version 18.0 ~ https://asdf-vm.com/guide/upgrading-to-v0-16
+ [ ] Document /etc/apparmor.d/bwrap for bubblewrap sandboxing
# This profile allows everything and only exists to give the
# application a name instead of having the label "unconfined"
abi <abi/4.0>,
include <tunables/global>

profile bwrap /usr/bin/bwrap flags=(unconfined) {
  userns,

  # Site-specific additions and overrides. See local/README for details.
  include if exists <local/bwrap>
}
