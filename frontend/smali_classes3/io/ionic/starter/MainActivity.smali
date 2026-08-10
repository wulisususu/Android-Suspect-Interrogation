.class public Lio/ionic/starter/MainActivity;
.super Lcom/getcapacitor/BridgeActivity;
.source "MainActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 33
    invoke-direct {p0}, Lcom/getcapacitor/BridgeActivity;-><init>()V

    return-void
.end method

.method private startWebViewRefreshLoop(Landroid/webkit/WebView;)V
    .locals 2

    .line 72
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 73
    new-instance v1, Lio/ionic/starter/MainActivity$1;

    invoke-direct {v1, p0, p1, v0}, Lio/ionic/starter/MainActivity$1;-><init>(Lio/ionic/starter/MainActivity;Landroid/webkit/WebView;Landroid/os/Handler;)V

    .line 80
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method


# virtual methods
.method public dispatchKeyEvent(Landroid/view/KeyEvent;)Z
    .locals 0

    .line 106
    invoke-virtual {p1}, Landroid/view/KeyEvent;->getKeyCode()I

    .line 108
    invoke-super {p0, p1}, Lcom/getcapacitor/BridgeActivity;->dispatchKeyEvent(Landroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 1

    .line 38
    const-class v0, Lplugins/NoTrouble/NoTroublePlugin;

    invoke-virtual {p0, v0}, Lio/ionic/starter/MainActivity;->registerPlugin(Ljava/lang/Class;)V

    .line 39
    const-class v0, Lplugins/MultiScreenPlugin/MultiScreenPlugin;

    invoke-virtual {p0, v0}, Lio/ionic/starter/MainActivity;->registerPlugin(Ljava/lang/Class;)V

    .line 40
    const-class v0, Lplugins/Immersive/ImmersivePlugin;

    invoke-virtual {p0, v0}, Lio/ionic/starter/MainActivity;->registerPlugin(Ljava/lang/Class;)V

    .line 41
    invoke-super {p0, p1}, Lcom/getcapacitor/BridgeActivity;->onCreate(Landroid/os/Bundle;)V

    .line 43
    invoke-static {}, Lcom/aliyun/emas/apm/Apm;->start()Z

    return-void
.end method

.method public onDestroy()V
    .locals 0

    .line 90
    invoke-super {p0}, Lcom/getcapacitor/BridgeActivity;->onDestroy()V

    return-void
.end method

.method public onPause()V
    .locals 0

    .line 95
    invoke-super {p0}, Lcom/getcapacitor/BridgeActivity;->onPause()V

    return-void
.end method

.method public onResume()V
    .locals 0

    .line 85
    invoke-super {p0}, Lcom/getcapacitor/BridgeActivity;->onResume()V

    return-void
.end method
