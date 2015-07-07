AppVador SDK Version 3.0
========================

要件
----

ビルド設定は以下のとおりです。

Deployment Target: 6.1

iOS6.1以降の端末で正常に動作します。

初期設定
--------

SDK(AppVadorSDK.framework)をプロジェクトに追加し、Linked Frameworks and Libraryies へ AppVadorSDK.frameworkを追加します。

必要なフレームワークを追加します。

- AdSupport.framework
- CoreTelephony.framework
- CoreMedia.framework
- AVFoundation.framework
￼
ワイドビュービデオ広告
----------------------

16:9サイズの動画広告を、フィード内や従来のレクタングル枠などに自由に設置できる広告フォーマットです。

必要なクラスをインポートします。

    #import <AppVadorSDK/APVAdManager.h>

広告枠からの通知を受け取るAPVAdManagerDelegateを実装します。

    @interface MainViewController : UIViewController<APVAdManagerDelegate> {

    }

実装・テスト用には下記の広告枠IDをご利用ください。
**本番実装時には必ず管理画面で発行した広告枠IDに差し替えてください。広告が正しく配信できません。**

    be799a9af42fd94b851539335d3713ab

viewDidLoadメソッド等でAdManagerを作成し、広告の準備を行います。

    @interface MainViewController ()

    @property APVAdManager *ad;
    @property UIView *containerView;
    @property UIView *adView;

    @end

    @implementation MainViewController

    - (void)viewDidLoad {
        [super viewDidLoad];

        self.adManager = [[APVAdManager alloc] initWithPubId:@"be799a9af42fd94b851539335d3713ab" withDelegate:self];
        [self.adManager load];

広告の表示を行うには、広告枠を挿入するUIViewを指定して下記のように実行します。
この処理により、parentViewと同一サイズ・同一位置に広告枠を展開します。

     [self.adManager showAdForView: parentView];

frameを別途指定する場合は、下記のように実装してください。

    [self.ad showAdForView:parentView withRect:CGRectMake(x, y, w, h)];

APVAdManagerクラスには広告の準備が完了しているかどうかを確認するisReadyメソッドがあります。

    if (self.adManager.isReady) {
        NSLog(@"ad is ready");
    } else {
        NSLog(@"ad is not ready");
    }

高速再生モードの利用
--------------------

（インタースティシャル・ワイドビューにて共通）
通常、動画広告は呼び出されてから読込を開始するため、AdManager.showAd()から実際に動画が再生されるまで電波環境により数秒かかる可能性があります。
高速再生モードを有効にすると、AdManager.load()実行時に動画をキャッシュしておくことで、一瞬で再生を開始することができます。

    self.adManager.preloadType = APV_PRELOAD_ALL;

背景色の変更
--------------------

広告枠の背景色を任意に設定できます。

    self.adManager.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];

広告の読込失敗、成功など各種通知の取得
--------------------------------------

APVAdManagerDelegateを実装してください。


    @implementation MainViewController

    - (UIViewController *)viewControllerForPresentingModalView
    {
        return self;
    }

    - (void)onFailedToPlayAd:(NSObject *)error
    {
        // 何らかの理由で動画広告の読込または再生に失敗した場合に呼ばれます。
        // 他アドネットワーク等の広告表示をここに実装することで、フィラーのように動作させることが可能です。
    }

    - (void)onReadyToPlayAd
    {
        // AdManager.load()により読み込んだ動画広告の再生準備が完了した際に呼ばれます。
        // このタイミングでAdManager.showAdすることで、シームレスな再生開始が可能です。
    }

    - (void)onPlayingAd
    {
        // 実際に動画広告の再生が開始した際に呼ばれます。
    }

    - (void)onMuteAd
    {
        // 動画広告の音声がオフになった際に呼ばれます。
    }

    - (void)onUnmuteAd
    {
        // 動画広告の音声がオンになった際に呼ばれます。
    }

    - (void)onCompletionAd
    {
        // 動画広告の再生が完了した際に呼ばれます。
    }

    - (void)onClickAd
    {
        // 広告枠がクリックされた際に呼ばれます。
        // 通常、アプリ外で標準のブラウザへ遷移します。
    }

    - (void)onCloseAd
    {
        // インタースティシャルなどの閉じるボタンのある広告フォーマットにて、広告枠が閉じられた際に呼ばれます。
    }

広告の読み込みに失敗した際は、failedToReceiveAdメソッドにエラーコードが渡されます。
エラーコードの内容はそれぞれ下記の通りです。

| 定数 | メッセージ | 内容 |
| ---- | ---------- | ---- |
| NO_AD | No ads found. | 配信可能な広告がありません。 |
| PUBLICATION_NOT_FOUND | Publication not found. Please check publication id. | 広告枠が見つかりません。広告枠IDを確認してください。 |
| NETWORK_ERROR | Unable to connect to server. | サーバーに接続できませんでした。ネットワーク環境に問題があります。 |
| SERVER_ERROR | Invalid response from server. | サーバーからのレスポンスが不正でした。広告リクエスト中に切断などの問題が発生しました。 |
| INTERNAL_ERROR | Unable to serve ad due to invalid internal state. | 広告の配信に失敗しました。 |

リリースノート
---------------

### 2015/07/07 3.0
- 再生完了後の表示内容を調整

### 2015/07/03 3.0
- フルスクリーンプレイヤーの仕様をAndroidと統一
- 連続して動画を再生しようとした際にハードウェア制限に当たる不具合を修正

### 2015/06/30 3.0
- 初回リリース

