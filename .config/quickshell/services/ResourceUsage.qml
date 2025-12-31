// GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
// Based on https://github.com/end-4/dots-hyprland/blob/b4920a7cb610c026ec8683f73909400f39097340/dots/.config/quickshell/ii/services/ResourceUsage.qml
// Modified 2025 by Daniel Berg <mail@roosta.sh>

pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

/**
 * Simple polled resource usage service with RAM, Swap, and CPU usage.
 */
Singleton {
  id: root
  property real memoryTotal: 1
  property real memoryFree: 0
  property real memoryUsed: memoryTotal - memoryFree
  property real memoryUsedPercentage: memoryUsed / memoryTotal
  property real swapTotal: 1
  property real swapFree: 0
  property real swapUsed: swapTotal - swapFree
  property real swapUsedPercentage: swapTotal > 0 ? (swapUsed / swapTotal) : 0
  property real cpuUsage: 0
  property var previousCpuStats
  property string cpuTooltip

  property string maxAvailableMemoryString: kbToGbString(ResourceUsage.memoryTotal)
  property string maxAvailableSwapString: kbToGbString(ResourceUsage.swapTotal)

  readonly property int historyLength: 60
  property list<real> cpuUsageHistory: []
  property list<real> memoryUsageHistory: []
  property list<real> swapUsageHistory: []

  function kbToGbString(kb) {
    return (kb / (1024 * 1024)).toFixed(1) + " GB";
  }

  function refreshTooltip() {
    topProc.running = true
  }

  function updateMemoryUsageHistory() {
    memoryUsageHistory = [...memoryUsageHistory, memoryUsedPercentage]
    if (memoryUsageHistory.length > historyLength) {
      memoryUsageHistory.shift()
    }
  }
  function updateSwapUsageHistory() {
    swapUsageHistory = [...swapUsageHistory, swapUsedPercentage]
    if (swapUsageHistory.length > historyLength) {
      swapUsageHistory.shift()
    }
  }
  function updateCpuUsageHistory() {
    cpuUsageHistory = [...cpuUsageHistory, cpuUsage]
    if (cpuUsageHistory.length > historyLength) {
      cpuUsageHistory.shift()
    }
  }
  function updateHistories() {
    updateMemoryUsageHistory()
    updateSwapUsageHistory()
    updateCpuUsageHistory()
  }

  Timer {
    interval: 1
    running: true
    repeat: true
    onTriggered: {
      // Reload files
      fileMeminfo.reload()
      fileStat.reload()

      // Parse memory and swap usage
      const textMeminfo = fileMeminfo.text()
      root.memoryTotal = Number(textMeminfo.match(/MemTotal: *(\d+)/)?.[1] ?? 1)
      root.memoryFree = Number(textMeminfo.match(/MemAvailable: *(\d+)/)?.[1] ?? 0)
      root.swapTotal = Number(textMeminfo.match(/SwapTotal: *(\d+)/)?.[1] ?? 1)
      root.swapFree = Number(textMeminfo.match(/SwapFree: *(\d+)/)?.[1] ?? 0)

      // Parse CPU usage
      const textStat = fileStat.text()
      const cpuLine = textStat.match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/)
      if (cpuLine) {
        const stats = cpuLine.slice(1).map(Number)
        const total = stats.reduce((a, b) => a + b, 0)
        const idle = stats[3]

        if (root.previousCpuStats) {
          const totalDiff = total - root.previousCpuStats.total
          const idleDiff = idle - root.previousCpuStats.idle
          root.cpuUsage = totalDiff > 0 ? (1 - idleDiff / totalDiff) : 0
        }

        root.previousCpuStats = { total, idle }
      }

      root.updateHistories()
      interval = 3000
    }
  }

  FileView { id: fileMeminfo; path: "/proc/meminfo" }
  FileView { id: fileStat; path: "/proc/stat" }

  Process {
    id: topProc
    command: ["bash", "-c", "ps -eo comm:20,%cpu --sort=-%cpu | head -n 6 | tail -n 5"]
    running: true
    stdout: StdioCollector {
      id: outputCollector
      onStreamFinished: {
        root.cpuTooltip = outputCollector.text.replace(/\n$/, '')
      }
    }
  }
}
