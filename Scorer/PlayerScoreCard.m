//
//  LaunchViewController.m
//  Scorer
//
//  Created by Damian Jardim on 9/19/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import "PlayerScoreCard.h"
#import "PlayerTurnTableViewCell.h"
#import "UIViewController+MaryPopin.h"
#import "TurnAmountViewController.h"


static NSString *cellIdentifier = @"customCell";

@interface PlayerScoreCard ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *lblName;
@property (nonatomic, weak) IBOutlet UILabel *lblScore;

@property (nonatomic) int selectedIndexPathRow;


@property (nonatomic, strong) NSMutableArray *arrayDatasource;

@end

@implementation PlayerScoreCard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayerTurnTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    [self addTableData];
    [self updateTotalScore];
    [self updateName];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTableData{
    
    //[self.arrayDatasource addObject:[NSNumber numberWithInt:1]];
    //[self.arrayDatasource addObject:[NSNumber numberWithInt:1]];
    //[self.arrayDatasource addObject:[NSNumber numberWithInt:1]];
    //[self.arrayDatasource addObject:[NSNumber numberWithInt:1]];
    //[self.arrayDatasource addObject:[NSNumber numberWithInt:1]];
    
    
    //what happens when no data rows are added
    //if no data rows are added - add + row
        //
}

-(void)updateName{
    self.lblName.text = @"name";
}

-(void)updateTotalScore{
    int sum = 0;
    
    for (NSNumber *num in self.arrayDatasource)
    {
        sum = sum + [num intValue];
    }
    
    self.lblScore.text = [NSString stringWithFormat:@"%d", sum];
}

//callback from turnamountview
-(void)updateAmount:(NSNumber *)amount{
    
    
    //update datasource and tableview
    
    //NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    //NSNumber *myNumber = [formatter numberFromString:amount];
    
    //todo: change from 0 -
    self.arrayDatasource[self.selectedIndexPathRow] = amount;
    
    [self reload];
    
}

-(void)reload{
    [self.tableView reloadData];
    [self updateTotalScore];
    
}

#pragma mark - Lazy Load

- (NSMutableArray *)arrayDatasource
{
    if (!_arrayDatasource) {
        
        _arrayDatasource = [NSMutableArray new];
    }
    return _arrayDatasource;
}

#pragma mark - 

#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
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
    PlayerTurnTableViewCell *cell = (PlayerTurnTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
    [cell.lblName setText:[NSString stringWithFormat:@"%@",[self.arrayDatasource objectAtIndex:indexPath.row]]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPathRow = (int)indexPath.row;
    [self presentPopup:indexPath];
}

#pragma mark - 

#pragma mark Table view header / footer

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //todo: fix - decide if the header is needed - maybe display the name in the header ???
    
    if(/* DISABLES CODE */ (YES)){
        return nil;
    }
    
    // 1. The view for the header
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    
    // 2. Set a custom background color and a border
    headerView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    headerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
    headerView.layer.borderWidth = 1.0;
    
    // 3. Add a label
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(5, 2, tableView.frame.size.width - 5, 18);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:16.0];
    headerLabel.text = @"HEADER";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    // 4. Add the label to the header view
    [headerView addSubview:headerLabel];
    
    // 5. Finally return
    return headerView;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //todo - add conditional to test for the cases in the which the + (add score) will appear
    
    if(YES){
        // 1. The view
        UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
        singleTap.numberOfTapsRequired = 1;
        [footerView addGestureRecognizer:singleTap];
        
        // 2. Set a custom background color and a border
        footerView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        footerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
        footerView.layer.borderWidth = 1.0;
        
        // 3. Add a label
        UILabel* footerLabel = [[UILabel alloc] init];
        footerLabel.frame = CGRectMake(5, 2, tableView.frame.size.width - 5, 60);
        footerLabel.backgroundColor = [UIColor clearColor];
        footerLabel.textColor = [UIColor whiteColor];
        footerLabel.font = [UIFont boldSystemFontOfSize:16.0];
        footerLabel.text = @"+";
        footerLabel.textAlignment = NSTextAlignmentCenter;
        
        // 4. Add the label to the view
        [footerView addSubview:footerLabel];
        
        // 5. Finally return
        return footerView;

    }
    
    return nil;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}


#pragma mark -

#pragma mark - methods

- (void)tapDetected:(UIGestureRecognizer *)sender {
    
    
    
    //[self logIndexPath:path];
    //[self logArray:self.arrayDatasource];
    //NSIndexPath *path = [NSIndexPath indexPathWithIndex:self.arrayDatasource.count];
    
    //add new item to our array - then use that indexpath
    [self.arrayDatasource addObject:[NSNumber numberWithInt:0]];
    NSIndexPath *path = [NSIndexPath indexPathForRow:(self.arrayDatasource.count-1) inSection:0];
    self.selectedIndexPathRow = (int)path.row;
    
    [self reload];
    
    [self presentPopup:path];
}

#pragma mark -




#pragma mark - Popup Functions

- (void)presentPopup:(NSIndexPath *)indexPath
{
    
    
    //Create the popin view controller
    //UIViewController *popin = [[UIViewController alloc] initWithNibName:@"NibName" bundle:@"Bundle"];
    TurnAmountViewController *popin = [[TurnAmountViewController alloc]init];
    
    NSNumber *oldValue = self.arrayDatasource[indexPath.row];
    popin.delegate = self;
    popin.inAmount = oldValue;
    
    //Customize transition if needed
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleSlide];
    
    //Add options
    [popin setPopinOptions:BKTPopinDisableAutoDismiss];
    
    //Customize transition direction if needed
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    
    //Present popin on the desired controller
    //Note that if you are using a UINavigationController, the navigation bar will be active if you present
    // the popin on the visible controller instead of presenting it on the navigation controller
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
    
}

- (void)dismissPopup {
    
    [self dismissCurrentPopinControllerAnimated:YES completion:^{
        NSLog(@"Popin dismissed !");
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
