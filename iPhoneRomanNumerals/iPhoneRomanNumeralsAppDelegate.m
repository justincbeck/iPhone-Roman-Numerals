//
//  iPhoneRomanNumeralsAppDelegate.m
//  iPhoneRomanNumerals
//
//  Created by Justin Beck on 9/27/11.
//  Copyright 2011 Intalgent. All rights reserved.
//

// Steve Jobs died today - So sad; what an amazing man - You'll be missed, Steve

#import "iPhoneRomanNumeralsAppDelegate.h"

@implementation iPhoneRomanNumeralsAppDelegate

const static NSString *ONE[3] = {@"I", @"V", @"X"};
const static NSString *TEN[3] = {@"X", @"L", @"C"};
const static NSString *HUNDRED[3] = {@"C", @"D", @"M"};
const static NSString *THOUSAND[3] = {@"M"};

const static NSDictionary *THE_MAP;

@synthesize window;

+ (void)initialize
{
    THE_MAP = [[NSDictionary alloc] initWithObjectsAndKeys:
               [NSNumber numberWithInt: 1], @"I",
               [NSNumber numberWithInt: 5], @"V",
               [NSNumber numberWithInt: 10], @"X",
               [NSNumber numberWithInt: 50], @"L",
               [NSNumber numberWithInt: 100], @"C",
               [NSNumber numberWithInt: 500], @"D",
               [NSNumber numberWithInt: 1000], @"M",
               NULL]; 
}

- (IBAction)buttonPressed:(id)sender
{
    NSString *candidate = [origin text];
    NSString *converted = [self convert:(NSString *) candidate];
    
    [result setText:converted];
}

- (NSString *)convert:(NSString *)candidate
{
    NSRegularExpression *arabicRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\d+$" options:0 error:NULL];
    NSUInteger numberOfArabicMatches = [arabicRegex numberOfMatchesInString:candidate options:0 range:NSMakeRange(0, [candidate length])];
    
    NSRegularExpression *romanRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\w+$" options:0 error:NULL];
    NSUInteger numberOfRomanMatches = [romanRegex numberOfMatchesInString:candidate options:0 range:NSMakeRange(0, [candidate length])];
    
    
    if (numberOfArabicMatches == 1)
    {
        if ([candidate integerValue] > 3999)
        {
            NSLog(@"Arabic must be less than 4000!");
            return @"Arabic must be less than 4000!";
        }
        return [self toRoman:(NSString *) candidate];
    }
    else if (numberOfRomanMatches == 1)
    {
        return [self toArabic:(NSString *) candidate];
    }
    else
    {
        return @"Invalid Entry!";
    }
}

- (NSString *)toRoman:(NSString *)arabic
{
    NSString *candidate = [self reverseString:arabic];
    NSMutableArray *romanArray = [[NSMutableArray alloc] init];
    NSMutableString *roman = [[NSMutableString alloc] init];
    NSUInteger length = [candidate length];
    
    for (NSUInteger i = 0; i < length; i++)
    {
        unichar character = [candidate characterAtIndex:i];
        long sum = pow(10, (i + 1));
        
        switch(sum)
        {
            case 10:
                [romanArray addObject:[self constructSegment:character: ONE]];
                break;
            case 100:
                [romanArray addObject:[self constructSegment:character: TEN]];
                break;
            case 1000:
                [romanArray addObject:[self constructSegment:character: HUNDRED]];
                break;
            case 10000:
                [romanArray addObject:[self constructSegment:character: THOUSAND]];
                break;
        }
    }
    
    NSEnumerator *romanEnum = [romanArray reverseObjectEnumerator];
    id segment;
    while (segment = [romanEnum nextObject]) {
        [roman appendString:segment];
    }
    
    return roman;
}

- (NSString *)toArabic:(NSString *)roman
{
    NSMutableArray *arabic = [[NSMutableArray alloc] init];
    NSMutableArray *segments = [[NSMutableArray alloc] init];
    NSString *upperRoman = [self upCase: roman];
    NSInteger length = [upperRoman length];
    
    for (NSInteger i = 0; i < length; i++) {
        unichar character = [upperRoman characterAtIndex:i];
        NSMutableString *tempString = [[NSMutableString alloc] init];
        [tempString appendFormat:@"%c",character];
        NSString *num = [THE_MAP objectForKey:tempString];
        [segments addObject: num];
    }
    
    NSEnumerator *segEnum = [segments objectEnumerator];
    id segment;
    while (segment = [segEnum nextObject])
    {
        NSInteger value = [segment integerValue];
        if ([arabic count] > 0 && [[arabic lastObject] integerValue] < value)
        {
            NSInteger sum = value - [[arabic lastObject] integerValue];
            NSInteger index = [arabic indexOfObject:[arabic lastObject]];
            [arabic replaceObjectAtIndex:index withObject:[NSNumber numberWithInteger:sum]];
        }
        else
        {
            [arabic addObject: segment];
        }
    }
    
    NSInteger total = 0;
    NSEnumerator *arabEnum = [arabic objectEnumerator];
    id arab;
    while (arab = [arabEnum nextObject])
    {
        total += [arab integerValue];
    }
    
    return [NSString stringWithFormat:@"%d", total];
}

- (NSString *)constructSegment:(char)segment: (NSString *[3])magnitude
{
    NSMutableString *roman = [[NSMutableString alloc] init];
    
    if (segment == '9')
    {
        [roman appendString:magnitude[0]];
        [roman appendString:magnitude[2]];
    }
    else if (segment > '5')
    {
        [roman appendString:magnitude[1]];
        int seg = (int) segment - 48;
        for (NSUInteger i = 0; i < (seg - 5); i++)
        {
            [roman appendString:magnitude[0]];
        }
    }
    else if (segment == '5')
    {
        [roman appendString:magnitude[1]];
    }
    else if (segment == '4')
    {
        [roman appendString:magnitude[0]];
        [roman appendString:magnitude[1]];
    }
    else
    {
        int seg = (int) segment - 48;
        for (NSUInteger i = 0; i < seg; i++)
        {
            [roman appendString:magnitude[0]];
        }
    }
    
    return roman;
}

- (NSString *) reverseString: (NSString *)string
{
    NSUInteger length = [string length];
    NSMutableString *rtr=[NSMutableString stringWithCapacity:length];
    
    while (length > (NSUInteger)0) { 
        unichar uch = [string characterAtIndex:--length]; 
        [rtr appendString:[NSString stringWithCharacters:&uch length:1]];
    }
    return rtr;
}

- (NSString *) upCase: (NSString *)string
{
    // TODO: This needs to be written
    return string;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [window release];
    [origin release];
    [result release];
    [super dealloc];
}

@end
