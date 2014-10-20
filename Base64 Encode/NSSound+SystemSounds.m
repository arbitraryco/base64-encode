//
//  NSSound+SystemSounds.m
//  Base64 Encode
//
//  Created by Jamie Kosoy on 10/20/14.
//  Copyright (c) 2014 Arbitrary. All rights reserved.
//


#import "NSSound+SystemSounds.h"

@implementation NSSound (systemSounds)

static NSDictionary *systemSounds = nil;

+ (NSDictionary *) systemSounds {
    if ( !systemSounds )
    {
        NSMutableDictionary *returnDict = [NSMutableDictionary dictionary];
        NSEnumerator *librarySources = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSAllDomainsMask, YES) objectEnumerator];
        NSString *sourcePath;
        
        while ( sourcePath = [librarySources nextObject] )
        {
            NSEnumerator *soundSource = [[NSFileManager defaultManager] enumeratorAtPath: [sourcePath stringByAppendingPathComponent: @"Sounds"]];
            NSString *soundFile;
            while ( soundFile = [soundSource nextObject] ) {
                NSSound *sound = [NSSound soundNamed: [soundFile stringByDeletingPathExtension]];
                returnDict[ [soundFile stringByDeletingPathExtension] ] = sound;
            }
        }
        
        systemSounds = [NSDictionary dictionaryWithDictionary:returnDict];
    }

    return systemSounds;
}

+ (NSSound *)systemSoundWithName:(NSString *)name {
    NSDictionary *sounds = [self systemSounds];   
    return sounds[name];
}

@end
