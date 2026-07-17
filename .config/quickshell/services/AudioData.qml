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
// Description: Handles the singleton state for Pipewire, and helper
// functions for audio manipulation. Also handles cava visualizer data.

pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell.Io
import Quickshell
import QtQuick

// qmllint disable unused-imports
// Dont know why qmllint cant se is usage (Paths)
import qs.utils

import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire
import Quickshell.Hyprland

Singleton {
  id: root

  readonly property list<MprisPlayer> players: Mpris.players.values

  readonly property MprisPlayer activePlayer: players[0] ?? null

  property bool ready: Pipewire.defaultAudioSink?.ready ?? false
  property PwNode sink: Pipewire.defaultAudioSink
  property PwNode source: Pipewire.defaultAudioSource

  readonly property var pwNodes: Pipewire.nodes.values
  property list<PwNode> streamNodes: pwNodes.filter(n => n.isStream)
  property list<PwNode> audioIn: streamNodes.filter(s => !s.isSink && s?.audio && s?.name !== "cava")
  property list<PwNode> audioOut: streamNodes.filter(s => s.isSink && s?.audio)


  property real volume: sink?.audio.volume ?? 0
  property var bars: []

  PwObjectTracker {
    objects: [root.sink, root.source]
  }

  // https://github.com/end-4/dots-hyprland/blob/446504ad427297dcbe5ee4a3d5bda1c458207cd9/dots/.config/quickshell/ii/services/Audio.qml#L60
  function incrementVolume() {
    if (!sink?.audio?.volume) { return }
    const currentVolume = volume;
    const step = currentVolume < 0.1 ? 0.01 : 0.02;
    sink.audio.volume = Math.min(1, sink.audio.volume + step);
  }

  // https://github.com/end-4/dots-hyprland/blob/446504ad427297dcbe5ee4a3d5bda1c458207cd9/dots/.config/quickshell/ii/services/Audio.qml#L66
  function decrementVolume() {
    if (!sink?.audio?.volume) { return }
    const currentVolume = volume;
    const step = currentVolume < 0.1 ? 0.01 : 0.02;
    sink.audio.volume = Math.max(0, sink.audio.volume - step);
  }

  function toggleMute() {
    sink.audio.muted = !sink.audio.muted
  }

  GlobalShortcut { // qmllint disable unresolved-type
    name: "incrementVolume"
    description: "Increases the volume by one step"
    onPressed: {
      root.incrementVolume()
    }
  }

  GlobalShortcut { // qmllint disable unresolved-type
    name: "toggleMute"
    description: "Turn mute on or off"
    onPressed: {
      root.toggleMute()
    }
  }

  GlobalShortcut { // qmllint disable unresolved-type
    name: "decrementVolume"
    description: "Increases the volume by one step"
    onPressed: {
      root.decrementVolume()
    }
  }


  // Use cava to provde data for visualizers, runs in background
  // populating root.bars with parsed integers for each bar if
  // there is audio data
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
