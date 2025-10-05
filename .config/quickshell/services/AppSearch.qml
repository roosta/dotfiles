// GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
// Based on https://github.com/end-4/dots-hyprland/blob/21d6bcc63e9a969986950c3b869ed9a4866a11e7/.config/quickshell/ii/services/AppSearch.qml
// Modified 2025 by Daniel Berg <mail@roosta.sh>

pragma Singleton
import Quickshell
import qs.utils

Singleton {
  id: root
  readonly property list<DesktopEntry> list: Array.from(DesktopEntries.applications.values)
  .sort((a, b) => a.name.localeCompare(b.name))

  readonly property var preppedNames: list.map(a => ({
    name: Fuzzy.prepare(`${a.name} `),
    entry: a
  }))

  function fuzzyQuery(search: string): var { // Idk why list<DesktopEntry> doesn't work
    return Fuzzy.go(search, preppedNames, {
      all: true,
      key: "name"
    }).map(r => {
      return r.obj.entry
    });
  }
}
