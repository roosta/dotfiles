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

  // wip: planned scale per display
  property real scale: 1.0

  // Default apps
  readonly property string terminal: "kitty"
  readonly property string shell: "zsh"

  // Menu prefix
  readonly property string menuPrefix: "/"

  // Available displays

  component Displays: QtObject {
    readonly property string left: "DP-2"
    readonly property string right: "HDMI-A-1"
    readonly property string center: "DP-1"
    readonly property string tv: "HDMI-A-2"
    readonly property string top: "HDMI-A-3"
  }
  readonly property Displays displays: Displays { }

  // Primary display
  readonly property string primaryDisplay: root.displays.center

  // default menu mode
  readonly property string defaultMode: "apps"


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

  // Menu modes, defaults to apps
  readonly property var launcherMenus: [
    {
      id: "ritual-mode-apps",
      name: "Applications",
      comment: "Browse and launcher desktop applications",
      mode: "apps",
      genericName: "Menu",
      categories: ["AppLauncher"],
      iconId: "applications-all"
    },
    {
      id: "ritual-mode-display",
      name: "Display",
      comment: "Switch display layouts between predefined presets",
      mode: "display",
      genericName: "Menu",
      categories: ["Display", "Configuration"],
      iconId: "preferences-desktop-display"
    },
    {
      id: "ritual-mode-audio",
      name: "Audio",
      comment: "Switch audio options between predefined presets",
      mode: "audio",
      genericName: "Menu",
      categories: ["Audio", "Configuration"],
      iconId: "audio-x-generic"
    },
    {
      id: "ritual-mode-power",
      name: "Power",
      comment: "Power options for system (shutdown, restart, logout etc)",
      mode: "power",
      genericName: "Menu",
      categories: ["System", "Power"],
      iconId: "preferences-system"
    },
    {
      id: "ritual-mode-utils",
      name: "Utilities",
      comment: "Various handy utilities, normally launches a script stored in ~/scripts",
      mode: "utils",
      genericName: "Menu",
      categories: ["Utility", "FileTools"],
      iconId: "applications-utilities"
    }
  ]


  // Power scripts (shutdown, logout, reboot etc), see ~/scripts for each option
  readonly property var powerScripts: [
    {
      id: "ritual-power-shutdown",
      name: "Shudown",
      comment: "Power down system",
      genericName: "Script",
      categories: ["System", "Shutdown"],
      script: [`${Paths.scripts}/shutdown.sh`],
      iconId: "system-shutdown"
    },
    {
      id: "ritual-power-reboot",
      name: "Reboot",
      comment: "Restart system",
      genericName: "Script",
      categories: ["System", "Restart"],
      script: [`${Paths.scripts}/reboot.sh`],
      iconId: "system-reboot"
    },
    {
      id: "ritual-power-logout",
      name: "Log out",
      comment: "Log out current user",
      genericName: "Power",
      categories: ["System", "LogOut"],
      script: [`${Paths.scripts}/logout.sh`],
      iconId: "system-log-out"
    },
    {
      id: "ritual-power-lock",
      name: "Lock",
      genericName: "Power",
      categories: ["System", "Lock"],
      comment: "Lock current session",
      script: [`${Paths.scripts}/lock.sh`],
      iconId: "system-lock-screen"
    },
    {
      id: "ritual-power-suspend",
      name: "Suspend",
      genericName: "Power",
      categories: ["System", "Suspend"],
      comment: "Suspend to RAM",
      script: [`${Paths.scripts}/suspend.sh`],
      iconId: "system-suspend"
    },
    {
      id: "ritual-power-hibernate",
      genericName: "Power",
      categories: ["System", "Hibernate"],
      name: "Hibernate",
      comment: "Suspend to disk",
      script: [`${Paths.scripts}/suspend.sh`],
      iconId: "system-hibernate"
    }
  ]

  readonly property var utilities: [
    {
      id: "ritual-utils-screenshot",
      name: "Screenshot",
      comment: "Screenshot and annotate utility",
      genericName: "Script",
      categories: ["Utility", "ImageProcessing"],
      script: [`${Paths.scripts}/screenshot.sh`],
      iconId: "accessories-screenshot"
    },
    {
      id: "ritual-utils-colorpicker",
      name: "Color picker",
      comment: "Pick a hexadecimal color from screens, and place in clipboard",
      genericName: "Script",
      categories: ["Utility", "ImageProcessing"],
      script: [`${Paths.scripts}/colorpicker.sh`],
      iconId: "color-picker"
    },
    {
      id: "ritual-utils-monitor",
      name: "System Monitor",
      comment: "Monitor system resource usage",
      genericName: "Script",
      categories: ["Utility", "Monitor"],
      script: [`${Paths.scripts}/system-monitor.sh`, '-c', `${Paths.config}/btop/monitor.conf`],
      iconId: "utilities-system-monitor"
    }
  ]

  // Display layouts (~/.config/hypr/monitor/*)
  readonly property var displayLayouts: [
    {
      id: "ritual-display-desk",
      name: "Desk",
      comment: "Arrange displays in the default desk layout",
      genericName: "Display",
      categories: ["Display", "Desk"],
      script: [`${Paths.home}/scripts/switch-display.sh`, "desk"],
      iconId: "input-keyboard"
    },
    {
      id: "ritual-display-tv",
      name: "Television (TV)",
      comment: "Switch to Television (TV), disabling all other displays",
      script: [`${Paths.home}/scripts/switch-display.sh`, "tv"],
      genericName: "Display",
      categories: ["Display", "TV"],
      iconId: "applications-games"
    },
    {
      id: "ritual-display-mirror",
      name: "Mirror",
      genericName: "Display",
      categories: ["Display", "Mirror"],
      comment: "Arrange desk layout, and mirror right display to TV",
      script: [`${Paths.home}/scripts/switch-display.sh`, "mirror"],
      iconId: "preferences-desktop-remote-desktop"
    },
    {
      id: "ritual-display-all",
      name: "All",
      genericName: "Display",
      categories: ["Display", "All"],
      comment: "Arrange all monitors in a side by side layout except for top monitor",
      script: [`${Paths.home}/scripts/switch-display.sh`, "all"],
      iconId: "multitasking-view"
    },
    {
      id: "ritual-display-exclusive",
      name: "Exclusive",
      genericName: "Display",
      categories: ["Display", "Exclusive"],
      comment: "Disable all but center monitor (desk), setting a single exclusive display",
      script: [`${Paths.home}/scripts/switch-display.sh`, "single"],
      iconId: "cs-display"
    }
  ]

  // Audio output sinks
  readonly property var outputs: [
    {
      id: 0,
      sink: "alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink",
      icon: "󰓃",
      comment: "Switch audio output to Speakers",
      genericName: "Audio",
      categories: ["Audio", "Speakers"],
      iconId: "audio-speakers",
      name: "Speakers",
      script: [`${Paths.home}/scripts/switch-audio.sh`, "speakers"]
    },
    {
      id: 1,
      sink: "alsa_output.usb-SteelSeries_SteelSeries_Arctis_7-00.stereo-game",
      genericName: "Audio",
      categories: ["Audio", "Headphones"],
      icon: "",
      comment: "Switch audio output to Headphones",
      iconId: "audio-headphones",
      name: "Headphones",
      script: [`${Paths.home}/scripts/switch-audio.sh`, "headphones"]
    },
    {
      id: 2,
      genericName: "Audio",
      categories: ["Audio", "TV"],
      sink: "alsa_output.pci-0000_03_00.1.hdmi-stereo-extra3",
      icon: "󰍹",
      comment: "Switch audio output to Television (TV)" ,
      iconId: "video-display",
      name: "Television (TV)",
      script: [`${Paths.home}/scripts/switch-audio.sh`, "tv"]
    }
  ]

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

  // Move to something interactive via the menu, but this'll do for now
  property var favorites: [
    "firefox",
    "firefox-media",
    "steam",
    "net.lutris.Lutris",
    "com.github.iwalton3.jellyfin-media-player",
    "spotify",
    "org.mozilla.Thunderbird",
    "com.discordapp.Discord",
    "kitty"
  ]
}
