//
//  GameScoreViewController.h
//  Scorer
//
//  Created by Damian Jardim on 9/20/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Game;

@interface GameScoreViewController : UIViewController

//selectedPlayers is passed from the last view
@property (nonatomic, strong) NSMutableArray *selectedPlayers;

@property (nonatomic, strong) Game *game;

@end
