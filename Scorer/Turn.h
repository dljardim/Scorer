//
//  Turn.h
//  Scorer
//
//  Created by Damian Jardim on 9/26/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GamePlayer;

@interface Turn : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) GamePlayer *gamePlayer;

@end
