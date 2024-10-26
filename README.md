# Interactable HKActivityRingView Example

This iOS application uses [HKActivitiyRingView](https://developer.apple.com/documentation/healthkit/hkactivityringview) with @State bound to Stepper to show how to display specific date's (n days ago) activity goals.

![ScreenRecording_10-26-202417-47-14_1-ezgif com-optimize](https://github.com/user-attachments/assets/2dccd6a1-0acb-4b65-90bc-3b51159aa19e)

## How to Use
Simply call HKRingView from a view you want to contain it.  
HKRingView has two Named, required arguments:  
- **daysAgo: Binding\<Int>**  
Defines how many days ago to poll the activity goal data. (0 will get today's information, 1 for yesterday...) Pass a @State to this than change it to display/update activity ring. You can pass a value then never change it, but you need to provide an initial value. **Should be positive integer.**
- **radius: CGFloat**  
Defines the radius of the entire ring.

## Compatibility
Should work on **iOS 14.0+**, proven to work on **iOS 18.0+**. Included Xcode project targets iOS 15.0. However I was unable to determine if it really works on the other versions than iOS 18 due to iOS simulator bug that won't allow me to interact with the simulator.
