pragma Singleton

import Quickshell.Io
import Quickshell
import QtQuick

import qs.services

Singleton {
  id: root
  property QtObject icons
  property var aliases

  icons: QtObject {
    property string missing: "image-missing"
    property string workspace: "workspace-switcher-top-left"
  }

  // icon aliases, if a class/appid matches key, use value
  // in cases where there isn't a good icon match
  aliases: {
    "spotify-launcher": "spotify"
  }
  function getAliasIcon(id) {
    const match = Object.entries(root.aliases)
    .find(([k, v]) => k.includes(id.toLowerCase()))
    return match?.[1]
  }

  // Choose the class with the most occurrences
  function mostOccuringClass(arr){
    return arr.sort((a,b) => 
      arr.filter(v => v===a).length - arr.filter(v => v===b).length).pop();
  }

  function getIcon(k) {
    const icon = root.icons[k]
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
}
