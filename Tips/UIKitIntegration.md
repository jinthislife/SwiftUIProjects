I have decided to partially apply SwiftUI in my legacy UIKit SpellGame project.


I replaced GameListViewController with HomeView written in SwiftUI. GameListViewController is the first view users see when SpellGame app is launched and it is pushed onto the window root UINavigationContoller. 

**Nest SwiftUI View in UIHostingViewController to push SwiftUI View onto UINavigationController.**
- UIKit -> SwiftUI

```swift
let homeView: some View = HomeView()
let homeViewHostingController = UIHostingController(rootView: homeView)
navigationController.pushViewController(homeViewHostingController, animated: false)
```


When users tap on challenge section in HomeView, SpellGameViewController should be pushed through NavigationLink embeded in Challenge section.

**Use UIViewControllerRepresentable to navigate to UIViewController from SwiftUI.**
- SwiftUI -> UIKit

```swift
struct SpellGameViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SpellGameViewController {
        let vc = SpellGameViewController.instantiate()
        vc.game.quizSet = QuizMaster.today.quizSets[0]
        return vc
    }
}
```

```swift
NavigationLink(destination: SpellGameViewControllerWrapper()) {
  VStack {
      ...
  }
}
```

Once this change made, one issue you will experience is the title of SpellGameViewController is not updated when SpellGame progresses.
The reason for this is SpellGameViewController's parent is not UINavigationController any more. Rather, its parenet is an wrapper view controller.

**So, to set the title or bar buttons items or toolbar items from UIViewController, you need to set them on it's parent as such:**
- Setting UINavigationBar title, items in UIViewController wrapped in UIViewControllerRepresentable

```swift
parent?.navigationItem.title = quizProgress 
```

Furthermore, you cannot do this from viewDidLoad, because the view controller does not appear to have been wrapped by the SwiftUI parent by that time. You have to do it in viewWillAppear.

## Reference
- [stackoverflow: UIViewControllerRepresentable: Navigation Title and Bar Button Items Ignored in NavigationView](https://stackoverflow.com/questions/59295507/uiviewcontrollerrepresentable-navigation-title-and-bar-button-items-ignored-in)
