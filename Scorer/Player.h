//
//  Player.h
//  Scorer
//
//  Created by Damian Jardim on 9/25/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Turn;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * playerName;
@property (nonatomic, retain) NSSet *turns;
@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addTurnsObject:(Turn *)value;
- (void)removeTurnsObject:(Turn *)value;
- (void)addTurns:(NSSet *)values;
- (void)removeTurns:(NSSet *)values;

@end
