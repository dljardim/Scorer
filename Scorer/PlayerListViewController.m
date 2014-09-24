//
//  PlayerListViewController.m
//  Scorer
//
//  Created by Damian Jardim on 9/22/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import "PlayerListViewController.h"

@interface PlayerListViewController ()

@property (nonatomic, strong) NSMutableArray *playerList;

@end

@implementation PlayerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupView{
    // Create Edit Button
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editNotes:)];
    self.navigationItem.leftBarButtonItem = editButton;
    
    // Create Add Button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Fetch Notes
    [self fetchNotes];
}

- (void)fetchNotes {
    // Fetch Notes
    //self.playerList = [NSMutableArray arrayWithArray:[Player findAll]];
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
