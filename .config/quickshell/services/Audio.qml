pragma Singleton
pragma ComponentBehavior: Bound

// import Quickshell.Io
import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import qs.config
import qs.utils

Singleton {
  id: root

  property bool ready: Pipewire.defaultAudioSink?.ready ?? false
  property PwNode sink: Pipewire.defaultAudioSink
  property PwNode source: Pipewire.defaultAudioSource

  PwObjectTracker {
    objects: [root.sink, root.source]
  }

  readonly property var preppedOutputs: ready ? 
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

  readonly property var options: [
    {
      id: 3,
      args: ["mute-output"],
      description: "Toggle Default Output Sink",
      icon: "audio-volume-muted",
      name: "Mute output",
      script: ["~/scripts/switch-audio.sh", "mute-output"]
    },
    {
      id: 4,
      description: "Mute Default Input Sink",
      icon: "microphone-sensitivity-muted",
      name: "Mute input",
      script: ["~/scripts/switch-audio.sh", "mute-input"]
    }
  ]
}
