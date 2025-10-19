pragma Singleton
pragma ComponentBehavior: Bound

// import Quickshell.Io
import Quickshell
import QtQuick
import qs.config
import qs.utils

Singleton {
  id: root

  readonly property var preppedLayouts: Config.displayLayouts.map(a => {
    return  {
      name: Fuzzy.prepare(`${a.name} `),
      entry: a
    }
  })

  function fuzzyQuery(search: string): var {
    return Fuzzy.go(search, preppedLayouts, {
      all: true,
      key: "name"
    }).map(r => {
      return r.obj.entry
    });
  }

}
