pragma Singleton
pragma ComponentBehavior: Bound

// import Quickshell.Io
import Quickshell
import qs.services
import qs.utils
import QtQuick

Singleton {
  id: root
  readonly property real scale: 1.0
  readonly property string terminal: "kitty"
  readonly property string shell: "zsh"
  readonly property string prefix: "/"
  readonly property QtObject monitors: QtObject {
    readonly property string left: "DP-2"
    readonly property string right: "HDMI-A-1"
    readonly property string center: "DP-1"
    readonly property string tv: "HDMI-A-2"
  }
  readonly property string audioPrefix: "/audio"
  readonly property string audioScript : `${Paths.home}/scripts/switch-audio.sh`

  readonly property var outputs: [
    {
      id: 0,
      sink: "alsa_output.usb-SteelSeries_SteelSeries_Arctis_9_000000000000-00.stereo-game",
      icon: "",
      description: "Switch audio output to Speakers",
      iconId: "audio-speakers",
      name: "Speakers",
      script: [audioScript, "speakers"]
    },
    {
      id: 1,
      sink: "alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink",
      icon: "󰓃",
      description: "Switch audio output to Headphones",
      iconId: "audio-headphones",
      name: "Headphones",
      script: [audioScript, "headphones"]
    },
    {
      id: 2,
      sink: "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3",
      icon: "󰍹",
      description: "Switch audio output to Television (TV)" ,
      iconId: "video-display",
      name: "Television (TV)",
      script: [audioScript, "tv"]
    }
  ] 

  function getSinkIcon(sink) {
    if (sink) {
      const obj = outputs.find(o => o.sink == sink.name);
      if (obj) { return obj.icon } 
    } else {
      return ""
    }
  }

  // icon aliases, if a class/appid matches key, use value
  // in cases where there isn't a good icon match
  readonly property var aliases: {
    "spotify-launcher": "spotify",
    "kando": "input-mouse"
  }

  function getAlias(id) {
    const match = Object.entries(root.aliases)
    .find(([k, v]) => k.includes(id.toLowerCase()))
    return match?.[1]
  }

  // Move to something interactive via the menu, but this'll do for now
  property var favorites: [
    "firefox",
    "firefox-media",
    "steam",
    "com.github.iwalton3.jellyfin-media-player",
    "net.lutris.Lutris",
    "com.discordapp.Discord",
    "kando",
    "org.mozilla.thunderbird"
  ]
}
