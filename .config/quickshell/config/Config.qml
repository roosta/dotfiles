pragma Singleton
pragma ComponentBehavior: Bound

// import Quickshell.Io
import Quickshell
import qs.services
import qs.utils
import qs.config
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
  readonly property string primaryDisplay: root.displays.center

  property var keyboardLayouts: [
    {
      code: "no",
      label: "Norwegian",
      color: Appearance.srcery.yellow,
      default: false
    },
    {
      code: "en",
      label: "English (US)",
      color: Appearance.srcery.white,
      default: true
    }
  ]

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
    },
    "power": {
      "name": "Power",
      "prefix": "/power",
      "script": null
    }
  }
  readonly property var modeMenu: [
    {
      id: 0,
      name: "Apps",
      description: "Browse and start desktop applications",
      mode: "apps",
      iconId: "applications-all"
    },
    {
      id: 1,
      name: "Display",
      description: "Switch display layouts between presets",
      mode: "display",
      iconId: "preferences-desktop-display"
    },
    {
      id: 2,
      name: "Audio",
      description: "Switch audio options between presets",
      mode: "audio",
      iconId: "audio-x-generic"
    },
    {
      id: 3,
      name: "Power",
      description: "Power options for system (shutdown, restart, logout etc)",
      mode: "power",
      iconId: "preferences-system"
    }
  ]

  readonly property var powerScripts: [
    {
      id: 0,
      name: "Shudown",
      description: "Power down system",
      script: [`${Paths.scripts}/shutdown.sh`],
      iconId: "system-shutdown"
    },
    {
      id: 1,
      name: "Reboot",
      description: "Restart system",
      script: [`${Paths.scripts}/reboot.sh`],
      iconId: "system-reboot"

    },
    {
      id: 2,
      name: "Log out",
      description: "Log out current user",
      script: [`${Paths.scripts}/logout.sh`],
      iconId: "system-log-out"
    },
    {
      id: 3,
      name: "Lock",
      description: "Lock current session",
      script: [`${Paths.scripts}/lock.sh`],
      iconId: "system-lock-screen"
    },
    {
      id: 4,
      name: "Suspend",
      description: "Suspend to RAM",
      script: [`${Paths.scripts}/suspend.sh`],
      iconId: "system-suspend"
    },
    {
      id: 5,
      name: "Hibernate",
      description: "Suspend to disk",
      script: [`${Paths.scripts}/suspend.sh`],
      iconId: "system-hibernate"
    }
  ]
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
      iconId: "applications-games"
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
      iconId: "multitasking-view"
    },
    {
      id: 3,
      name: "Single",
      description: "Disable all but center monitor (desk)",
      script: [menus.display.script, "single"],
      iconId: "cs-display"
    }
  ]

  readonly property var outputs: [
    {
      id: 0,
      sink: "alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink",
      icon: "󰓃",
      description: "Switch audio output to Speakers",
      iconId: "audio-speakers",
      name: "Speakers",
      script: [menus.audio.script, "speakers"]
    },
    {
      id: 1,
      sink: "alsa_output.usb-SteelSeries_SteelSeries_Arctis_7-00.stereo-game",
      icon: "",
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
    [/.*spotify.*/i, "spotify"],
    [/kando/i, "input-mouse"],
    [/minecraft.*/i, "minecraft"],
    [/^steam_app_(\d+)$/, "steam_icon_$1"],
    [/kitty/i, "terminal"],
    [/.*pavucontrol.*/, "gnome-volume-control"]
  ]

  // Get an alias for input id (usually class/appid)
  function getAlias(id) {
    for (const [re, repl] of aliases) {
      if (re.test(id)) {
        return id.replace(re, repl);
      }
    }
    return null;
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
    "spotify",
    "org.mozilla.thunderbird"
  ]
}
