pragma Singleton
import Quickshell

Singleton {
  id: root

  /**
   * Debug print function, returns printed value so can be used in-place
   * @param {var} val - the value to print
   * @returns {var} the printed value
   */
  function log(val, stringify = true) {
    if (stringify) {
      console.log(JSON.stringify(val, null, 2))
    } else {
      console.log(val)
    }
    return val
  }
}
