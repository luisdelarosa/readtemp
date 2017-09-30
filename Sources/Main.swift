import SwiftyGPIO
import Glibc
import Foundation
import dhtxx

let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi3)

let pin27 = gpios[.P27]!
let dht_sensor_type = dhtxx.SupportedSensor.dht11

let dht_sensor = DHT(pin: pin27, for: dht_sensor_type)

var temperature = 0.0
var humidity = 0.0

// From https://stackoverflow.com/a/26973384/1174526
@discardableResult
func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

while (true) {
	do {
		// Read sensor
		(temperature, humidity) = try dht_sensor.read(debug: false)

		if (humidity < 100.0) {

			// Temporary hack until we have a supported MQTT module
			shell("mosquitto_pub", "-t", "test", "-m", "\(humidity)")

			// Log on console
			print("temperature: \(temperature) humidity: \(humidity)")
		} else {
			print("error reading humidity")
		}
	} catch {
		print("error while reading temperature and humidity")
	}
	sleep(1)
}
