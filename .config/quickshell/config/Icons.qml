pragma Singleton

import Quickshell
import QtQuick

import qs.services

Singleton {
  id: root
  property QtObject icons

  icons: QtObject {
    property string missing: "image-missing"
    property string workspace: "workspace-switcher"
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
    const icon = DesktopEntries.heuristicLookup(appId)?.icon
    return Quickshell.iconPath(icon, root.icons.missing)
  }


  function getWsIcons(wsid: int): var {
    const classes = HyprlandData.windowList.filter(w => {
      return w.workspace.id === wsid
    }).map(w => w?.class)
    // console.log(classes)
    const uniq = [...new Set(classes)]
    const icons = uniq.map(i => DesktopEntries.heuristicLookup(i)?.icon)
    return icons.map(i => Quickshell.iconPath(i, root.icons.missing))
  }
}
