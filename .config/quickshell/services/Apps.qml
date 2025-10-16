pragma Singleton
import Quickshell
import QtQuick
import qs.utils
import qs.config
import qs.services

Singleton {
  id: root

  readonly property bool ready: DesktopEntries.applications.values.length > 0

  readonly property list<DesktopEntry> list: ready ? 
    Array.from(DesktopEntries.applications.values).sort((a, b) => a.name.localeCompare(b.name)) : 
    []

  readonly property var preppedNames: ready ? 
    list.map(a => ({ name: Fuzzy.prepare(`${a.name} `), entry: a })) : 
    []

  readonly property var icons: {
    "missing": "image-missing",
    "workspace": "workspace-switcher-top-left"
  }

  // Choose the class with the most occurrences
  function mostOccuringClass(arr: var): var {
    return arr.sort((a,b) => 
    arr.filter(v => v===a).length - arr.filter(v => v===b).length).pop();
  }

  // 
  function getIcon(key: string): string {
    const icon = root.icons[key]
    return Quickshell.iconPath(icon, root.icons.missing)
  }

  function getEntryIcon(entry: DesktopEntry): string {
    const icon = Config.getAlias(entry.id) ?? entry?.icon
    return Quickshell.iconPath(icon, root.icons.missing)
  }

  function lookupIcon(appId: string): string {
    const icon = Config.getAlias(appId) ?? getEntry(appId)?.icon
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
      const alias = Config.getAlias(id)
      return Config.getAlias(id) ?? DesktopEntries.heuristicLookup(id)?.icon
    })
    return icons.map(icon => Quickshell.iconPath(icon, root.icons.missing))
  }

  function fuzzyQuery(search: string): var { // Idk why list<DesktopEntry> doesn't work
    return Fuzzy.go(search, preppedNames, {
      all: true,
      key: "name"
    }).map(r => {
      return r.obj.entry
    });
  }


  function getEntry(id: string): DesktopEntry {
    return DesktopEntries.heuristicLookup(id)
  }

  function launch(entry: DesktopEntry): void {
    if (entry.runInTerminal) {
      Quickshell.execDetached({
        command: [Config.terminal, ...entry.command],
        workingDirectory: entry.workingDirectory
      });
    } else {
      Quickshell.execDetached({
        command: entry.command,
        workingDirectory: entry.workingDirectory
      });
    }
  }
}
