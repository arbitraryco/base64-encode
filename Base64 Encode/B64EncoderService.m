//
//  B64EncoderService.m
//  Base64 Encode
//
//  Created by Jamie Kosoy on 10/19/14.
//  Copyright (c) 2014 Arbitrary. All rights reserved.
//

#import "B64EncoderService.h"
#import "NSSound+SystemSounds.h"

@interface B64EncoderService()
    - (NSString *)guessMIMETypeFromFile:(NSString *)file;
    - (void)displayError:(NSString *)err;
@end

@implementation B64EncoderService

+ (B64EncoderService *) service {
    return [[B64EncoderService alloc] init];
}

#pragma mark

-(id)init {
    self = [super init];

    if(self) {
        NSUpdateDynamicServices();
    }
    
    return self;
}

-(void)encodeFile:(NSPasteboard *)pboard userData: (NSString *)userData error:(NSString **)errorMessagePtr {
//    NSLog(@"Encode!");

    
    if (![[pboard types] containsObject:NSFilenamesPboardType] ) {
        *errorMessagePtr = NSLocalizedString(@"Please use finder for this service.", nil);
        [self displayError:@"Please use finder for this service."];
        return;
    }
    
    NSArray *filenames = [pboard propertyListForType:NSFilenamesPboardType];
    
    if(filenames.count == 0) {
        *errorMessagePtr = NSLocalizedString(@"Something went wrong with the file you selected.", nil);
        [self displayError:@"Something went wrong with the file you selected."];
        return;
    }

    NSString *filePath = filenames[0];
    BOOL isDir;
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir] && isDir) {
        *errorMessagePtr = NSLocalizedString(@"You can't Bsae64 encode a directory.", nil);
        [self displayError:@"You can't Base64 encode a directory (or app). Maybe zip it first?"];
        return;
    }
    unsigned long long fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil].fileSize;

    if(fileSize > 10000000) {
        *errorMessagePtr = NSLocalizedString(@"For safety, we don't encode files larger than 10MB.", nil);
        [self displayError:@"The file you chose is larger than 10MB. As a precaution we won't copy anything that large to your clipboard. Aborting."];
        return;
    }

    NSString *mimeType = [self guessMIMETypeFromFile:filePath];
    
//    NSLog(@"%@", filePath);
//    NSLog(@"%@", mimeType);
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];

    NSData *base64FileData = [fileData base64EncodedDataWithOptions:0];
    NSString *base64FileDataString = [NSString stringWithUTF8String:base64FileData.bytes];

    NSString *webReadyString = [NSString stringWithFormat:@"data:%@;base64,%@", mimeType, base64FileDataString];

    // paste back to the clipboard
    NSPasteboard *generalPasteboard = [NSPasteboard generalPasteboard];
    [generalPasteboard declareTypes:@[NSStringPboardType] owner:nil];
    [generalPasteboard setString:webReadyString forType:NSStringPboardType];

    // play a success sound
    [[NSSound systemSoundWithName:@"Glass"] play];
}

- (void)displayError:(NSString *)err {
//    NSLog(@"Error :: %@", err);

    NSAlert *alert = [[NSAlert alloc] init];
    alert.alertStyle = NSWarningAlertStyle;
    alert.messageText = @"Base64 Encode";
    alert.informativeText = err;
    [alert addButtonWithTitle:@"Okay"];

    // play an error sound
    [[NSSound systemSoundWithName:@"Funk"] play];

    // then show the error
    [alert runModal];
}

- (void)beep {
    [[NSSound systemSoundWithName:@"Glass"] play];
}

- (NSString *)guessMIMETypeFromFile: (NSString *)fileName {
    // http://stackoverflow.com/questions/2439020/wheres-the-iphone-mime-type-database

    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[fileName pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
    CFRelease(UTI);

    if (!MIMEType) {
        return @"application/octet-stream";
    }
    return (__bridge NSString *)(MIMEType);
}


@end
