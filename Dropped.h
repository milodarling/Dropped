@interface Dropped : NSObject{
	CMMotionManager *manager;
	bool stopping;
	NSTimer *_freeFallExecuteTimer;
	double fallSensitivity;
	double stopSensitivity;
	bool falling;
}
	@property (nonatomic,retain) NSDictionary *prefs;
	-(void)loadPrefs;
	-(void)updateAccelData:(NSTimer *)timer;
	-(void)doStopFalling:(NSTimer *)timer;
	-(void)doStopStopping:(NSTimer *)timer;
    -(void)checkAssignments:(NSTimer *)checkActivator;
	- (void)updateState;
@end

@interface DroppedDataSource: NSObject <LAEventDataSource> {
}

@end