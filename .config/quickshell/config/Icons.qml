pragma Singleton

import Quickshell
import QtQuick

import qs.services

Singleton {
  id: root
  readonly property string defaultIcon: "image-missing"

  // Choose the class with the most occurrences
  function _primaryClass(arr){
    return arr.sort((a,b) => 
      arr.filter(v => v===a).length - arr.filter(v => v===b).length).pop();
  }
  function getAppIcons(ws: int): var {
    const classes = [
      ...new Set(
        Hyprland.toplevels.values
        .filter(c => c.workspace?.id === ws)
        .map(c => c.lastIpcObject.class)
      )
    ];
    const icons = classes.map(i => DesktopEntries.heuristicLookup(i)?.icon)
    return icons.map(i => Quickshell.iconPath(i, root.defaultIcon))
  }
}
