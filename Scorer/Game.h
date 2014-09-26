//
//  Game.h
//  Scorer
//
//  Created by Damian Jardim on 9/25/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Turn;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSNumber * scoreEnd;
@property (nonatomic, retain) NSNumber * scoreStart;
@property (nonatomic, retain) NSSet *turns;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)addTurnsObject:(Turn *)value;
- (void)removeTurnsObject:(Turn *)value;
- (void)addTurns:(NSSet *)values;
- (void)removeTurns:(NSSet *)values;

@end
