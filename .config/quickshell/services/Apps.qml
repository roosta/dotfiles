pragma Singleton
import Quickshell
import QtQuick
import qs.utils
import qs.config
import qs.services

Singleton {
  id: root

  property var aliases
  property var icons

  icons: {
    "missing": "image-missing",
    "workspace": "workspace-switcher-top-left"
  }

  // icon aliases, if a class/appid matches key, use value
  // in cases where there isn't a good icon match
  aliases: {
    "spotify-launcher": "spotify",
    "kando": "input-mouse"
  }
  function getAliasIcon(id) {
    const match = Object.entries(root.aliases)
    .find(([k, v]) => k.includes(id.toLowerCase()))
    return match?.[1]
  }

  // Choose the class with the most occurrences
  function mostOccuringClass(arr) {
    return arr.sort((a,b) => 
    arr.filter(v => v===a).length - arr.filter(v => v===b).length).pop();
  }

  function getIcon(k) {
    const icon = root.icons[k]
    return Quickshell.iconPath(icon, root.icons.missing)
  }

  function getEntryIcon(entry) {
    const icon = getAliasIcon(entry.id) ?? entry?.icon
    return Quickshell.iconPath(icon, root.icons.missing)
  }

  function getWindowIcon(appId) {
    const icon = getAliasIcon(appId) ?? DesktopEntries.heuristicLookup(appId)?.icon
    return Quickshell.iconPath(icon, root.icons.missing)
  }


  // Returns a collection of icons in a given workspace (wsid)
  // Removes duplicates, and applies aliases if present
  function getWsIcons(wsid: int): var {
    const classes = HyprlandData.windowList.filter(w => {
      return w.workspace.id === wsid
    }).map(w => w?.class)
    const uniq = [...new Set(classes)]
    const icons = uniq.map(id => {
      const alias = getAliasIcon(id)
      return getAliasIcon(id) ?? DesktopEntries.heuristicLookup(id)?.icon
    })
    return icons.map(icon => Quickshell.iconPath(icon, root.icons.missing))
  }
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

  function getEntry(id) {
    return DesktopEntries.byId(id)
  }

  function launch(entry: DesktopEntry) {
    if (entry.runInTerminal)
    Quickshell.execDetached({
      command: [Config.terminal, ...entry.command],
      workingDirectory: entry.workingDirectory
    });
    else
    Quickshell.execDetached({
      command: entry.command,
      workingDirectory: entry.workingDirectory
    });
  }
}
