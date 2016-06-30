

# Location Trivia - Data Store Relationships

## Goals

1. Set up a shared data store using a singleton.
2. Use a shared instance to pass information between a group of view controllers.

## Review

From time to time, we may want one instance of a class (and whatever data it holds onto) to be accessed by many other objects in your program. This is very useful for organizing your application's data into one place—hence the designation in this case of "Data Store." One way to accomplish this is with a **shared instance** of that class. A shared instance is typically accessed by a class method which creates only one instance over the lifetime of the application. Any and all calls to that class method return the one instance already instantiated. You'll often hear this referred to as a "singleton." 

The `dispatch_once` function from Grand Central Dispatch (GCD) is what permits this behavior. It's kind of like a punch card that reads 'admit one.' It retains all of its identifying information, but won't permit the application to run the block argument more than once. In the current case, that means only instantiating the shared instance one time. If we were to take the Objective-C code for creating a singleton and translate it to Swift, it would look like this:

```swift
class DataStore {
    class var sharedInstance: DataStore {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: DataStore? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = DataStore()
        }
        return Static.instance!
    }
}
```

However, this method is excessively verbose and ultimately unnecessary. In fact, *you should never use the code above*. Instead, use the following to create a shared instance in Swift:

```swift
class DataStore {
    static let sharedInstance = DataStore()
    private init() {}
}
```

Isn't that so much nicer? Let's break the code down to see what's happening.

<you have to make sure your inits are private. This ensures your singletons are truly unique and prevents outside objects from creating their own instances of your class through virtue of access control. Since all objects come with a default public initializer in Swift, you need to override your `init` and make it private. This isn't too hard to do and still ensures our one line singleton is nice and pretty>

By initializing your `sharedInstance` as `static`, you prevent subclasses from overriding its method(?). By using `let`, you ensure that the `sharedInstance` cannot be overwritten. 

The `private init() {}` prevents others from using the default initializer for this class and thus ensures only one instance is created. Note that we use the class name `Singleton` only for clarity's sake, but the class can have any name.

In the scope of this lab we're going to call this class `LocationsDataStore` meaning we need to write out our data store as follows:

```swift
class LocationsDataStore {
    static let sharedInstance = LocationsDataStore()
    private init() {}
}
```

```swift
+ (instancetype)sharedLocationsDataStore {
    static LocationsDataStore *_sharedLocationsDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLocationsDataStore = [[LocationsDataStore alloc] init];
    });

    return _sharedLocationsDataStore;
}
```

You'll notice that it's calling a standard `init` on the class, so we'll need to customize that. Since we want our data store to hold our `Location` objects, let's give it a property that's an `Array` called 'locations' and instantiate it in the initializer.

```swift
// LocationsDataStore.h

@property (strong, nonatomic) NSMutableArray *locations;
```

```swift
// LocationsDataStore.m

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locations = [[NSMutableArray alloc] init];
    }
    return self;
}
```

Now that we have our singleton class set up, we can access it from any view controller by calling the `shared<#name#>` method that we previously set up.

```swift
- (void)viewDidLoad {
	[super viewDidLoad];
	
    LocationsDataStore *locationsDataStore = 
        [LocationsDataStore sharedLocationsDataStore];
}
```

This next lab already has these steps set up for you. Take a moment to look over the data store's files to see how they're laid out, then solve the lab by connecting a new view controller to the data store.

## Instructions

1. The previously-used `Location` and `Trivium` data models have been provided for you. Set up the `LocationsDataStore` class to be a singleton class. It should have one property, an `NSMutableArray` called `locations`. Override the default initializer to populate the `locations` array with the starting data provided at the end of this readme in the `generateStartingLocationsData` method.

2. Create a storyboard named `Main.storyboard`. Add a table view controller embedded in a navigation controller which is the initial view controller. This first table view controller should be connected to a class called `LocationsTableViewController`.
  * In `viewDidLoad`, set the `tableView` property's accessibility label & identifier to `@"Locations Table"` (this cannot be done in Interface Builder).
  * Give the table view controller a `LocationsDataStore` property called `store` and use the "shared instance" method to instantiate it.
  * In storyboard, set the table view's prototype cell type to "right detail". Have the table view use the `textLabel` to show the name of the locations, and the `detailTextLabel` to display the number of trivia it has associated with it.

3. Add a second table view controller named `TriviaTableViewController` accessed by a show segue from a table view cell in the locations table view controller. In `viewDidLoad`, set the `tableView`'s accessibility label & identifier to `@"Trivia Table"`.
  * Give the view controller a `Location` property called `location`, which should be set with the relevant `Location` object in `LocationsTableViewController`'s `prepareForSegue:sender:` method.
  * Use the `location` property's `trivia` array to load the table view. Each cell should display the `Trivium` object's "content" in the `textLabel`, and the number of "likes" in the `detailTextLabel`.

4. Create a new view controller named `AddLocationViewController` that will be presented modally from the locations table view controller. 
  * Add three text fields for the name, latitude, and longitude. Set their accessibility labels & identifiers to `@"nameField"`, `@"latitudeField`, and `@"longitudeField"` respectively.
  * Add two buttons, one to "cancel" adding a location, and one to "save" a new location with the information entered in the text fields. Set their accessibility labels & identifiers to `@"cancelButton"` and `@"saveButton"` respectively.
  * When the "cancel" button is tapped, dismiss the view controller.
  * When the "submit" button is tapped, use the information in the text fields to create new a instance of `Location` and add it the the data store's `locations` array. Then dismiss the view controller.

5. To access this new view controller, add a bar button item to the navigation bar in the location table view's storyboard canvas. Set the style to "add" so it shows a `+` sign. In the `LocationsTableViewController`'s `viewDidLoad` method, set this new button's accessibility label & identifier to `@"addButton"`. You can access it as a property via `self.navigationItem.rightBarButtonItem` and set the string properties from there.
  * Create a modal segue between this add button and the `AddLocationViewController`. Now that you have two segues, you'll need to detect which segue has been activated in the `prepareForSegue:` method — only one of the destination view controllers has a `location` property that can be set.

6. Use the iOS Simulator to test your add-location view controller. You may notice that the new location doesn't appear in the locations table view, even though the data has been added. How can you get the table view to reload itself?

7. Create another view controller named `AddTriviaTableViewController` to be presented modally from the the trivia table view controller. It will need one text field, a cancel button, and a save button. Set their accessibility labels & identifiers to `@"Trivium Text Field"`, `@"Cancel Button"`, and `@"Save Button"` respectively.
  * When the cancel button is tapped, dismiss the view controller.
  * When the submit button is tapped, add use the text field to create a new `Trivium` object with zero likes. Add the this new trivium to the relevant `Location` object that was passed to the `TriviaTableViewController`. Then dismiss the view controller.

8. To access this last view controller, add a bar button to the navigation bar in the trivia table view's storyboard canvas. Set the style to "add" so it shows a `+` sign. In the `TriviaTableViewController`'s `viewDidLoad` method, set this new button's accessibility label & identifier to `@"Add Trivia Button"`.  You can access this it as a property via `self.navigationItem.rightBarButtonItem` and set the string properties from there.
  * Create a modal segue between the add button and the `AddTriviaViewController`.

9. Use the iOS Simulator to test your add-trivia view controller. Does the new trivium show up in the `TriviaTableViewController`?

#### Starting Data

```swift
func generateStartingLocationsData() {
    
    let empireState = Location.init(name: "The Empire State Building", latitude: 40.7484, longitude: -73.9857)
    let trivium1A = Trivium.init(content: "1,454 Feet Tall", likes: 4)
    let trivium1B = Trivium.init(content: "Cost $24,718,000 to build", likes: 2)
    empireState.trivia.appendContentsOf([trivium1A, trivium1B])
    
    let bowlingGreen = Location.init(name: "Bowling Green", latitude: 41.3739, longitude: -83.6508)
    let trivium2A = Trivium.init(content: "NYC's oldest park", likes: 8)
    let trivium2B = Trivium.init(content: "Made a park in 1733", likes: 2)
    let trivium2C = Trivium.init(content: "Charging Bull was created in 1989", likes: 0)
    bowlingGreen.trivia.appendContentsOf([trivium2A, trivium2B, trivium2C])
    
    let ladyLiberty = Location.init(name: "Statue Of Liberty", latitude: 40.6892, longitude: -74.0444)
    let trivium3A = Trivium.init(content: "Gift from France", likes: 6)
    ladyLiberty.trivia.append(trivium3A)
    
    self.locations.appendContentsOf([bowlingGreen, empireState, ladyLiberty])
}
```

## Advanced

Add functionality to get the users actual location. Beware that significant changes to `CLLocation` were made with iOS 8, so resources older than September 2014 might be incorrect.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/locationTrivia-DataStoreRelationships' title='Location Trivia - Data Store Relationships'>Location Trivia - Data Store Relationships</a> on Learn.co and start learning to code for free.</p>
