pragma Singleton

import Quickshell
import QtQuick

import qs.services

Singleton {
  id: root
  readonly property string defaultIcon: "image-missing"

  // Choose the class with the most occurrences
  function mostOccuringClass(arr){
    return arr.sort((a,b) => 
      arr.filter(v => v===a).length - arr.filter(v => v===b).length).pop();
  }
  function getAppIcons(wsid: int): var {
    const classes = HyprlandData.windowList.filter(w => {
      return w.workspace.id == wsid
    }).map(w => w?.class)
    const uniq = [...new Set(classes)]
    const icons = uniq.map(i => DesktopEntries.heuristicLookup(i)?.icon)
    return icons.map(i => Quickshell.iconPath(i, root.defaultIcon))
  }
}
