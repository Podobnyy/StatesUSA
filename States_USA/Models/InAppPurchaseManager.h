//
//  InAppPurchaseManager.h
//  States_USA
//
//  Created by Сергей Александрович on 28.11.2017.
//  Copyright © 2017 Sergey Podobnyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"
#define kInAppPurchaseManagerTransactionCanceledNotification @"kInAppPurchaseManagerTransactionCanceledNotification"
#define kInAppPurchaseManagerTransactionRestoredNotification @"kInAppPurchaseManagerTransactionRestoredNotification"

@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
}

+ (InAppPurchaseManager *) sharedManager;

- (void)loadStore; // 1

- (BOOL)canMakePurchases; // 2
- (void)purchaseProUpgrade; // off
- (void)restoreProUpgrade;

//- (void)cancelTransactions;

//- (BOOL)isPurchased;

@end
