//
//  Player.h
//  Scorer
//
//  Created by Damian Jardim on 9/26/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * playerName;
@property (nonatomic, retain) NSNumber * wins;
@property (nonatomic, retain) NSNumber * losses;
@property (nonatomic, retain) NSSet *gamePlayer;
@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addGamePlayerObject:(NSManagedObject *)value;
- (void)removeGamePlayerObject:(NSManagedObject *)value;
- (void)addGamePlayer:(NSSet *)values;
- (void)removeGamePlayer:(NSSet *)values;

@end
