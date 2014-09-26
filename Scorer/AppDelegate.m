//
//  AppDelegate.m
//  Scorer
//
//  Created by Damian Jardim on 9/19/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import "AppDelegate.h"


#import "PlayerScoreCard.h"
#import "GameScoreViewController.h"
#import "PlayersViewController.h"
#import "CreatePlayerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //testing source control dd
    [self setWindow:[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]]];
    
    //todo: clean up imports
    //PlayerScoreCard *vc = [[PlayerScoreCard alloc]init];
    //GameScoreViewController *vc = [[GameScoreViewController alloc]init];
    PlayersViewController *vc = [[PlayersViewController alloc]init];
    //CreatePlayerViewController *vc = [[CreatePlayerViewController alloc]init];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:vc];

    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    
    //Setup MagivalRecord & CoreData
   [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"Scorer.sqlite"];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

@end
