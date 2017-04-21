# AirPorts

* The swift 3.0 project is built as per the requirements, an additional search feature included. 
* The application uses functional reactive programming using RxSwift
* The data persistence is done using realm
* The app uses auto layout and manual layout 
* The automated UI tests are implemented using KIF framework.It simulate the normal use-cases
  and test the behavior of the application in different scenarios
* Unit tests are provided


### How the app behaves

* running for the first time the app shows a loading screen. 
* silently downloads the list of airports and stores in realm database locally.
* app then lists all the airports 
* user can then search airport by name
* user can tap on an airport to see its details with location on map
* The app downloads the airport list only during first run.
* The app work offline after first run
* The app work in iPhone and iPAD in all orientations

### The project has 3 targets

* AirPort -> the application
* AirPortTests -> unit test target
* AirPortUITests -> The integration test  or UI test target


### Prerequisites

* XCode version 8.2.1
* Swift version 3.0.2
* cocoapods version 1.2.0

### Building

Do a pod install from the root folder, open AirPorts.xcworkspace and do a build.


## Running the tests

* The  test are run by selecting the testing tab on XCode left side panel
* Important:- The unit tests methods will not list in xcode (shows 0 tests) until the unit test target is built and run for tests.After running tests, the target shows the test names, This probably a bug of xcode when using QuickSpec
* When running the automated UI tests, you can see the appilcation simulates the user interactions.To test the app end to end please delete the app from device or simulator before running UI tests

 
