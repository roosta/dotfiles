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
  property list<var> audioData: {
    return PipewireData.ready ?
    Config.outputs.map(a => ({ name: Fuzzy.prepare(a.name), entry: a })) :
    []
  }

  property list<var> displayData: {
    return Config.displayLayouts.map(a => {
      return  {
        name: Fuzzy.prepare(a.name),
        entry: a
      }
    })
  }

  property list<var> powerData: {
    return Config.powerScripts.map(a => {
      return  {
        name: Fuzzy.prepare(a.name),
        entry: a
      }
    })
  }

  property list<var> menuData: Config.launcherMenus.map(a => {
    return  {
      name: Fuzzy.prepare(a.name),
      entry: a
    }
  })

  property list<var> utilsData: Config.utilities.map(a => {
    return {
      name: Fuzzy.prepare(a.name),
      entry: a
    }
  })

  property list<var> appsData: {
    let entries = Array.from(DesktopEntries.applications.values) ?? [];

    const favs = Config.favorites
      .map(id => entries.find(a => a.id === id))
      .filter(a => a !== undefined);

    const rest = entries
      .filter(a => !Config.favorites.includes(a.id))
      .sort((a, b) => a.name.localeCompare(b.name));

    return [...favs, ...rest].map(a => ({
      name: Fuzzy.prepare(a.name),
      entry: a,
    }));
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
      const wdir = entry.workingDirectory
      const obj = { command: entry.command, }
      if (wdir) { obj.workingDirectory = wdir }
      Quickshell.execDetached(obj);
    }
  }
}

