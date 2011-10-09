//
//  iPhoneRomanNumeralsAppDelegate.h
//  iPhoneRomanNumerals
//
//  Created by Justin Beck on 9/27/11.
//  Copyright 2011 Intalgent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPhoneRomanNumeralsAppDelegate : NSObject <UIApplicationDelegate>
{
    IBOutlet UITextField *origin;
    IBOutlet UILabel *result;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction)buttonPressed:(id)sender;

- (NSString *)convert:(NSString *)from;
- (NSString *)toRoman:(NSString *)candidate;
- (NSString *)toArabic:(NSString *)candidate;
- (NSString *)constructSegment:(char)segment: (NSString *[3])magnitude;
- (NSString *)reverseString:(NSString *)string;
- (NSString *)upCase:(NSString *)string;

@end
