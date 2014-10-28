#import <CoreMotion/CoreMotion.h>
#import <notify.h>
#import <libactivator/libactivator.h>
#import "Dropped.h"

#ifdef DEBUG
#define DebugLog(s, ...) NSLog(@"[Dropped] %@", [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define DebugLog(s, ...)
#endif

Dropped *droppedController;

static NSString *fallingID = @"com.milodarling.dropped.falling";
static NSString *stoppingID = @"com.milodarling.dropped.stopping";
NSArray *assignedListenersFalling;
NSArray *assignedListenersStopping;

//method used for giving correct description for each event (thanks uroboro)
static inline unsigned char MDDroppedEventName(NSString *eventName) {
    unsigned char en;
    if ([eventName isEqualToString:fallingID]) {
        en = 0;
    }
    if ([eventName isEqualToString:stoppingID]) {
        en = 1;
    }
    return en;
}

@implementation DroppedDataSource

static DroppedDataSource *MDDroppedDataSource;

+ (void)load {
    @autoreleasepool {
        MDDroppedDataSource = [[DroppedDataSource alloc] init];
    }
}

//Activator stuffs
- (id)init {
    if ((self = [super init])) {
        [LASharedActivator registerEventDataSource:self forEventName:fallingID];
        [LASharedActivator registerEventDataSource:self forEventName:stoppingID];
    }
    return self;
}

//More ativator stuffs
- (void)dealloc {
    [LASharedActivator unregisterEventDataSourceWithEventName:fallingID];
    [LASharedActivator unregisterEventDataSourceWithEventName:stoppingID];
    [super dealloc];
}

//Gives name for each event (thanks uroboro)
- (NSString *)localizedTitleForEventName:(NSString *)eventName {
    unsigned char en = MDDroppedEventName(eventName);
    NSString *title[2] = { @"Falling", @"Hit Ground"};
    return title[en];
}

//Group (goes with "Shake Device")
- (NSString *)localizedGroupForEventName:(NSString *)eventName {
    return @"Motion";
}

//Gives description for each event (thanks uroboro)
- (NSString *)localizedDescriptionForEventName:(NSString *)eventName {
    unsigned char en = MDDroppedEventName(eventName);
    NSString *description[2] = { @"Device is in free fall", @"Device hits the ground"};
    return description[en];
}

- (BOOL)eventWithNameIsHidden:(NSString *)eventName {
    return NO;
}

- (BOOL)eventWithNameRequiresAssignment:(NSString *)eventName {
    return NO;
}

@end

@implementation Dropped

- (id)init{
    if (self=[super init]){
        // Load our preferences
        [self loadPrefs];
    }
    //While this isn't the best way to do it, I currently don't know how to check for changed assignments other than doing it every 30 seconds :/
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(checkAssignments:) userInfo:nil repeats:YES];
    return self;
}

// Did receive preference reload notification
- (void)loadPrefs{
    // Load preferences
    CFPreferencesAppSynchronize(CFSTR("com.milodarling.dropped"));
    fallSensitivity=[(id)CFPreferencesCopyAppValue(CFSTR("fallingSensitivity"), CFSTR("com.milodarling.dropped")) doubleValue];
    DebugLog(@"Falling sensitivity: %.2f", fallSensitivity);
    stopSensitivity=[(id)CFPreferencesCopyAppValue(CFSTR("stoppingSensitivity"), CFSTR("com.milodarling.dropped")) doubleValue];
    DebugLog(@"Stopping sensitivity: %.2f", stopSensitivity);
    
    assignedListenersFalling = [LASharedActivator assignedListenerNamesForEvent:[LAEvent eventWithName:fallingID]];
    assignedListenersStopping = [LASharedActivator assignedListenerNamesForEvent:[LAEvent eventWithName:stoppingID]];
    
    // Setup timer
    [self updateState];
}

- (void)updateState{
    // Destroy objects
    if (_freeFallExecuteTimer!=nil){[_freeFallExecuteTimer invalidate]; _freeFallExecuteTimer=nil;}
    if (manager) [manager stopAccelerometerUpdates];
    
    // Are we completely disabled?
    if (assignedListenersStopping || assignedListenersFalling) {
        DebugLog(@"We have something assigned to us, we're running");
        // Control variables
        falling=NO;
        stopping=NO;
        
        // Setup CoreMotion
        manager=[[CMMotionManager alloc] init];
        manager.accelerometerUpdateInterval=0.01;
        [manager startAccelerometerUpdates];
        
        // Start the timer after a delay (was causing issues with the Preference Pane)
        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(enableTimer:) userInfo:nil repeats:NO];
    } else {
        DebugLog(@"Nothing's assigned, we're not starting the timer or we're killing it.");
        
    }
}

- (void)updateAccelData:(NSTimer *)timer{
    // Calculate acceleration
    double accel=sqrt(pow(manager.accelerometerData.acceleration.x,2) + pow(manager.accelerometerData.acceleration.y,2) + pow(manager.accelerometerData.acceleration.z,2));
    
    // Handle falling
    if (accel<fallSensitivity && !falling){
        falling=YES;
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(doStopFalling:) userInfo:nil repeats:NO];
        LAEvent *event = [LAEvent eventWithName:@"com.milodarling.dropped.falling" mode:[LASharedActivator currentEventMode]];
        [LASharedActivator sendEventToListener:event];
    }
            
    // Handle stopping
    if (accel>stopSensitivity && !stopping && falling){
        stopping=YES;
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(doStopStopping:) userInfo:nil repeats:NO];
        LAEvent *event = [LAEvent eventWithName:@"com.milodarling.dropped.stopping" mode:[LASharedActivator currentEventMode]];
        [LASharedActivator sendEventToListener:event];
    }
}

//check if we're being used (if we aren't we can kill the timer/accelerometer updating to save battery)
-(void)checkAssignments:(NSTimer *)checkActivator { [self loadPrefs]; }
        
- (void)enableTimer:(NSTimer *)timer{
    _freeFallExecuteTimer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateAccelData:) userInfo:nil repeats:YES];
}
        
- (void)doStopFalling:(NSTimer *)timer{ falling=NO; }
- (void)doStopStopping:(NSTimer *)timer{ stopping=NO; }
        
@end
        
static void PreferencesChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo){
    [droppedController loadPrefs];
}

// Set things up
__attribute__((constructor)) static void init() {
    droppedController=[[Dropped alloc] init];
            
    // Handle preference changes
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, PreferencesChanged, CFSTR("com.milodarling.dropped/prefsChanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}