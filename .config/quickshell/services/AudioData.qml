// ┌────────────────────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▀█░▀█▀░█▀█░█▀▀░█░█░▀█▀░█▀▄░█▀▀░█▀▄░█▀█░▀█▀░█▀█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█▀▀░░█░░█▀▀░█▀▀░█▄█░░█░░█▀▄░█▀▀░█░█░█▀█░░█░░█▀█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀░░░▀▀▀░▀░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀░░▀░▀░░▀░░▀░▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>                               ├┤
// ││ Repo    : https://github.com/roosta/dotfiles                         ││
// ││ Site    : https://www.roosta.sh                                      ││
// ├┤ License : GNU General Public License v3                              ├┤
// ┆└──────────────────────────────────────────────────────────────────────┘┆

pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell.Io
import Quickshell
import QtQuick
import qs.utils
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

Singleton {
  id: root

  readonly property list<MprisPlayer> players: Mpris.players.values

  property bool ready: Pipewire.defaultAudioSink?.ready ?? false
  property PwNode sink: Pipewire.defaultAudioSink
  property PwNode source: Pipewire.defaultAudioSource

  readonly property var pwNodes: Pipewire.nodes.values
  property list<PwNode> streamNodes: pwNodes.filter(n => n.isStream)
  property list<PwNode> audioIn: streamNodes.filter(s => !s.isSink && s?.audio && s?.name !== "cava")
  property list<PwNode> audioOut: streamNodes.filter(s => s.isSink && s?.audio)

  property var bars: []

  PwObjectTracker {
    objects: [root.sink, root.source]
  }

  Process {
    id: cava
    command: ["cava", "-p", `${Paths.config}/cava/ritual.ini`]
    running: true

    stdout: SplitParser {
      splitMarker: "\n"
      onRead: data => {
        // data is like "42;78;13;99;50;..."
        root.bars = data.split(";")
        .filter(s => s.length > 0)
        .map(s => parseInt(s) / 100.0)
      }
    }
  }
}
