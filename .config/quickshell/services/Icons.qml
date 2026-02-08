pragma Singleton
import Quickshell
import qs.services
import qs.config

Singleton {
  id: root
  readonly property var icons: {
    "missing": "image-missing",
  }

  // Get an alias for input id (usually class/appid)
  function getAlias(id) {
    for (const [re, repl] of Config.aliases) {
      if (re.test(id)) {
        return id.replace(re, repl);
      }
    }
    return null;
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
    const icon = getAlias(entry.id) ?? entry?.icon
    return Quickshell.iconPath(icon, root.icons.missing)
  }

  function lookupIcon(appId: string): string {
    const icon = getAlias(appId) ?? getEntry(appId)?.icon
    return Quickshell.iconPath(icon, root.icons.missing)
  }


  // Returns a collection of icons in a given workspace (wsid)
  // Removes duplicates, and applies aliases if present
  function getWsIcons(wsid: int): var {
    const classes = HyprlandData.windowList.filter(w => {
      return w.workspace.id === wsid
    }).map(w => w?.class)
    const uniq = [...new Set(classes)].sort((a, b) => a.localeCompare(b))
    return uniq.map(id => {
      const icon = getAlias(id) ?? DesktopEntries.heuristicLookup(id)?.icon
      return {
        icon: Quickshell.iconPath(icon, root.icons.missing),
        class: id
      }
    })
  }

}
