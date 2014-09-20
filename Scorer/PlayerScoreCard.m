//
//  LaunchViewController.m
//  Scorer
//
//  Created by Damian Jardim on 9/19/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import "PlayerScoreCard.h"
#import "PlayerTurnTableViewCell.h"


static NSString *cellIdentifier = @"customCell";

@interface PlayerScoreCard ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayDatasource;

@end

@implementation PlayerScoreCard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayerTurnTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];

    
    // Do any additional setup after loading the view from its nib.
    [self addTableData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTableData{
    [self.arrayDatasource addObject:@"1"];
    [self.arrayDatasource addObject:@"2"];
    [self.arrayDatasource addObject:@"3"];
    [self.arrayDatasource addObject:@"4"];
    [self.arrayDatasource addObject:@"5"];
}

#pragma mark - Lazy Load

- (NSMutableArray *)arrayDatasource
{
    if (!_arrayDatasource) {
        NSLog(@"arrayDatasource is nil");
        _arrayDatasource = [NSMutableArray new];
    }
    return _arrayDatasource;
}

#pragma mark - 

#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [self.arrayDatasource count];
    //return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"PlayerTurnTableViewCell";
    PlayerTurnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //cell is nil
    if (cell == nil) {
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray * topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"PlayerTurnTableViewCell" owner:self options:nil];
        cell = (PlayerTurnTableViewCell *)topLevelObjects[0];
    }
    */
    
    
    PlayerTurnTableViewCell *cell = (PlayerTurnTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
    [cell.lblName setText:[NSString stringWithFormat:@"%@",[self.arrayDatasource objectAtIndex:indexPath.row]]];
    

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected Row");
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
