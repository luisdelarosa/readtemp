// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "readtemp",
    dependencies: [
        .Package(url: "https://github.com/uraimo/SwiftyGPIO.git", majorVersion: 0),
        .Package(url: "https://github.com/luisdelarosa/dhtxx.git", majorVersion: 0)
    ]
)
