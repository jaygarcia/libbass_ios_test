//
//  MCAppDelegate.h
//  Test
//
//  Created by Jesus Garcia on 7/2/13.
//  Copyright (c) 2013 Modus Create. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
