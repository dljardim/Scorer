//
//  GameScoreViewController.m
//  Scorer
//
//  Created by Damian Jardim on 9/20/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import "GameScoreViewController.h"
#import "PlayerScoreCard.h"

#import "Player.h"
#import "Game.h"
#import "GamePlayer.h"
#import "Turn.h"

@interface GameScoreViewController () <UIScrollViewDelegate, PlayerScoreCardDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *playerScoreCardViewControllerArray;

//selectedPlayers is passed from the last view
//.h @property (nonatomic, strong) NSMutableArray *selectedPlayers;


@end

@implementation GameScoreViewController
{
    BOOL _isLoaded;
}

-(NSMutableArray *)playerScoreCardViewControllerArray{
    if(_playerScoreCardViewControllerArray == nil){
        _playerScoreCardViewControllerArray = [[NSMutableArray alloc]init];
        
        //[self populateScoreCardArray];
        
        
        
        
    }
    return _playerScoreCardViewControllerArray;
}

//todo - send them back to selectgameplayersviewcontroller if no one is selected
-(NSMutableArray *)selectedPlayers{
    if(_selectedPlayers == nil){
        _selectedPlayers = [[NSMutableArray alloc]init];
    }
    return _selectedPlayers;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    DLog();
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set the tab bar item
        self.tabBarItem.title = @"Game";
        
        UIImage *i = [UIImage imageNamed:@"Contact"];
        self.tabBarItem.image = i;
    }
    
    return self;
}

- (void)viewDidLoad {
    DLog();
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //game setup
    //if there is no player - create a new game
    if (!self.game) {
        self.game = [Game MR_createEntity];
    }
    
    //add playergames to the game
    for (Player *player in self.selectedPlayers) {
        
        GamePlayer *gamePlayer = [GamePlayer MR_createEntity];
        PlayerScoreCard *playerSC = [[PlayerScoreCard alloc]init];
        
        //how to associate players and gameplayers
        //gamePlayer.player = player;
        
        [self.game addGamePlayersObject:gamePlayer];
        
        [self.playerScoreCardViewControllerArray addObject:playerSC];
    }
}

-(void)testViewController:(PlayerScoreCard *)viewController{
    DLog();
}


-(void)viewDidAppear:(BOOL)animated{
    DLog();
    [super viewDidAppear:animated];

    //on first run -
    DLog(@"_isLoaded: %@", [NSString stringWithFormat:@"%@", _isLoaded ? @"YES" : @"NO"]);
    if (_isLoaded) {
        return;
    } else {
        _isLoaded = TRUE;
    }
    
    //add to uiscrollview
   
    
        
        PlayerScoreCard *playerSCView = [[PlayerScoreCard alloc]init];
        playerSCView.delegate = self;
        
        PlayerScoreCard *playerSCView2 = [[PlayerScoreCard alloc]init];
        playerSCView2.delegate = self;
        
        PlayerScoreCard *playerSCView3 = [[PlayerScoreCard alloc]init];
        playerSCView3.delegate = self;
        
//        [self.playerScoreCardArray addObject:playerSCView];
//        [self.playerScoreCardArray addObject:playerSCView2];
//        [self.playerScoreCardArray addObject:playerSCView3];
    
        playerSCView2.view.frame = CGRectMake(playerSCView.view.frame.origin.x +  playerSCView.view.bounds.size.width, 0, playerSCView2.view.bounds.size.width, playerSCView2.view.bounds.size.height);
        
        playerSCView3.view.frame = CGRectMake(playerSCView.view.frame.origin.x +  playerSCView.view.bounds.size.width * 2, 0, playerSCView2.view.bounds.size.width, playerSCView2.view.bounds.size.height);
        
        //UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
        //v1.backgroundColor = [UIColor blueColor];
        
        self.scrollView.contentSize = CGSizeMake(playerSCView.view.bounds.size.width * 3, playerSCView.view.bounds.size.height);
        
        //NSLog(@"width = %f, height = %f", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
        
        [self addChildViewController:playerSCView];
        [playerSCView didMoveToParentViewController:self];
        [self.scrollView addSubview:playerSCView.view];
        
        [self addChildViewController:playerSCView2];
        [playerSCView2 didMoveToParentViewController:self];
        [self.scrollView addSubview:playerSCView2.view];
        
        [self addChildViewController:playerSCView3];
        [playerSCView3 didMoveToParentViewController:self];
        [self.scrollView addSubview:playerSCView3.view];
    
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
