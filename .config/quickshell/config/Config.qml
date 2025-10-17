pragma Singleton
pragma ComponentBehavior: Bound

// import Quickshell.Io
import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property real scale: 1.0
  readonly property string terminal: "kitty"
  readonly property string shell: "zsh"
  readonly property QtObject monitors: QtObject {
    readonly property string left: "DP-2"
    readonly property string right: "HDMI-A-1"
    readonly property string center: "DP-1"
    readonly property string tv: "HDMI-A-2"
  }
  readonly property var outputs: [
    {
      name: "alsa_output.usb-SteelSeries_SteelSeries_Arctis_9_000000000000-00.stereo-game",
      icon: ""
    },
    {
      name: "alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink",
      icon: "󰓃"
    },
    {
      name: "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3",
      icon: "󰍹"
    }
  ]

  function getSinkIcon(sink) {
    const obj = outputs.find(o => o.name == sink.name);
    if (obj) { return obj.icon } 
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
