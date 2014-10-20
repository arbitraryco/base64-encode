//
//  NSSound+SystemSounds.h
//  Base64 Encode
//
//  Created by Jamie Kosoy on 10/20/14.
//  Copyright (c) 2014 Arbitrary. All rights reserved.
//
// https://stackoverflow.com/questions/10949138/sound-picker-list-of-system-sounds

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface NSSound (SystemSounds)

+ (NSDictionary *) systemSounds;
+ (NSSound *)systemSoundWithName:(NSString *)name;

@end