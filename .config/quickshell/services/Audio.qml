pragma Singleton
pragma ComponentBehavior: Bound

// import Quickshell.Io
import Quickshell
import QtQuick
import qs.config
import qs.services
import qs.utils

Singleton {
  id: root

  readonly property var preppedOutputs: PipewireData.ready ? 
    Config.outputs.map(a => ({ name: Fuzzy.prepare(`${a.name} `), entry: a })) : 
    []

  function fuzzyQuery(search: string): var {
    return Fuzzy.go(search, preppedOutputs, {
      all: true,
      key: "name"
    }).map(r => {
      return r.obj.entry
    });
  }

}
