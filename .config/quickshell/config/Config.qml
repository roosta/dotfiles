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
      name: "Applications",
      description: "Browse and launcher desktop applications",
      mode: "apps",
      genericName: "Menu",
      categories: ["AppLauncher"],
      iconId: "applications-all"
    },
    {
      id: 1,
      name: "Display",
      description: "Switch display layouts between predefined presets",
      mode: "display",
      genericName: "Menu",
      categories: ["Display", "Configuration"],
      iconId: "preferences-desktop-display"
    },
    {
      id: 2,
      name: "Audio",
      description: "Switch audio options between predefined presets",
      mode: "audio",
      genericName: "Menu",
      categories: ["Audio", "Configuration"],
      iconId: "audio-x-generic"
    },
    {
      id: 3,
      name: "Power",
      description: "Power options for system (shutdown, restart, logout etc)",
      mode: "power",
      genericName: "Menu",
      categories: ["System", "Power"],
      iconId: "preferences-system"
    }
  ]

  readonly property var powerScripts: [
    {
      id: 0,
      name: "Shudown",
      description: "Power down system",
      genericName: "Script",
      categories: ["System", "Shutdown"],
      script: [`${Paths.scripts}/shutdown.sh`],
      iconId: "system-shutdown"
    },
    {
      id: 1,
      name: "Reboot",
      description: "Restart system",
      genericName: "Script",
      categories: ["System", "Restart"],
      script: [`${Paths.scripts}/reboot.sh`],
      iconId: "system-reboot"

    },
    {
      id: 2,
      name: "Log out",
      description: "Log out current user",
      genericName: "Power",
      categories: ["System", "LogOut"],
      script: [`${Paths.scripts}/logout.sh`],
      iconId: "system-log-out"
    },
    {
      id: 3,
      name: "Lock",
      genericName: "Power",
      categories: ["System", "Lock"],
      description: "Lock current session",
      script: [`${Paths.scripts}/lock.sh`],
      iconId: "system-lock-screen"
    },
    {
      id: 4,
      name: "Suspend",
      genericName: "Power",
      categories: ["System", "Suspend"],
      description: "Suspend to RAM",
      script: [`${Paths.scripts}/suspend.sh`],
      iconId: "system-suspend"
    },
    {
      id: 5,
      genericName: "Power",
      categories: ["System", "Hibernate"],
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
      description: "Arrange displays in the default desk layout",
      genericName: "Display",
      categories: ["Display", "Desk"],
      script: [menus.display.script, "desk"],
      iconId: "input-keyboard"
    },
    {
      id: 1,
      name: "Television (TV)",
      description: "Switch to Television (TV), disabling all other displays",
      script: [menus.display.script, "tv"],
      genericName: "Display",
      categories: ["Display", "TV"],
      iconId: "applications-games"
    },
    {
      id: 2,
      name: "Mirror",
      genericName: "Display",
      categories: ["Display", "Mirror"],
      description: "Arrange desk layout, and mirror right display to TV",
      script: [menus.display.script, "mirror"],
      iconId: "preferences-desktop-remote-desktop"
    },
    {
      id: 3,
      name: "All",
      genericName: "Display",
      categories: ["Display", "All"],
      description: "Arrange all monitors in a side by side layout except for top monitor",
      script: [menus.display.script, "all"],
      iconId: "multitasking-view"
    },
    {
      id: 3,
      name: "Exclusive",
      genericName: "Display",
      categories: ["Display", "Exclusive"],
      description: "Disable all but center monitor (desk), setting a single exclusive display",
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
      genericName: "Audio",
      categories: ["Audio", "Speakers"],
      iconId: "audio-speakers",
      name: "Speakers",
      script: [menus.audio.script, "speakers"]
    },
    {
      id: 1,
      sink: "alsa_output.usb-SteelSeries_SteelSeries_Arctis_7-00.stereo-game",
      genericName: "Audio",
      categories: ["Audio", "Headphones"],
      icon: "",
      description: "Switch audio output to Headphones",
      iconId: "audio-headphones",
      name: "Headphones",
      script: [menus.audio.script, "headphones"]
    },
    {
      id: 2,
      genericName: "Audio",
      categories: ["Audio", "TV"],
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
    [/.*pavucontrol.*/, "gnome-volume-control"],
    [/.*gpick.*/i, "preferences-color"]
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
    "net.lutris.Lutris",
    "com.github.iwalton3.jellyfin-media-player",
    "spotify",
    "org.mozilla.thunderbird",
    "com.discordapp.Discord",
    "kitty"
  ]
}
