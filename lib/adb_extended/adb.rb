require 'open3'

include Open3

module AdbExtended

  class Adb

    def self.devices
      stdout, stderr, status = Open3.capture3("adb devices -l")
      device_ids = stdout.lines[0...-1]
      return device_ids.drop(1).map{ |device|
        split = device.gsub(/\s+/m, ' ').strip.split(" ")
        {
            :serial => split[0],
            :type => split[1],
            :usb => split[2].gsub('usb:', ''),
            :product => split[3].gsub('product:', ''),
            :model => split[4].gsub('model:', ''),
            :transport_id => split[5].gsub('transport_id:', '')
        }
      }
    end

    def self.dumpsys(serial, stat = nil)
      stdout, stderr, status = Open3.capture3("adb -s #{serial} shell dumpsys #{stat}")
      return stdout.lines
    end

    def self.battery(serial)
      stats = dumpsys(serial, "battery")

      return stats.select { |s| s.include?("level") }[0]
    end

    def self.shell(serial)
      exec "adb -s #{serial} shell"
    end

    def self.pidcat(serial, level = "d", package = nil)
      exec "pidcat -s #{serial} -l #{level} #{package}"
    end

    def self.logcat(serial, level = "D", package)

      stdout, stderr, status = Open3.capture3("adb -s #{serial} shell ps")

      filter = nil

      if package != nil
        package_info = stdout.lines.select { |line| line.include?("#{package}") }
        if package_info.size == 0
          puts 'Application not running'
          exit 1
        end
        columns = package_info[0].gsub(/\s+/m, ' ').strip.split(" ")
        filter = "| grep -F #{columns[1]}"
      end
      exec "adb -s #{serial} logcat *:#{level} #{filter}"
    end
  end

end