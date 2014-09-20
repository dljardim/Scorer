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


@property (nonatomic, strong) NSMutableArray *arrayDatasource;

@end

@implementation PlayerScoreCard

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PlayerTurnTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    /*
    //self.edgesForExtendedLayout = UIRectEdgeAll;

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
     */
    
    //self.navigationController.navigationBar.translucent = NO;
    
    // Do any additional setup after loading the view from its nib.
    [self addTableData];
    [self updateTotalScore];
    [self updateName];
    
    /*
    id topGuide = myViewController.topLayoutGuide;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings (button, topGuide);
    
    [myViewController.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat: @"V:[topGuide]-20-[button]"
                                             options: 0
                                             metrics: nil
                                               views: viewsDictionary]
     ];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTableData{
    [self.arrayDatasource addObject:[NSNumber numberWithInt:1]];
    [self.arrayDatasource addObject:[NSNumber numberWithInt:1]];
    [self.arrayDatasource addObject:[NSNumber numberWithInt:1]];
    [self.arrayDatasource addObject:[NSNumber numberWithInt:1]];
    [self.arrayDatasource addObject:[NSNumber numberWithInt:1]];
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
    // Assuming view is at zero index of XIB file.
    // this view will contain all lable and other controls
    
    /*
    UIView*customView =(UIView*)[[NSBundle mainBundle] loadNibNamed:@"NameOfCustomViewXIBFile" owner:nil options:nil] objectAtIndex:0];
    customView.transform =CGAffineTransformMakeScale(0.0f,0.0f);
    [self.view addSubView:customView];
    [UIView animateWithDuration:0.5 animations:^{customView.transform =CGAffineTransformMakeScale(1.0f,1.0f);}];
     */
    [self presentPopup];
    
}

#pragma mark -


#pragma mark - Popup Functions

- (void)presentPopup{
    
    
    //Create the popin view controller
    //UIViewController *popin = [[UIViewController alloc] initWithNibName:@"NibName" bundle:@"Bundle"];
    TurnAmountViewController *popin = [[TurnAmountViewController alloc]init];
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
