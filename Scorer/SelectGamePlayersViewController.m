//
//  SelectGamePlayersViewController.m
//  Scorer
//
//  Created by Damian Jardim on 9/26/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import "SelectGamePlayersViewController.h"
#import "GameScoreViewController.h"

#import "Player.h"
#import "Game.h"
#import "GamePlayer.h"
#import "Turn.h"

@interface SelectGamePlayersViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, strong) NSMutableArray *selectedPlayers;

@end

@implementation SelectGamePlayersViewController

-(NSMutableArray *)players{
    if (_players == nil){
        _players = [[NSMutableArray alloc]init];
    }
    return _players;
}

-(NSMutableArray *)selectedPlayers{
    if (_selectedPlayers == nil){
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
        self.tabBarItem.title = @"Players";
        
        UIImage *i = [UIImage imageNamed:@"Contact"];
        self.tabBarItem.image = i;
    }
    
    return self;
}

- (void)viewDidLoad {
    DLog();
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Select Players";
    
    //deals with navigationbar(44) and statusbar(20)
    //self.navigationController.navigationBar.translucent = NO;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    [self fetchAllPlayers];
    
    //fixes the issue of showing empty rows
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //[self setupUI];
    [self setupNavigationBar];
}



-(void)setupNavigationBar{
    // add our custom image button as the nav bar's custom right view
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Next"]
                                                                  style:UIBarButtonItemStylePlain target:self action:@selector(rightButttonTap:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

-(void)rightButttonTap:(id)sender{

    //use the selectedArray to setup GameScoreViewController
    GameScoreViewController *vcGameScore = [[GameScoreViewController alloc]init];
    vcGameScore.selectedPlayers = self.selectedPlayers;
    //present vc
    [self.navigationController pushViewController:vcGameScore animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    DLog();
    [super viewWillAppear:animated];
    
    [self fetchAllPlayers];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    DLog();
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fetchAllPlayers {
    
    // Fetch entities with MagicalRecord
    self.players = [[Player MR_findAll]mutableCopy];
}


#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.players.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Player *player = self.players[indexPath.row];
    

    
    cell.textLabel.text = player.playerName;
    cell.textLabel.font = DEFAULT_FONT;
    
    return cell;
    
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        Player *player = [self.players objectAtIndex:indexPath.row];
//        [player MR_deleteEntity];
//        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//        
//        [self.players removeObjectAtIndex:indexPath.row];
//        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
//    }
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Player *player = [self.players objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    
    if([self.selectedPlayers containsObject:player]){
        //remove it from selected
        [self.selectedPlayers removeObject:player];
        //uncheck
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }else{
        //add it from selected
        [self.selectedPlayers addObject:player];
        //check
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
}

#pragma mark -


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
