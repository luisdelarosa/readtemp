import SwiftyGPIO
import Glibc
import Foundation
import dhtxx

let gpios = SwiftyGPIO.GPIOs(for:.RaspberryPi3)

let pin27 = gpios[.P27]!
let dht_sensor_type = dhtxx.SupportedSensor.dht22

let dht_sensor = DHT(pin: pin27, for: dht_sensor_type)

var temperature = 0.0
var humidity = 0.0

while (true) {
	do {
		(temperature, humidity) = try dht_sensor.read(debug: false)
		print("temperature: \(temperature) humidity: \(humidity)")
	} catch {
		print("error while reading temperature and humidity")
	}
	sleep(1)
}
