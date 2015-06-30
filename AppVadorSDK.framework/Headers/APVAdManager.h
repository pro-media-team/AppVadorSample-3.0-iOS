//
//  APVAdManager.h
//  AppVadorSDK
//
//  Created by Hirohide Sano on 2015/06/04.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    APV_ENV_PRODUCTION,
    APV_ENV_TEST,
    APV_ENV_DEVELOPMENT
} APVEnv;

typedef enum : NSInteger {
    APV_PRELOAD_META,
    APV_PRELOAD_ALL
} APVPreloadType;

@protocol APVAdManagerDelegate;
@interface APVAdManager : NSObject

@property (nonatomic, weak) id<APVAdManagerDelegate> delegate;
@property (nonatomic) APVPreloadType preloadType;
@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic, readonly) BOOL isReady;

- (id) initWithPubId:(NSString *) pubId withDelegate:(id<APVAdManagerDelegate>) delegate;
- (id) initWithPubId:(NSString *) pubId withDelegate:(id<APVAdManagerDelegate>) delegate withEnv: (APVEnv) env;
- (void) load;
- (void) showAdForView:(UIView *)view;
- (void) showAdForView:(UIView *)view withRect:(CGRect)rect;

#pragma mark player callbacks
- (void) didPlaying;
- (void) didCompletion;
- (void) didClick;
- (void) didClickToFullscreen;
- (void) didUnmute;
- (void) didMute;
- (void) didClose;
- (void) onAdViewVisible;
- (void) onAdViewInvisible;
- (void) didFailedToPlayAd:(NSObject *)error;

@end

#pragma mark -

@protocol APVAdManagerDelegate <NSObject>

- (void) onReadyToPlayAd;
- (void) onPlayingAd;
- (void) onCompletionAd;
- (void) onClickAd;
- (void) onUnmuteAd;
- (void) onMuteAd;
- (void) onCloseAd;
- (void) onFailedToPlayAd:(NSObject *)error;

- (UIViewController *)viewControllerForPresentingModalView;

@end