require 'thor'
require 'terminal-table'
require 'adb_extended'

module AdbExtended
  class CLI < Thor
    include Thor::Actions

    desc "devices", "Lists the Android devices with a little more info"
    method_options :battery => :boolean, :select_device => :boolean
    def devices()
      devices = AdbExtended::Adb.devices

      table = Terminal::Table.new do |t|
        header_row = %w(# Model Serial)

        if options.battery?
          header_row.push('Battery')
        end

        t << header_row
        t << :separator
        devices.each_with_index {|value, index|
          row = [index + 1, value[:model], value[:serial]]

          if options.battery?
            battery_level = AdbExtended::Adb.battery(value[:serial]).gsub('level:', '')
            row.push(battery_level)
          end

          t.add_row row
        }
      end

      puts table

    end

    desc "ashell", "Lists the devices and allows you to choose one to run the shell on"
    def ashell
      serial = pick_device
      AdbExtended::Adb.shell(serial)
    end

    desc "pidcat PACKAGE", "Lists the devices and allows you to choose one to run with pidcat"
    method_option :level, :default => 'd', :enum => %w(V D I W E F v d i w e f), :aliases => '-l'
    def pidcat(package = nil)
      serial = pick_device
      AdbExtended::Adb.pidcat(serial, options[:level], package)
    end

    desc "logcat", "Lists the devices and allows you to choose one to run with logcat"
    method_option :level, :default => 'D', :enum => %w(V D I W E F), :aliases => '-l'
    def logcat(package = nil)
      serial = pick_device
      AdbExtended::Adb.logcat(serial, options[:level], package)
    end

    private

    # Returns the serial number of the chosen device
    def pick_device

      devices = AdbExtended::Adb.devices

      if devices.size == 0
        puts 'No devices found'
        exit 1
      end

      if devices.size == 1
        return devices[0][:serial]
      end

      table = Terminal::Table.new do |t|
        header_row = %w(# Model Serial)

        t << header_row
        t << :separator
        devices.each_with_index {|value, index|
          row = [index + 1, value[:model], value[:serial]]
          t.add_row row
        }
      end

      puts table

      accepted_inputs = *(1..devices.size).map {|i| i.to_s}
      index = ask("Select a device (1 - #{devices.size}):", :limited_to => accepted_inputs).to_i - 1
      devices[index][:serial]
    end

  end
end