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

@property (nonatomic, weak) IBOutlet UILabel *lblScore;

@property (nonatomic) int selectedIndexPathRow;


@property (nonatomic, strong) NSMutableArray *arrayDatasource;

@end

@implementation PlayerScoreCard

- (void)viewDidLoad {
    DLog();
    [super viewDidLoad];
    
    //self.navigationController.navigationBar.translucent = NO;
    self.title = @"PlayerScoreCard";
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayerTurnTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    [self addTableData];
    [self updateTotalScore];
    [self setupUI];
    
    
}

-(void)setupUI{
    self.lblScore.font = DEFAULT_FONT;
    
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
   
    NSLog(@"updateAmount: %@", amount);
    
    //dont update our datasource if 'amount' isn't a number
    if(amount != nil){
        self.arrayDatasource[self.selectedIndexPathRow] = amount;
    }
    
    [self checkForWinner];
    
    [self reload];
}

-(void)reload{
    [self.tableView reloadData];
    [self updateTotalScore];
    
}

-(void)checkForWinner{
    //has user won
    
    int sum = 0;
    
    for (NSNumber *num in self.arrayDatasource)
    {
        sum = sum + [num intValue];
    }
    
    if(sum > 50){
        [self.delegate testViewController:self];
    }
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
    return 35;
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
    cell.textLabel.font = DEFAULT_FONT;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog();
    self.selectedIndexPathRow = (int)indexPath.row;
    [self presentPopup:indexPath];
}

#pragma mark - 

#pragma mark Table view header / footer

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1. The view for the header
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    
    // 2. Set a custom background color and a border
    //headerView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    //headerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
    //headerView.layer.borderWidth = 1.0;
    
    // 3. Add a label
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(0, 0, tableView.bounds.size.width, headerView.bounds.size.height);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = DEFAULT_FONT;
    headerLabel.text = @"Player 1";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    // 4. Add the label to the header view
    [headerView addSubview:headerLabel];
    
    // 5. Finally return
    return headerView;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //todo - add conditional to test for the cases in the which the + (add score) will appear
    
   
        // 1. The view
        UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
        singleTap.numberOfTapsRequired = 1;
        [footerView addGestureRecognizer:singleTap];
        
        // 2. Set a custom background color and a border
        //footerView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        //footerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
        //footerView.layer.borderWidth = 1.0;
        
        // 3. Add a label
        UILabel* footerLabel = [[UILabel alloc] init];
        footerLabel.frame = CGRectMake(0, 0, tableView.bounds.size.width, footerView.bounds.size.height);
        footerLabel.backgroundColor = [UIColor clearColor];
        footerLabel.textColor = [UIColor blackColor];
    footerLabel.font = DEFAULT_FONT;
    footerLabel.text = @"+";
        footerLabel.textAlignment = NSTextAlignmentCenter;
        
        // 4. Add the label to the view
        [footerView addSubview:footerLabel];
        
        // 5. Finally return
        return footerView;

    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 22;
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
    
    
    CGRect presentationRect = self.view.window.bounds;
    CGFloat h = presentationRect.size.height - self.tabBarController.view.bounds.size.height;
    CGFloat w = presentationRect.size.width - self.tabBarController.view.bounds.size.width;
    presentationRect.size = CGSizeMake(w, h);

    
    [self.navigationController presentPopinController:popin fromRect:presentationRect animated:YES completion:^{
        //NSLog(@"Popin presented !");
    }];
    
    //log popinView
    NSLog(@"popin.view.frame: %@", NSStringFromCGRect(popin.view.frame));
    NSLog(@"popin.view.frame: %@", NSStringFromCGRect(popin.view.frame));
    
}

- (void)dismissPopup {
    
    [self dismissCurrentPopinControllerAnimated:YES completion:^{
       
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
