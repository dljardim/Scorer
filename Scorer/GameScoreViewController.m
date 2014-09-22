//
//  GameScoreViewController.m
//  Scorer
//
//  Created by Damian Jardim on 9/20/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import "GameScoreViewController.h"
#import "PlayerScoreCard.h"

@interface GameScoreViewController () <UITextFieldDelegate, UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *lblName;

@end

@implementation GameScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //add to uiscrollview
    PlayerScoreCard *playerSCView = [[PlayerScoreCard alloc]init];
    
    //UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    //v1.backgroundColor = [UIColor blueColor];
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height * 4);
    
    NSLog(@"width = %f, height = %f", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    
    [self addChildViewController:playerSCView];
    [self.scrollView addSubview:playerSCView.view];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[info[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    /*
    UIEdgeInsets insets = UIEdgeInsetsMake(self.fgScrollView.contentInset.top, 0, keyboardSize.height, 0);
    self.fgScrollView.contentInset = insets;
    self.fgScrollView.scrollIndicatorInsets = insets;
    self.fgScrollView.contentOffset = CGPointMake(self.fgScrollView.contentOffset.x, self.fgScrollView.contentOffset.y + keyboardSize.height);
    */
    
    [UIView commitAnimations];
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *info = [notification userInfo];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[info[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    /*
    UIEdgeInsets insets = UIEdgeInsetsMake(self.fgScrollView.contentInset.top, 0, 0, 0);
    self.fgScrollView.contentInset = insets;
    self.fgScrollView.scrollIndicatorInsets = insets;
     */
    
    [UIView commitAnimations];
    
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
