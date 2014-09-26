//
//  Game.h
//  Scorer
//
//  Created by Damian Jardim on 9/26/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GamePlayer;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSNumber * scoreEnd;
@property (nonatomic, retain) NSNumber * scoreStart;
@property (nonatomic, retain) NSString * winnerName;
@property (nonatomic, retain) NSSet *gamePlayers;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)addGamePlayersObject:(GamePlayer *)value;
- (void)removeGamePlayersObject:(GamePlayer *)value;
- (void)addGamePlayers:(NSSet *)values;
- (void)removeGamePlayers:(NSSet *)values;

@end
