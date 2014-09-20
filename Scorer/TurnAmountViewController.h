//
//  TurnAmountViewController.h
//  Scorer
//
//  Created by Damian Jardim on 9/19/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TurnAmountViewController;
@protocol TurnAmountViewControllerDelegate <NSObject>
- (void)updateAmount:(NSNumber *)amount;
@end

@interface TurnAmountViewController : UIViewController

@property (nonatomic, weak) id <TurnAmountViewControllerDelegate> delegate;

//strong ???
@property (nonatomic, weak) NSNumber *inAmount;

@end
