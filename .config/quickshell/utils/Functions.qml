pragma Singleton
import Quickshell

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
}
