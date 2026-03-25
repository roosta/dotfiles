// ┌───────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░░░░▀█▀░▀█▀░█▄█░█▀▀░░░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░░░░█░░░█░░█░█░█▀▀░░░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░░░░▀░░▀▀▀░▀░▀░▀▀▀░░░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀───────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>      ├┤
// ││ Repo    : https://github.com/roosta/dotfiles││
// ││ Site    : https://www.roosta.sh             ││
// ├┤ License : GNU General Public License v3     ├┤
// ┆└─────────────────────────────────────────────┘┆

pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  property alias enabled: clock.enabled

  // an expression can be broken across multiple lines using {}
  readonly property string time: {
    // The passed format string matches the default output of
    // the `date` command.
    Qt.formatDateTime(clock.date, "hh:mm")
  }

  readonly property string now: clock.date.getTime()

  readonly property string date: {
    Qt.formatDateTime(clock.date, "ddd dd/MM yyyy")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
