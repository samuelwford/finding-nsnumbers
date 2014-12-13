//
//  AppDelegate.m
//  SWFFindingNumbers
//
//  Created by Samuel Ford on 12/13/14.
//  Copyright (c) 2014 Samuel Ford. All rights reserved.
//

#import "AppDelegate.h"
@import ObjectiveC.runtime;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self enhanceNumberForDebugging];
    return YES;
}

#pragma mark - Make NSNumber Act Like an NSString

- (void)enhanceNumberForDebugging {
    Class numberClass = [NSNumber class];
    Class stringClass = [NSString class];
    
    SEL lengthSelector = @selector(length);
    Method lengthMethodFromNSString = class_getInstanceMethod(stringClass, lengthSelector);
    const char *lengthTypes = method_getTypeEncoding(lengthMethodFromNSString);
    class_addMethod(numberClass, lengthSelector, (IMP)swf_fakeLength, lengthTypes);
    
    SEL boundingRectWithSizeOptionsAttributesContextSelector = @selector(boundingRectWithSize:options:attributes:context:);
    Method boundingRectWithSizeOptionsAttributesContextMethodFromNSString = class_getInstanceMethod(stringClass, boundingRectWithSizeOptionsAttributesContextSelector);
    const char *boundingRectWithSizeOptionsAttributesContextTypes = method_getTypeEncoding(boundingRectWithSizeOptionsAttributesContextMethodFromNSString);
    class_addMethod(numberClass, boundingRectWithSizeOptionsAttributesContextSelector, (IMP)swf_fakeBoundingRectWithSizeOptionsAttributesContext, boundingRectWithSizeOptionsAttributesContextTypes);
    
    SEL rangeOfCharacterFromSetSelector = @selector(rangeOfCharacterFromSet:);
    Method rangeOfCharacterFromSetMethodFromNSString = class_getInstanceMethod(stringClass, rangeOfCharacterFromSetSelector);
    const char *rangeOfCharacterFromSetTypes = method_getTypeEncoding(rangeOfCharacterFromSetMethodFromNSString);
    class_addMethod(numberClass, rangeOfCharacterFromSetSelector, (IMP)swf_fakeRangeOfCharacterFromSet, rangeOfCharacterFromSetTypes);
    
    SEL drawWithRectOptionsAttributesContextSelector = @selector(drawWithRect:options:attributes:context:);
    Method drawWithRectOptionsAttributesContextMethodFromNSString = class_getInstanceMethod(stringClass, drawWithRectOptionsAttributesContextSelector);
    const char *drawWithRectOptionsAttributesContextTypes = method_getTypeEncoding(drawWithRectOptionsAttributesContextMethodFromNSString);
    class_addMethod(numberClass, drawWithRectOptionsAttributesContextSelector, (IMP)swf_fakeDrawWithRectOptionsAttributesContext, drawWithRectOptionsAttributesContextTypes);
}

NSUInteger swf_fakeLength(id self, SEL _cmd) {
    NSLog(@"Faking length on a number with value %@", self);
    NSString *description = [AppDelegate swf_fakeNumberDescription:self];
    return description.length;
}

CGRect swf_fakeBoundingRectWithSizeOptionsAttributesContext(id self, SEL _cmd, CGSize size, NSStringDrawingOptions options, NSDictionary *attributes, NSStringDrawingContext *context) {
    NSString *description = [AppDelegate swf_fakeNumberDescription:self];
    return [description boundingRectWithSize:size options:options attributes:attributes context:context];
}

NSRange swf_fakeRangeOfCharacterFromSet(id self, SEL _cmd, NSCharacterSet *set) {
    NSString *description = [AppDelegate swf_fakeNumberDescription:self];
    return [description rangeOfCharacterFromSet:set];
}

void swf_fakeDrawWithRectOptionsAttributesContext(id self, SEL _cmd, CGRect rect, NSStringDrawingOptions options, NSDictionary *attributes, NSStringDrawingContext *context) {
    NSString *description = [AppDelegate swf_fakeNumberDescription:self];
    [description drawWithRect:rect options:options attributes:attributes context:context];
}

// make the number standout with drawn
+ (NSString *)swf_fakeNumberDescription:(NSNumber *)number {
    return [NSString stringWithFormat:@"##%@##", number];
}

@end
