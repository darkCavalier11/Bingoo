![](https://i.imgur.com/SRyJsZN.png)
#  Bingoo App

![](https://i.imgur.com/H4SiUFP.png)

This is a simple app for playing bingo. It uses 3 mode of communication. 
- Device to user communication
- Multipeer communication using `MultipeerConnectivity` framework 
- Firebase Realtime DB for online communication

Application uses a MVVM pattern using Observables and Models provided default by SwiftUI and Combine. Each view is independent of the communication system we are using underneath. Each communication system conform to `BingoCommunication` protocol, which view uses as a base for conducting the game. Internally when we choose which type of the above 3 game we want to play, a communication system of that type initialised and injected into appstate for view to use later. An advantage of this approach is if any future communication comes along, it can easily integrated without messing with views of models.

View relies heavily on SwiftUI components to build bingo grids, update views and stuff. 

App uses `CoreData` to store user name during first install.

For getting started on the online communication with realtime d, create a free firebase project and enable Realtime DB. Download the `GoogleService-Info.plist` file and paste it inside App using XCode.

- <a href ="https://medium.com/@input.split/step-by-step-guide-to-multipeer-connectivity-c66f6a688cd6"> A detail explanation on multipeer connectivity </a> 
- <a href="https://www.flaticon.com/free-icons/bingo" title="bingo icons">Bingo icons created by Freepik - Flaticon</a>

If you want to download the app, [drop a mail](mailto://sumit.pradhan65@gmail.com), and i you will receive a TestFlight link.
