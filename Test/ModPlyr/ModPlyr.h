//
//  Echo.h
//  ModPlyr
//
//  Created by Jesus Garcia on 6/28/13.
//
//


#include "bass.h"


@interface ModPlyr : NSObject

//- (NSString)echo:(CDVInvokedUrlCommand*)command;


- (NSString *)getModPaths;

- (NSMutableArray *) getModDirectoryContents;

- (void) playMod;

@end
