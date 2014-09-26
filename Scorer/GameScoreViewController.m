//
//  GameScoreViewController.m
//  Scorer
//
//  Created by Damian Jardim on 9/20/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import "GameScoreViewController.h"
#import "PlayerScoreCard.h"

@interface GameScoreViewController () <UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation GameScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    
    

    
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //add to uiscrollview
    PlayerScoreCard *playerSCView = [[PlayerScoreCard alloc]init];
    
    PlayerScoreCard *playerSCView2 = [[PlayerScoreCard alloc]init];
    playerSCView2.view.frame = CGRectMake(playerSCView.view.frame.origin.x +  playerSCView.view.bounds.size.width, 0, playerSCView2.view.bounds.size.width, playerSCView2.view.bounds.size.height);
    
    //UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    //v1.backgroundColor = [UIColor blueColor];
    
    self.scrollView.contentSize = CGSizeMake(playerSCView.view.bounds.size.width * 2, playerSCView.view.bounds.size.height);
    
    NSLog(@"width = %f, height = %f", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    
    [self addChildViewController:playerSCView];
    [playerSCView didMoveToParentViewController:self];
    
    [self addChildViewController:playerSCView2];
    [playerSCView2 didMoveToParentViewController:self];
    
    
    
    [self.scrollView addSubview:playerSCView.view];
    [self.scrollView addSubview:playerSCView2.view];
    
    NSLog(@"playerSCView.view: %@", playerSCView.view);
        NSLog(@"playerSCView2.view: %@", playerSCView2.view);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
