//
//  FromCapitalToNameController.m
//  States_USA
//
//  Created by Сергей Александрович on 23.11.2017.
//  Copyright © 2017 Sergey Podobnyy. All rights reserved.
//

#import "FromCapitalToNameController.h"

@interface FromCapitalToNameController ()<UITextFieldDelegate>

@property (nonatomic, strong) FromImageToNameModel *model; // Модель Штатов

@end

@implementation FromCapitalToNameController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions

-(void)nextQuestion{
    self.view.userInteractionEnabled = YES;
    self.answerView.alpha = 0; // View nil
    NSInteger i = self.baseStates.count; // количество в базе
    NSInteger r = arc4random_uniform(i); // случайный обект
    
    FromImageToNameModel * dict = self.baseStates[r];
    _model = dict;
    
    self.nameStates = _model.nameStates;
    self.nameStatesRU = _model.nameStatesRU;
    self.capitalName.text = _model.CapitalName;
    
    self.nameTextField.text = @"";
    
    [self.baseStates removeObjectAtIndex:r]; // удалили объект из массива, который только что был
}

- (void)endQuestion{
    self.imageFlagStates.image = nil;
    self.widthAnswerView.constant = 250;
    self.answerLabelBool.font = [UIFont systemFontOfSize:26];
    NSInteger bestResult = [[NSUserDefaults standardUserDefaults] integerForKey:@"CapitalToName"];
    if (bestResult < self.correct) {
        self.answerLabelBool.text = @"New Best Score!!!";
        self.answerLabelStates.text = [NSString stringWithFormat:@"Result: \n %li from %li \nYour best score: %li from 50 ",self.correct, self.from, self.correct];
    } else{
        self.answerLabelBool.text = @"Game over";
        self.answerLabelStates.text = [NSString stringWithFormat:@"Result: \n %li from %li \nYour best score: %li from 50 ",self.correct, self.from, bestResult];
    }
    self.answerView.backgroundColor = [UIColor whiteColor];
    self.answerView.alpha = 1;
    
    [self performSelector:@selector(endGame) withObject:self afterDelay:5.0 ]; // 5сек
}

- (void)saveResult{ // CapitalToName
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"CapitalToName"]) {
        NSInteger flagToName = [[NSUserDefaults standardUserDefaults] integerForKey:@"CapitalToName"]; // чтение
        if (flagToName < self.correct) {
            flagToName = self.correct;
            [[NSUserDefaults standardUserDefaults] setInteger:flagToName forKey:@"CapitalToName"]; // запись
        }
    } [[NSUserDefaults standardUserDefaults] setInteger:self.correct forKey:@"CapitalToName"]; // запись
}

@end

