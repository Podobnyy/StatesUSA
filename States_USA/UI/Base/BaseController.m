//
//  BaseController.m
//  States_USA
//
//  Created by Сергей Александрович on 19.11.2017.
//  Copyright © 2017 Sergey Podobnyy. All rights reserved.
//

#import "BaseController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
@import GoogleMobileAds; // GOOGLE


@interface BaseController () <GADBannerViewDelegate, GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial *interstitial; // GOOGLE
@property(nonatomic, weak) IBOutlet GADBannerView *bannerView; // GOOGLE Банер
@property(nonatomic, weak) UIImage *backgroundImage;

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"реклама - %li", [[NSUserDefaults standardUserDefaults] integerForKey:@"isProUpgradePurchased"]); //  реклама ВКЛ ВЫКЛ


    [self loadBackground];
    _backgroundImage = [UIImage imageNamed:@"10"];
            //_backgroundImage.contentMode = UIViewContentModeCenter;
            //_backgroundImage.contentMode = UIViewContentModeScaleAspectFit;
            //self.view.backgroundColor = [UIColor colorWithPatternImage:_backgroundImage];
    
    
    //GOOGLE
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"isProUpgradePurchased"] == 0) {
        [self reklamaInterstitialCreateAndDownload]; // создаем и загружаем
        [self firstBannerView];
    }
}

- (void) loadBackground{
    //ставим обои
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"20"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

#pragma mark - Google Banner Actions
- (void)firstBannerView{// GOOGLE Банер  // ca-app-pub-2400450779974795/8947708580 (мой) || ca-app-pub-3940256099942544/2934735716
    // создаем
    self.bannerView.adUnitID = @"ca-app-pub-2400450779974795/8947708580"; //ca-app-pub-3940256099942544/2934735716";  // TODO: своя реклама
    self.bannerView.rootViewController = self;
    // загружаем
    [self.bannerView loadRequest:[GADRequest request]];
    // становимся у себя делегатом
    self.bannerView.delegate = self;
    
}

- (void)restarBannerView{
    // загружаем
    [self.bannerView loadRequest:[GADRequest request]];
}

#pragma mark - Google Interstitial Actions
- (void)reklamaInterstitialCreateAndDownload{ // создаем и загружаем
    // создаем                        // ca-app-pub-2400450779974795/6660278989 (мой)   ||  ca-app-pub-3940256099942544/4411468910
    self.interstitial = [[GADInterstitial alloc]
                         initWithAdUnitID:@"ca-app-pub-2400450779974795/6660278989"]; //ca-app-pub-3940256099942544/4411468910"];
    // загружаем
    GADRequest *request = [GADRequest request];
    [self.interstitial loadRequest:request];
}

- (void)reklamaInterstitialShowing{ // показываем
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    } else {
        NSLog(@"реклама не загружена"); 
    }
}

#pragma mark - GADBannerViewDelegate
- (void) adViewDidReceiveAd: (GADBannerView *) adView { // обновлять Рекламу каждые 90 сек // -метод реклама загружена
    [self performSelector:@selector(restarBannerView) withObject:self afterDelay:90.0];
}

#pragma mark - Actions

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
