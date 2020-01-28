//
//  GameBaseController.h
//  States_USA
//
//  Created by Сергей Александрович on 23.11.2017.
//  Copyright © 2017 Sergey Podobnyy. All rights reserved.
//

#import "BaseController.h"
#import "FromImageToNameModel.h"

@interface GameBaseController : BaseController

@property (weak, nonatomic) IBOutlet UIImageView *imageFlagStates;      // Флаг
@property (weak, nonatomic) IBOutlet UIImageView *image;                // Карта
@property (weak, nonatomic) IBOutlet UILabel *capitalName;              // Имя столицы
//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightImage; // Высота Картинки Карты
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthAnswerView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField; // Поле Воле
@property (weak, nonatomic) IBOutlet UIBarButtonItem *labelStat; // Текст Сколько из скольки (бар)
// Показ Результата
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UILabel *answerLabelBool;
@property (weak, nonatomic) IBOutlet UILabel *answerLabelStates;

@property (nonatomic, strong) NSMutableArray *baseStates; // База Штатов
@property (nonatomic, strong) NSString *nameStates; // Имя Штата
@property (nonatomic, strong) NSString *nameStatesRU; // Имя Штата RU
@property (nonatomic, strong) NSString *number; // номер Штата
 
@property (nonatomic, assign) NSInteger correct; // правильных ответов
@property (nonatomic, assign) NSInteger from; // из ответов


- (void)next;
- (void)Answer;
- (void)nextQuestion;
- (void)endQuestion;
- (void)endGame;
- (void)saveResult;


@end
