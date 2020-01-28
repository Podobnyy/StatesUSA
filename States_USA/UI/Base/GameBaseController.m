//
//  GameBaseController.m
//  States_USA
//
//  Created by Сергей Александрович on 23.11.2017.
//  Copyright © 2017 Sergey Podobnyy. All rights reserved.
//

#import "GameBaseController.h"

@interface GameBaseController ()

@end

@implementation GameBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.answerView.layer.cornerRadius = 17; // окружность
    self.correct = 0; // онулить статы правильных ответов
    self.from = 0; // онулить статы количество ответов
    self.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.heightImage.constant = ((self.view.frame.size.width - 8) * 1237/2000);
    
    self.baseStates = [FromImageToNameModel FITNData];
    
    [self nextQuestion];
}

#pragma mark - Actions
- (void)next{
    if (self.baseStates.count > 0) {
        NSLog(@"%li",self.baseStates.count);
        
        
        
        //Реклама
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"isProUpgradePurchased"] == 0) {
            if (self.baseStates.count == 45 || self.baseStates.count == 30 || self.baseStates.count == 15) {
                [self reklamaInterstitialShowing];
            }
            
            if (self.baseStates.count == 43 || self.baseStates.count == 28 || self.baseStates.count == 13) {
                [self reklamaInterstitialCreateAndDownload];
            }
        }
        //---------
        
        
        
        [self nextQuestion];
    } else {
        self.nameTextField.text = @"";
        [self performSelector:@selector(endQuestion) withObject:self afterDelay:3.0 ]; // 3сек
    }
}

-(void)Answer{
    self.from = self.from +1;
    BOOL tru = [self.nameTextField.text isEqualToString:self.nameStates] || [self.nameTextField.text isEqualToString:self.nameStatesRU];
    
    if (tru == YES ) {
        self.correct = self.correct +1;
        // экранчик
        self.answerView.backgroundColor = [UIColor greenColor];
        self.answerView.alpha = 0.8;
        self.answerLabelBool.text = @"Correct!";
    } else {
        // экранчик
        self.answerView.backgroundColor = [UIColor redColor];
        self.answerView.alpha = 0.8;
        self.answerLabelBool.text = @"Incorrect!";
        
    }
    self.labelStat.title = [NSString stringWithFormat:@"%li/%li",self.correct, self.from];
    
    self.answerLabelStates.text = [NSString stringWithFormat:@"This is \n %@", self.nameStates];
    
    self.view.userInteractionEnabled = NO; // блокировать экрна
    [self performSelector:@selector(next) withObject:self afterDelay:2.0 ]; // 3сек // TODO: 3 cек
}

-(void)nextQuestion{
}

- (void)endQuestion{
}

-(void)endGame{
    [self saveResult];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"isProUpgradePurchased"] == 0) {
        [self reklamaInterstitialShowing];
    }
    [self.navigationController popViewControllerAnimated:YES]; // В главное меню
}

- (void)saveResult{
    
}


#pragma mark - IBActions
-(IBAction)hidekeyboard{
    [self.view endEditing:YES]; // спрятать клавиатуру
}
/*
 -( IBAction)pinc:(UIPinchGestureRecognizer *)sender{
 self.image.transform = CGAffineTransformScale(self.image.transform, sender.scale, sender.scale);
 sender.scale = 1;
 }
 
 -( IBAction)panGest:(UIPanGestureRecognizer *)sender{
 CGPoint point = [sender translationInView:self.image]; // 1 берем смещение относительно ректа
 self.image.center = CGPointMake(self.image.center.x + point.x, self.image.center.y + point.y); // 2 смешает рект на смещение
 [sender setTranslation:CGPointZero inView:self.image]; // 3 зануляем смещенеи относительно ректа
 }
 */
#pragma Mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{ // при нажатии  Done
    [self Answer];
    return NO;
}

@end
