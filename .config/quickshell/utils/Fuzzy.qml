// GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
// Based on https://github.com/end-4/dots-hyprland/blob/21d6bcc63e9a969986950c3b869ed9a4866a11e7/.config/quickshell/ii/modules/common/functions/Fuzzy.qml
// Modified 2025 by Daniel Berg <mail@roosta.sh>

pragma Singleton
import Quickshell
import "./fuzzysort.js" as FuzzySort

/**
 * Wrapper for FuzzySort to play nicely with Quickshell's imports
 */
Singleton {
  function go(...args) {
    return FuzzySort.go(...args)
  }

  function prepare(...args) {
    return FuzzySort.prepare(...args)
  }
}

