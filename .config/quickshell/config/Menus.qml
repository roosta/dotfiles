pragma Singleton
pragma ComponentBehavior: Bound

// import Quickshell.Io
import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property var audio: [ 
    {
      "args": ["speakers"],
      "description": "Switch audio output to Speakers",
      "icon": "audio-speakers",
      "name": "Speakers",
      "script": "~/scripts/switch-audio.sh"
    },
    {
      "args": ["headphones"],
      "description": "Switch audio output to Headphones",
      "icon": "audio-headphones",
      "name": "Headphones",
      "script": "~/scripts/switch-audio.sh"
    },
    {
      "args": ["tv"],
      "description": "Switch audio output to Television (TV)" ,
      "icon": "video-display",
      "name": "Television (TV)",
      "script": "~/scripts/switch-audio.sh"
    },
    {
      "args": ["mute-output"],
      "description": "Toggle Default Output Sink",
      "icon": "audio-volume-muted",
      "name": "Mute output",
      "script": "~/scripts/switch-audio.sh"
    },
    {
      "args": ["mute-input"],
      "description": "Mute Default Input Sink",
      "icon": "microphone-sensitivity-muted",
      "name": "Mute input",
      "script": "~/scripts/switch-audio.sh"
    }
  ]
}
