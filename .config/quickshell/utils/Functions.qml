pragma Singleton
import Quickshell
import qs.config

Singleton {
  id: root
  /**
   * Groups array elements by a key generated from the callback function
   * @param {Array} array - The array to group
   * @param {Function} keyFn - Function that returns the grouping key for each element
   * @returns {Object} Object with keys as group names and values as arrays of elements
   */
  function groupBy(array, keyFn) {
    return array.reduce((acc, item, index) => {
      // Get the key for this item
      const key = keyFn(item, index, array);

      // Initialize the array for this key if it doesn't exist yet
      if (!acc[key]) {
        acc[key] = [];
      }

      // Add the item to its group
      acc[key].push(item);

      // Return the accumulator for the next iteration
      return acc;
    }, {});
  }


  /**
   * Truncate string s, not width aware, takes n length or defaults
   * to Appearance
   * @param {String} s - Text to truncate
   * @param {Number} n - String max length, ellipsis will be inserted past
   *                     this, defaults to Appearance.bar.textLength
   * @returns {String}
   */
  function truncate(text, n = Appearance.bar.textLength) {
    if (typeof text !== "string") {
      console.warn("Not a string!")
      return
    }
    if (text && text.length >= n) {
      return `${text.substring(0, n)} ...`
    }
    return text
  }
  /**
   * Capitalize string, doesn't handle multiple words
   * @param {String} s - String to capitalize
   * @returns {String} Capitalized string
   */
  function capitalize(s) {
    return String(s).charAt(0).toUpperCase() + String(s).slice(1);
  }


  /**
   * Transparentizes a color by a given percentage.
   * Source: https://github.com/end-4/dots-hyprland/blob/f324fc7c104cd99932e172caf435f4109725f805/.config/quickshell/ii/modules/common/functions/ColorUtils.qml#L103-L113
   * @param {string} color - The color (any Qt.color-compatible string).
   * @param {number} percentage - The amount to transparentize (0-1).
   * @returns {Qt.rgba} The resulting color.
   */
  function transparentize(color, percentage = 1) {
    var c = Qt.color(color);
    return Qt.rgba(c.r, c.g, c.b, c.a * (1 - percentage));
  }
}
