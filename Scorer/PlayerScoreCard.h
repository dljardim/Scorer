//
//  LaunchViewController.h
//  Scorer
//
//  Created by Damian Jardim on 9/19/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerTurnTableViewCell.h"
#import "TurnAmountViewController.h"

@class PlayerScoreCard;

@protocol PlayerScoreCardDelegate <NSObject>

-(void)testViewController:(PlayerScoreCard *)viewController;

@end

@interface PlayerScoreCard : UIViewController <TurnAmountViewControllerDelegate>

@property (nonatomic, weak) id <PlayerScoreCardDelegate> delegate;

@end
