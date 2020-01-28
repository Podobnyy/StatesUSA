//
//  SettingsController.m
//  States_USA
//
//  Created by Сергей Александрович on 22.11.2017.
//  Copyright © 2017 Sergey Podobnyy. All rights reserved.
//

#import "SettingsController.h"
#import "InAppPurchaseManager.h"

@interface SettingsController ()

@property(nonatomic, weak) IBOutlet UILabel *resultMap;
@property(nonatomic, weak) IBOutlet UILabel *resultFlag;
@property(nonatomic, weak) IBOutlet UILabel *resultCapital;
@property(nonatomic, weak) IBOutlet UIView *viewResult;
@property(nonatomic, weak) IBOutlet UIView *viewReklama;

@property(nonatomic, weak) IBOutlet UIButton *buy;
@property(nonatomic, weak) IBOutlet UIButton *restore;

@end

@implementation SettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewResult.layer.cornerRadius = 20;
    _viewReklama.layer.cornerRadius = 20;
    [self load];
}

- (void)load{
    
    if (self.view.frame.size.width < 370) {
        _resultMap.font = [UIFont systemFontOfSize:16];
        _resultFlag.font = [UIFont systemFontOfSize:16];
        _resultCapital.font = [UIFont systemFontOfSize:16];
    }
    NSLog(@"%f", self.view.frame.size.width);
    
    
    _resultFlag.text = [NSString stringWithFormat:@"Your best score Flag %li from 50", [[NSUserDefaults standardUserDefaults] integerForKey:@"flagToName"]]; // flagToName
    _resultMap.text = [NSString stringWithFormat:@"Your best score Map %li from 50", [[NSUserDefaults standardUserDefaults] integerForKey:@"imageToName"]]; // imageToName
    _resultCapital.text = [NSString stringWithFormat:@"Your best score Capital %li from 50", [[NSUserDefaults standardUserDefaults] integerForKey:@"CapitalToName"]]; // CapitalToName
    
    //Реклама
    [[InAppPurchaseManager sharedManager] loadStore]; // 1
    [[InAppPurchaseManager sharedManager] canMakePurchases]; // 2
}



#pragma mark - IBActions

- (IBAction)clickBtnDisableAds:(id)sender { // отключить рекламу
    if([[InAppPurchaseManager sharedManager] canMakePurchases])
    {
        [[InAppPurchaseManager sharedManager] purchaseProUpgrade];
//        NSLog(@"ПОЗРАВЛЯЮ РЕКЛАМА ОТКЛЮЧЕНА");
    } else {
//        NSLog(@"Не удалось отключить рекламу");
    }
}

- (IBAction)clickBntRestorePurchases:(id)sender { // востановить покупки
    if([[InAppPurchaseManager sharedManager] canMakePurchases])
    {
        [[InAppPurchaseManager sharedManager] restoreProUpgrade];
//        NSLog(@"Покупки востановленны");
    } else{
//        NSLog(@"Не удалось востановить покупки");
    }
    
}

#pragma mark - Buy
/*
- (void) GetResponce:(NSNotification * ) notification{
    NSLog(@"%@",notification);
    self.buy.enabled = YES;
    self.restore.enabled = YES;
}
- (void) RestoredPayment:(NSNotification * ) notification{
    // TODO вью Покупки востановлены успешно
    TransactionView * view = [TransactionView create];
    view.transactionText.text = strings[@"settingsRestoreText"];
    view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:view];
}

- (void) SucceededPayment:(NSNotification * ) notification{
    // TODO вью Благодарим за покупку
    TransactionView * view = [TransactionView create];
    view.transactionText.text = strings[@"settingsThxText"];
    view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:view];
}

- (void) FailedPayment:(NSNotification * ) notification{
    // TODO вью Ошибка платежа
    TransactionView * view = [TransactionView create];
    view.transactionText.text = strings[@"settingsErrorText"];
    view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:view];
}
*/
@end
