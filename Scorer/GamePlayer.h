//
//  GamePlayer.h
//  Scorer
//
//  Created by Damian Jardim on 9/26/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game, Player, Turn;

@interface GamePlayer : NSManagedObject

@property (nonatomic, retain) Game *game;
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) Turn *turns;

@end
