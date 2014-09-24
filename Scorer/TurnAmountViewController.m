//
//  TurnAmountViewController.m
//  Scorer
//
//  Created by Damian Jardim on 9/19/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import "TurnAmountViewController.h"
#import "UIViewController+MaryPopin.h"

@interface TurnAmountViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblLabel;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;

@end

@implementation TurnAmountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.txtAmount.text = [self.inAmount stringValue];
    [self.txtAmount becomeFirstResponder];
    
    self.txtAmount.keyboardType = UIKeyboardTypeNumbersAndPunctuation;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    [self dismissPopup];
}

-(void)dismissPopup{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    self.inAmount = [formatter numberFromString:self.txtAmount.text];
    
    [self.delegate updateAmount:self.inAmount];
    
    [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self dismissPopup];
    return YES;
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
