pragma Singleton

import Quickshell

Singleton {
    id: root

    readonly property string home: Quickshell.env("HOME")

    // Helper function to get XDG directory with fallback
    function xdgDir(envVar, fallback, subdir = "") {
      const base = Quickshell.env(envVar) || `${abs(fallback)}`;
      return subdir ? `${base}/${subdir}` : base;
    }

    readonly property string pictures: xdgDir("XDG_PICTURES_DIR", "~/Pictures")
    readonly property string videos: xdgDir("XDG_VIDEOS_DIR", "~/Videos")
    readonly property string data: xdgDir("XDG_DATA_HOME", "~/.local/share", "ritual")
    readonly property string state: xdgDir("XDG_STATE_HOME", "~/.local/state", "ritual")
    readonly property string cache: xdgDir("XDG_CACHE_HOME", "~/.cache", "ritual")
    readonly property string srcery: xdgDir("XDG_CONFIG_HOME", "~/.config", "srcery")
    readonly property string scripts: `${home}/scripts`
    readonly property string assets: `${home}/.assets`

    function abs(path: string): string {
      return path.replace("~", home);
    }

    function shortenHome(path: string): string {
      return path.replace(home, "~");
    }
  }
