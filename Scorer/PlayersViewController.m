//
//  PlayersViewController.m
//  Scorer
//
//  Created by Damian Jardim on 9/25/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import "PlayersViewController.h"
#import "Player.h"
#import "CreatePlayerViewController.h"

@interface PlayersViewController ()

@property (nonatomic, strong) NSMutableArray *players;
@property (weak, nonatomic) IBOutlet UIButton *btnCreatePlayer;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlayersViewController

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
    self.title = @"PlayersViewController";
    
    //deals with navigationbar(44) and statusbar(20)
    self.navigationController.navigationBar.translucent = NO;
    
    
    [self fetchAllPlayers];
    
    //fixes the issue of showing empty rows
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self setupUI];
}

-(void)setupUI{
    self.btnCreatePlayer.titleLabel.font = DEFAULT_FONT;
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
- (IBAction)btnCreatePlayerTap:(id)sender {
    CreatePlayerViewController *vc = [[CreatePlayerViewController alloc]init];
    [self.navigationController presentViewController:vc animated:YES completion:^{
        
    }];
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
    
    NSLog(@"player.playerName = %@", player.playerName);
    
    cell.textLabel.text = player.playerName;
    cell.textLabel.font = DEFAULT_FONT;
    
    return cell;
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Player *player = [self.players objectAtIndex:indexPath.row];
        [player MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        [self.players removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Player *player = [self.players objectAtIndex:indexPath.row];
    
    CreatePlayerViewController *vc = [[CreatePlayerViewController alloc]init];
    vc.player = player;
    
    [self.navigationController presentViewController:vc animated:YES completion:^{
        
    }];
    
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
