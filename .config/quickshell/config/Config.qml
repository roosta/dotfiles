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
  readonly property QtObject displays: QtObject {
    readonly property string left: "DP-2"
    readonly property string right: "HDMI-A-1"
    readonly property string center: "DP-1"
    readonly property string tv: "HDMI-A-2"
  }
  readonly property string defaultMode: "apps"
  readonly property var menus: {
    "display": {
      "name": "Display",
      "prefix": "/display ",
      "script": `${Paths.home}/scripts/switch-display.sh`
    },
    "audio": {
      "name": "Audio",
      "prefix": "/audio ",
      "script": `${Paths.home}/scripts/switch-audio.sh`
    },
    "apps": {
      "name": "Apps",
      "prefix": "/apps",
      "script": null
    }
  }
  readonly property var displayLayouts: [
    {
      id: 0,
      name: "Desk",
      description: "Switch to Desk Displays",
      script: [menus.display.script, "desk"],
      iconId: "input-keyboard"
    },
    {
      id: 1,
      name: "Television (TV)",
      description: "Switch to Television (TV)",
      script: [menus.display.script, "tv"],
      iconId: "input-gaming"
    },
    {
      id: 2,
      name: "Mirror",
      description: "Desk & Right Mirror to TV",
      script: [menus.display.script, "mirror"],
      iconId: "preferences-desktop-remote-desktop"
    },
    {
      id: 3,
      name: "All",
      description: "Enable all displays in-row",
      script: [menus.display.script, "all"],
      iconId: "video-display"
    }
  ]

  readonly property var outputs: [
    {
      id: 0,
      sink: "alsa_output.usb-SteelSeries_SteelSeries_Arctis_9_000000000000-00.stereo-game",
      icon: "",
      description: "Switch audio output to Speakers",
      iconId: "audio-speakers",
      name: "Speakers",
      script: [menus.audio.script, "speakers"]
    },
    {
      id: 1,
      sink: "alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink",
      icon: "󰓃",
      description: "Switch audio output to Headphones",
      iconId: "audio-headphones",
      name: "Headphones",
      script: [menus.audio.script, "headphones"]
    },
    {
      id: 2,
      sink: "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3",
      icon: "󰍹",
      description: "Switch audio output to Television (TV)" ,
      iconId: "video-display",
      name: "Television (TV)",
      script: [menus.audio.script, "tv"]
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
  readonly property var aliases: [
    ["spotify-launcher", "spotify"],
    ["kando", "input-mouse"],
    [/Minecraft.*/, "minecraft"],
    [/^steam_app_(\d+)$/, "steam_icon_$1"]
  ]

  function getAlias(id) {
    const t = aliases.reduce((acc, [re, s]) => {
      return acc.replace(re, s)
    }, id) 
    return t !== id ? t : null
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
