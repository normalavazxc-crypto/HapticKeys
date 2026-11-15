// HapticKeys/Tweak.x — Crisp keyboard haptic feedback for iOS 16 (rootless)

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

static UIImpactFeedbackGenerator *gFeedbackGen = nil;
static CFTimeInterval gLastHapticTime = 0;

static void HapticKeysTrigger(void) {
    CFTimeInterval now = CACurrentMediaTime();
    if (now - gLastHapticTime < 0.015) {
        return;
    }
    gLastHapticTime = now;

    if (!gFeedbackGen) {
        gFeedbackGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    }
    [gFeedbackGen impactOccurredWithIntensity:0.85];
    [gFeedbackGen prepare];
}

%hook UIKeyboardLayoutStar

- (void)touchDownWithKey:(id)key atPoint:(CGPoint)point executionContext:(id)ctx {
    HapticKeysTrigger();
    %orig;
}

- (void)didMoveToWindow {
    %orig;
    if (self.window) {
        if (!gFeedbackGen) {
            gFeedbackGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        }
        [gFeedbackGen prepare];
    }
}

%end

%ctor {
    @autoreleasepool {
        %init;
    }
}
