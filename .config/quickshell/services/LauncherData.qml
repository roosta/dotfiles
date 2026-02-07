pragma Singleton
pragma ComponentBehavior: Bound

pragma Singleton
import Quickshell
import qs.services
import qs.config
import qs.utils

// import Quickshell.Io
// import QtQuick
// import qs.utils

Singleton {
  id: root
  property var audioData: {
    return PipewireData.ready ?
    Config.outputs.map(a => ({ name: Fuzzy.prepare(`${a.name} `), entry: a })) :
    []
  }

  property var displayData: {
    return Config.displayLayouts.map(a => {
      return  {
        name: Fuzzy.prepare(`${a.name} `),
        entry: a
      }
    })
  }

  property var powerData: {
    return Config.powerScripts.map(a => {
      return  {
        name: Fuzzy.prepare(`${a.name} `),
        entry: a
      }
    })
  }

  property var menuData: Config.modeMenu.map(a => {
    return  {
      name: Fuzzy.prepare(`${a.name} `),
      entry: a
    }
  })

  property var utilsData: Config.utilities.map(a => {
    return {
      name: Fuzzy.prepare(`${a.name} `),
      entry: a
    }
  })

  property var appsData: {
    let entries = DesktopEntries.applications.values ?? [];
    const list = Array.from(entries).map(a => {
      return {
        name: Fuzzy.prepare(`${a.name} `),
        entry: a,
      }
    })
    return list.sort(compareApps)
  }

  // Sort comparator, will sort favorites to the top of the list,
  // and sorted as they appear in the config array
  function compareApps(a, b) {
    const aFav = Config.favorites.includes(a.entry.id);
    const bFav = Config.favorites.includes(b.entry.id)

    if (aFav && bFav) {
      const aIndex = Config.favorites.indexOf(a.entry.id);
      const bIndex = Config.favorites.indexOf(b.entry.id);
      return aIndex - bIndex;
    }
    if (aFav && !bFav) return -1;
    if (!aFav && bFav) return 1;
    return a.entry.name.localeCompare(b.entry.name);
  }

  function launch(entry) {
    if (entry.script) {
      Quickshell.execDetached({
        command: entry.script,
      });
    } else if (entry.runInTerminal) {
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

