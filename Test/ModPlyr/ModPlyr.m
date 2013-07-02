//
//  Echo.m
//  ModPlyr
//
//  Created by Jesus Garcia on 6/28/13.
//
//

#import "ModPlyr.h"


#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>




@implementation ModPlyr : NSObject



- (NSMutableArray *) getModDirectoryContents {
    NSMutableArray *paths = [[NSMutableArray alloc] init];
    
    NSString *appUrl    = [[NSBundle mainBundle] bundlePath];
    NSString *modsUrl   = [appUrl stringByAppendingString:@"/mods"];
    NSURL *directoryUrl = [[NSURL alloc] initFileURLWithPath:modsUrl] ;
    
    
    NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
    
    NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    
    NSDirectoryEnumerator *enumerator = [fileManager
                                         enumeratorAtURL : directoryUrl
                                         includingPropertiesForKeys : keys
                                         options : 0
                                         errorHandler : ^(NSURL *url, NSError *error) {
                                             //Handle the error.
                                             // Return YES if the enumeration should continue after the error.
                                             return YES;
                                         }];
    
    for (NSURL *url in enumerator) {
        NSError *error;
        NSNumber *isDirectory = nil;
        if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
            //handle error
        }
        else if (! [isDirectory boolValue]) {
//            NSLog(@"%@", [url lastPathComponent]);

            [paths addObject:url];
        }
    }
    
    return paths;
}

- (NSString *) getModPaths {
    NSMutableArray *paths = [self getModDirectoryContents];
    NSMutableArray *pathDictionaries = [[NSMutableArray alloc] init];
    
    for (NSURL *url in paths) {
        NSDictionary *jsonObj = [[NSDictionary alloc] initWithObjectsAndKeys:
            [url lastPathComponent], @"fileName",
            [url path], @"path",
            nil
        ];
        
        [pathDictionaries addObject:jsonObj];

    }
    
    
    
    NSError *jsonError;
            
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:pathDictionaries options:NSJSONWritingPrettyPrinted error:&jsonError];
    NSString *jsonDataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return jsonDataString;
}
//
//- (void)playSong:(CDVInvokedUrlCommand*)command {
//    NSMutableArray *paths = [self getModDirectoryContents];
//    
//    NSURL *oneUrl = [paths objectAtIndex: 3];
//    
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//	NSError *err = nil;
//    
//	[session setActive: YES error: &err];
//	[session setCategory:AVAudioSessionCategoryPlayback error:&err];
//
////    //	[session setPreferredHardwareSampleRate:44100.00 error:&err];
////
//
//     
//    NSLog(@"oneUrl Song: %@", [oneUrl path]);
////    
//    [self playMod:[oneUrl path]];
//    
//    CDVPluginResult* pluginResult = nil;
//    
//    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[oneUrl lastPathComponent]];
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
//    NSLog(@"HERE");
//}
//

- (void)playMod:(NSString*)file {
    

    if (!BASS_Init(-1,44100,0,NULL,NULL)) {
		NSLog(@"Can't initialize device");
    }
    
    BASS_Free();

    // file = "/Users/jgarcia/Library/Application Support/iPhone Simulator/6.1/Applications/7E414817-8953-445B-AB98-26C3FE4073DE/Test.app/mods/BAND - Manhattan Dealers intro_2.xm"
    HMUSIC modFile;
    
    
    modFile = BASS_MusicLoad(FALSE,[file UTF8String],0,0,BASS_MUSIC_RAMPS,1);
    
    if (! modFile) {
        NSLog(@"Could not load file: %@", file);
    }
    else {
        BASS_ChannelPlay(modFile, FALSE); // play the stream
    }
    

}

@end

