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
    IBOutlet UIWindow *window;
    IBOutlet UITextField *origin;
    IBOutlet UITextField *result;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITextField *origin;
@property (nonatomic, retain) IBOutlet UITextField *result;

- (IBAction)buttonPressed:(id)sender;

@end
