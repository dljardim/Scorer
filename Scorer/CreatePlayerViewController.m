//
//  CreatePlayerViewController.m
//  LearnXib
//
//  Created by Damian Jardim on 9/22/14.
//  Copyright (c) 2014 Damian Jardim. All rights reserved.
//

#import "CreatePlayerViewController.h"
#import "Player.h"
#import "CoreData+MagicalRecord.h"


@interface CreatePlayerViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (nonatomic) BOOL isNew;


@end

@implementation CreatePlayerViewController

- (void)viewDidLoad {
    DLog();
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //prevent nav controller from hiding view content
    self.navigationController.navigationBar.translucent = NO;
    
    //if there is no player - create a new player
   if (!self.player) {
        self.player = [Player MR_createEntity];
       self.isNew = YES;
   }else{
       self.txtName.text = self.player.playerName;
       self.isNew = NO;
   }
    
    [self setupUI];
  
}

-(void)setupUI{
    self.txtName.font = DEFAULT_FONT;
    self.btnSave.titleLabel.font = DEFAULT_FONT;
    self.btnCancel.titleLabel.font = DEFAULT_FONT;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.txtName resignFirstResponder];
    
    // Save context as view disappears
    [self saveContext];
    self.player = nil;
}

- (IBAction)saveClick:(id)sender {
    [self addNewPlayer];
}
- (IBAction)cancelClick:(id)sender {
    [self cancelAdd];
}


- (void)addNewPlayer {
    //[self.navigationController popViewControllerAnimated:YES];
    self.player.playerName = self.txtName.text;
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)cancelAdd {
    if(self.isNew){
        [self.player MR_deleteEntity];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)saveContext {
    [[NSManagedObjectContext MR_defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}


#pragma mark - TextField

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
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
