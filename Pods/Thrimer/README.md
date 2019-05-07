# Thrimer

[![CI Status](http://img.shields.io/travis/seanmcneil/Thrimer.svg?style=flat)](https://travis-ci.org/seanmcneil/Thrimer)
[![Version](https://img.shields.io/cocoapods/v/Thrimer.svg?style=flat)](http://cocoapods.org/pods/Thrimer)
[![License](https://img.shields.io/cocoapods/l/Thrimer.svg?style=flat)](http://cocoapods.org/pods/Thrimer)
[![Platform](https://img.shields.io/cocoapods/p/Thrimer.svg?style=flat)](http://cocoapods.org/pods/Thrimer)
[![CocoaPods](https://img.shields.io/cocoapods/dt/Thrimer.svg?style=flat)](http://cocoapods.org/pods/Thrimer)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 10.0+
- Xcode 9.3+
- Swift 4.1+

## Installation

Thrimer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Thrimer"
```

## Instructions

### Basic setup

Import the framework:

```swift
import Thrimer
```

It is recommended that you set an instance variable for Thrimer:
```swift
class ViewController: UIViewController {
var thrimer: Thrimer?
```

### Express setup

Initialize your property, delegate and start automatically with optional value, a non-repeating timer that runs for 10 seconds.
```swift
thrimer = Thrimer(interval: 10.0, delegate: self, repeats: false)
```

### Standard timer

Initialize your property, the following creates a non-repeating timer that runs for 10 seconds.
```swift
thrimer = Thrimer(interval: 10.0, repeats: false)
```

Next, set the delegate:
```swift
thrimer?.delegate = self
```

And start the timer when you are ready:
```swift
thrimer?.start()
```

### Delegate

To receive updates when the timer completes, you must comform to the ThrimerDelegate:
```swift
extension ViewController: ThrimerDelegate {
    func thrimerEvent(thrimer: Thrimer) {
        // Event triggered
    }
}
```

### Pause timer

This creates a non-repeating timer with a 10 second duration.

```swift
let thrimer = Thrimer(interval: 10.0, repeats: false)
thrimer.delegate = self
thrimer.start()
```

Once the timer is running, you can now pause it:

```swift
thrimer.pause()
```

You can check to see if it is paused:

```swift
if thrimer.isPaused  {
    print("Timer is paused")
}
```

You can check to see how much time is remaining on the timer:
```swift
print(thrimer.timeRemaining ?? "Timer is not paused")
```

Finally, you can resume it:

```swift
thrimer.resume()
```

## Changelog

[Changelog](https://github.com/seanmcneil/Thrimer/blob/master/CHANGELOG.md) | See the changes introduced in each version.

## Author

seanmcneil, s@m.com

## License

Thrimer is available under the MIT license. See the LICENSE file for more info.
