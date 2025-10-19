pragma Singleton

import Quickshell

Singleton {
    id: root

    readonly property string home: Quickshell.env("HOME")
    readonly property string pictures: Quickshell.env("XDG_PICTURES_DIR") || `${home}/Pictures`
    readonly property string videos: Quickshell.env("XDG_VIDEOS_DIR") || `${home}/Videos`
    readonly property string data: `${Quickshell.env("XDG_DATA_HOME") || `${home}/.local/share`}/ritual`
    readonly property string state: `${Quickshell.env("XDG_STATE_HOME") || `${home}/.local/state`}/ritual`
    readonly property string cache: `${Quickshell.env("XDG_CACHE_HOME") || `${home}/.cache`}/ritual`

    function absolutePath(path: string): string {
      return path.replace("~", home);
    }

    function shortenHome(path: string): string {
      return path.replace(home, "~");
    }
  }
