//
//  InAppPurchaseManager.m
//  States_USA
//
//  Created by Сергей Александрович on 28.11.2017.
//  Copyright © 2017 Sergey Podobnyy. All rights reserved.
//

#import "InAppPurchaseManager.h"


#define kInAppPurchaseProUpgradeProductId @"com.sergeypodobnyy.stateguess.proupgrade" // TODO: ИЗМЕНИТЬ

@implementation InAppPurchaseManager

+ (InAppPurchaseManager *)sharedManager
{
    static InAppPurchaseManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

// ---------------------------------

- (void)requestProUpgradeProductData // Для запроса данных о продукте
{
    NSSet *productIdentifiers = [NSSet setWithObject:@"com.sergeypodobnyy.stateguess.proupgrade"]; // TODO: ИЗМЕНИТЬ
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
    // we will release the request object in the delegate callback
}

#pragma mark - SKProductsRequestDelegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    proUpgradeProduct = [products count] == 1 ? [products firstObject] : nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification
                                                        object:nil
                                                      userInfo:@{@"response": response}];
}

#pragma mark - Public methods

/*
 * call this method once on startup
 */
- (void)loadStore
{
    // restarts any purchases if they were interrupted last time the app was open
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    // get the product description (defined in early sections)
    [self requestProUpgradeProductData];
}

/*
 * call this before making a purchase
 */
- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}

/*
 * kick off the upgrade transaction
 */
- (void)purchaseProUpgrade
{
    SKPayment *payment = [SKPayment paymentWithProduct:proUpgradeProduct];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

#pragma -
#pragma Purchase helpers

/*
 * saves a record of the transaction by storing the receipt to disk
 */

- (void)recordTransaction:(SKPaymentTransaction *)transaction
{
    if ([transaction.payment.productIdentifier isEqualToString:kInAppPurchaseProUpgradeProductId])
    {
        // save the transaction receipt to disk
        [[NSUserDefaults standardUserDefaults] setValue:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]] forKey:@"proUpgradeTransactionReceipt" ];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


/*
 * enable pro features
 */
- (void)provideContent:(NSString *)productId // что купили / момент покупки
{
    if ([productId isEqualToString:kInAppPurchaseProUpgradeProductId])
    {
        // enable the pro features
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isProUpgradePurchased" ]; // TODO: Что меняем ИЗМЕНИТЬ
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/*
 * removes the transaction from the queue and posts a notification with the transaction result
 */
- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful
{
    // remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:transaction, @"transaction" , nil];
    if (wasSuccessful)
    {
        // send out a notification that we’ve finished the transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionSucceededNotification object:self userInfo:userInfo];
    }
    else
    {
        // send out a notification for the failed transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionFailedNotification object:self userInfo:userInfo];
    }
}

/*
 * called when the transaction was successful
 */
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
}

- (void)restoreProUpgrade{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

/*
 * called when a transaction has been restored and and successfully completed
 */
- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction.originalTransaction];
    [self provideContent:transaction.originalTransaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionRestoredNotification object:self userInfo:nil];
}

/*
 * called when a transaction has failed
 */
- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        // error!
        [self finishTransaction:transaction wasSuccessful:NO];
    }
    else
    {
        // this is fine, the user just cancelled, so don’t notify
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
}

#pragma mark -
#pragma mark SKPaymentTransactionObserver methods

/*
 * called when the transaction status is updated
 */
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                NSLog(@"%@",transaction.error);
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}


@end

