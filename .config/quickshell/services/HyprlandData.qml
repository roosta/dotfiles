// GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
// Based on https://github.com/end-4/dots-hyprland/blob/703697e1c40b66619fb224043891aade47494bb3/.config/quickshell/ii/services/HyprlandData.qml
// Modified 2025 by Daniel Berg <mail@roosta.sh>
pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.utils

/**
 * Provides access to some Hyprland data not available in Quickshell.Hyprland.
 */
Singleton {
  id: root
  property var windowList: []
  property var addresses: []
  property var windowByAddress: ({})
  property var workspaces: []
  property var workspaceIds: []
  property var workspaceById: ({})
  property var workspacesByMonitor: ({})
  property var activeWorkspace: null
  property var monitors: []
  property var layers: ({})


  /**
   * Urgent windows 
   */
  property var urgentWindows: []
  property var activeTopLevel: Hyprland.activeToplevel?.lastIpcObject


  function clearUrgentByClass(c) {
    root.urgentWindows = root.urgentWindows.filter(win => {
      return win.class !== c
    })
  }
  
  onActiveTopLevelChanged: {
    // console.log(JSON.stringify(urgentWindows, null, 2))
    if (urgentWindows.some(w => w.address === activeTopLevel.address)) {
      clearUrgentByClass(activeTopLevel.class)
    }
  }

  function updateWindowList() {
    getClients.running = true;
  }

  function updateLayers() {
    getLayers.running = true;
  }

  function updateMonitors() {
    getMonitors.running = true;
  }

  function updateWorkspaces() {
    getWorkspaces.running = true;
    getActiveWorkspace.running = true;
  }

  function updateAll() {
    updateWindowList();
    updateMonitors();
    updateLayers();
    updateWorkspaces();
  }

  Component.onCompleted: {
    updateAll();
  }
  Connections {
    target: Hyprland

    function onRawEvent(event) {
      // console.log("Hyprland raw event:", event.name);
      root.updateAll()
      if (event.name === "urgent") {
        const win = root.windowList.find(w => w.address === `0x${event.data}`)
        if (win) {
          root.urgentWindows = [
            ...root.urgentWindows,
            win
          ]
        }
      }
    }
  }

  Process {
    id: getClients
    command: ["hyprctl", "clients", "-j"]
    stdout: StdioCollector {
      id: clientsCollector
      onStreamFinished: {
        if (clientsCollector?.text) {
          root.windowList = JSON.parse(clientsCollector.text)
          let tempWinByAddress = {};
          for (var i = 0; i < root.windowList.length; ++i) {
            var win = root.windowList[i];
            tempWinByAddress[win.address] = win;
          }
          root.windowByAddress = tempWinByAddress;
          root.addresses = root.windowList.map(win => win.address);
        }
      }
    }
  }

  Process {
    id: getMonitors
    command: ["hyprctl", "monitors", "-j"]
    stdout: StdioCollector {
      id: monitorsCollector
      onStreamFinished: {
        if (monitorsCollector?.text) {
          root.monitors = JSON.parse(monitorsCollector.text);
        }
      }
    }
  }

  Process {
    id: getLayers
    command: ["hyprctl", "layers", "-j"]
    stdout: StdioCollector {
      id: layersCollector
      onStreamFinished: {
        if (layersCollector?.text) {
          root.layers = JSON.parse(layersCollector.text);
        }
      }
    }
  }

  Process {
    id: getWorkspaces
    command: ["hyprctl", "workspaces", "-j"]
    stdout: StdioCollector {
      id: workspacesCollector
      onStreamFinished: {
        if (workspacesCollector?.text) {
          const workspaces = JSON.parse(workspacesCollector.text)
          .sort((a, b) => a.id - b.id);
          root.workspaces = workspaces
          root.workspacesByMonitor = Functions.groupBy(workspaces, x => x.monitor)
          let byId = {};
          for (var i = 0; i < root.workspaces.length; ++i) {
            var ws = root.workspaces[i];
            byId[ws.id] = ws;
          }
          root.workspaceById = byId
          root.workspaceIds = root.workspaces.map(ws => ws.id);
        }
      }
    }
  }

  Process {
    id: getActiveWorkspace
    command: ["hyprctl", "activeworkspace", "-j"]
    stdout: StdioCollector {
      id: activeWorkspaceCollector
      onStreamFinished: {
        if (activeWorkspaceCollector?.text) {
          root.activeWorkspace = JSON.parse(activeWorkspaceCollector.text);
        }
      }
    }
  }
}
