pragma Singleton
pragma ComponentBehavior: Bound

// import Quickshell.Io
import Quickshell
import QtQuick
import Quickshell.Services.Pipewire

Singleton {
  id: root

  property bool ready: Pipewire.defaultAudioSink?.ready ?? false
  property PwNode sink: Pipewire.defaultAudioSink
  property PwNode source: Pipewire.defaultAudioSource

  readonly property var pwNodes: Pipewire.nodes.values
  property list<PwNode> streamNodes: pwNodes.filter(n => n.isStream)
  property list<PwNode> audioIn: streamNodes.filter(s => !s.isSink && s?.audio)
  property list<PwNode> audioOut: streamNodes.filter(s => s.isSink && s?.audio)

  PwObjectTracker {
    objects: [root.sink, root.source]
  }
}
