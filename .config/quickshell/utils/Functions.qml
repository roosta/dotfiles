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

  /**
   * Source: https://github.com/end-4/dots-hyprland/blob/a7f1cddd45ae02e6a2ee4178d2f1e72d00fea7f3/dots/.config/quickshell/ii/modules/common/functions/NotificationUtils.qml#L54-L86
   * @param { number | string | Date } timestamp
   * @returns { string }
   */
  function timeElapsed(timestamp) {
    if (!timestamp) return '';
    const messageTime = new Date(timestamp);
    const now = new Date();
    const diffMs = now.getTime() - messageTime.getTime();

    // Less than 1 minute
    if (diffMs < 60000)
    return 'Now';

    // Same day - show relative time
    if (messageTime.toDateString() === now.toDateString()) {
      const diffMinutes = Math.floor(diffMs / 60000);
      const diffHours = Math.floor(diffMs / 3600000);

      if (diffHours > 0) {
        return `${diffHours}h`;
      } else {
        return `${diffMinutes}m`;
      }
    }

    // Yesterday
    if (messageTime.toDateString() === new Date(now.getTime() - 86400000).toDateString())
    return 'Yesterday';

    // Older dates
    return Qt.formatDateTime(messageTime, "MMMM dd");
  }
}
