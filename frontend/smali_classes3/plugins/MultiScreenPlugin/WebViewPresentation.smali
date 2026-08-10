.class public Lplugins/MultiScreenPlugin/WebViewPresentation;
.super Landroid/app/Presentation;
.source "WebViewPresentation.java"


# static fields
.field private static final PERMISSION_REQUEST_CODE:I = 0x1

.field private static final TAG:Ljava/lang/String; = "WebViewPresentation"

.field public static instance:Lplugins/MultiScreenPlugin/WebViewPresentation;


# instance fields
.field private activity:Landroid/app/Activity;

.field private currentPermissionRequest:Landroid/webkit/PermissionRequest;

.field private isServiceBound:Z

.field private receiver:Landroid/content/BroadcastReceiver;

.field private screenCaptureService:Lplugins/MultiScreenPlugin/ScreenCaptureService;

.field private serviceConnection:Landroid/content/ServiceConnection;

.field private url:Ljava/lang/String;

.field private webView:Landroid/webkit/WebView;


# direct methods
.method static bridge synthetic -$$Nest$fgetactivity(Lplugins/MultiScreenPlugin/WebViewPresentation;)Landroid/app/Activity;
    .locals 0

    iget-object p0, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->activity:Landroid/app/Activity;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetscreenCaptureService(Lplugins/MultiScreenPlugin/WebViewPresentation;)Lplugins/MultiScreenPlugin/ScreenCaptureService;
    .locals 0

    iget-object p0, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->screenCaptureService:Lplugins/MultiScreenPlugin/ScreenCaptureService;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetwebView(Lplugins/MultiScreenPlugin/WebViewPresentation;)Landroid/webkit/WebView;
    .locals 0

    iget-object p0, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fputcurrentPermissionRequest(Lplugins/MultiScreenPlugin/WebViewPresentation;Landroid/webkit/PermissionRequest;)V
    .locals 0

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->currentPermissionRequest:Landroid/webkit/PermissionRequest;

    return-void
.end method

.method static bridge synthetic -$$Nest$fputisServiceBound(Lplugins/MultiScreenPlugin/WebViewPresentation;Z)V
    .locals 0

    iput-boolean p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->isServiceBound:Z

    return-void
.end method

.method static bridge synthetic -$$Nest$fputscreenCaptureService(Lplugins/MultiScreenPlugin/WebViewPresentation;Lplugins/MultiScreenPlugin/ScreenCaptureService;)V
    .locals 0

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->screenCaptureService:Lplugins/MultiScreenPlugin/ScreenCaptureService;

    return-void
.end method

.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/app/Activity;Landroid/view/Display;Ljava/lang/String;)V
    .locals 0

    .line 89
    invoke-direct {p0, p1, p2}, Landroid/app/Presentation;-><init>(Landroid/content/Context;Landroid/view/Display;)V

    const/4 p2, 0x0

    iput-boolean p2, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->isServiceBound:Z

    .line 48
    new-instance p2, Lplugins/MultiScreenPlugin/WebViewPresentation$1;

    invoke-direct {p2, p0}, Lplugins/MultiScreenPlugin/WebViewPresentation$1;-><init>(Lplugins/MultiScreenPlugin/WebViewPresentation;)V

    iput-object p2, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->receiver:Landroid/content/BroadcastReceiver;

    .line 65
    new-instance p2, Lplugins/MultiScreenPlugin/WebViewPresentation$2;

    invoke-direct {p2, p0}, Lplugins/MultiScreenPlugin/WebViewPresentation$2;-><init>(Lplugins/MultiScreenPlugin/WebViewPresentation;)V

    iput-object p2, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->serviceConnection:Landroid/content/ServiceConnection;

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->activity:Landroid/app/Activity;

    iput-object p3, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->url:Ljava/lang/String;

    return-void
.end method

.method private startScreenCaptureService()V
    .locals 5

    const-string v0, "WebViewPresentation"

    .line 152
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->getContext()Landroid/content/Context;

    move-result-object v2

    const-class v3, Lplugins/MultiScreenPlugin/ScreenCaptureService;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 153
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 154
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->getContext()Landroid/content/Context;

    move-result-object v2

    iget-object v3, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->serviceConnection:Landroid/content/ServiceConnection;

    const/4 v4, 0x1

    invoke-virtual {v2, v1, v3, v4}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    const-string v1, "\u622a\u56fe\u670d\u52a1\u542f\u52a8\u4e2d (Presentation\u6a21\u5f0f)"

    .line 155
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    const-string v2, "\u542f\u52a8\u622a\u56fe\u670d\u52a1\u5931\u8d25"

    .line 157
    invoke-static {v0, v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    return-void
.end method

.method private stopScreenCaptureService()V
    .locals 4

    const-string v0, "WebViewPresentation"

    :try_start_0
    iget-boolean v1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->isServiceBound:Z

    if-eqz v1, :cond_0

    .line 167
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->serviceConnection:Landroid/content/ServiceConnection;

    invoke-virtual {v1, v2}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V

    const/4 v1, 0x0

    iput-boolean v1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->isServiceBound:Z

    .line 170
    :cond_0
    new-instance v1, Landroid/content/Intent;

    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->getContext()Landroid/content/Context;

    move-result-object v2

    const-class v3, Lplugins/MultiScreenPlugin/ScreenCaptureService;

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 171
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/content/Context;->stopService(Landroid/content/Intent;)Z

    const-string v1, "\u622a\u56fe\u670d\u52a1\u5df2\u505c\u6b62 (Presentation\u6a21\u5f0f)"

    .line 172
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    const-string v2, "\u505c\u6b62\u622a\u56fe\u670d\u52a1\u5931\u8d25"

    .line 174
    invoke-static {v0, v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_0
    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    .line 96
    invoke-super {p0, p1}, Landroid/app/Presentation;->onCreate(Landroid/os/Bundle;)V

    sput-object p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->instance:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 98
    new-instance p1, Landroid/webkit/WebView;

    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-direct {p1, v0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    .line 100
    invoke-virtual {p1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p1

    const/4 v0, 0x1

    .line 101
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    const/4 v1, 0x2

    .line 102
    invoke-virtual {p1, v1}, Landroid/webkit/WebSettings;->setCacheMode(I)V

    .line 103
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 104
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    .line 105
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setAllowContentAccess(Z)V

    .line 106
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    const/4 v1, 0x0

    .line 107
    invoke-virtual {p1, v1}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V

    .line 108
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    .line 110
    new-instance v1, Landroid/webkit/WebViewClient;

    invoke-direct {v1}, Landroid/webkit/WebViewClient;-><init>()V

    invoke-virtual {p1, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    .line 111
    new-instance v1, Lplugins/MultiScreenPlugin/WebViewPresentation$3;

    invoke-direct {v1, p0}, Lplugins/MultiScreenPlugin/WebViewPresentation$3;-><init>(Lplugins/MultiScreenPlugin/WebViewPresentation;)V

    invoke-virtual {p1, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->activity:Landroid/app/Activity;

    const-string v1, "android.permission.CAMERA"

    .line 123
    invoke-static {p1, v1}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result p1

    const-string v2, "android.permission.RECORD_AUDIO"

    if-nez p1, :cond_1

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->activity:Landroid/app/Activity;

    .line 125
    invoke-static {p1, v2}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    .line 134
    new-instance v0, Lplugins/MultiScreenPlugin/WebAppInterface;

    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Lplugins/MultiScreenPlugin/WebAppInterface;-><init>(Landroid/content/Context;)V

    const-string v1, "AndroidInterface"

    invoke-virtual {p1, v0, v1}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    .line 135
    invoke-virtual {p0, p1}, Lplugins/MultiScreenPlugin/WebViewPresentation;->setContentView(Landroid/view/View;)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->url:Ljava/lang/String;

    .line 136
    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 139
    new-instance p1, Landroid/content/IntentFilter;

    invoke-direct {p1}, Landroid/content/IntentFilter;-><init>()V

    const-string v0, "multi_screen.main_screen_message"

    .line 140
    invoke-virtual {p1, v0}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 141
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroidx/localbroadcastmanager/content/LocalBroadcastManager;

    move-result-object v0

    iget-object v1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1, p1}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)V

    .line 144
    invoke-direct {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->startScreenCaptureService()V

    return-void

    :cond_1
    :goto_0
    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->activity:Landroid/app/Activity;

    .line 127
    filled-new-array {v1, v2}, [Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v1, v0}, Landroidx/core/app/ActivityCompat;->requestPermissions(Landroid/app/Activity;[Ljava/lang/String;I)V

    return-void
.end method

.method public onDetachedFromWindow()V
    .locals 3

    .line 198
    invoke-direct {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->stopScreenCaptureService()V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const-string v2, "AndroidInterface"

    .line 201
    invoke-virtual {v0, v2}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    .line 202
    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V

    iput-object v1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    :cond_0
    iput-object v1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->currentPermissionRequest:Landroid/webkit/PermissionRequest;

    .line 206
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroidx/localbroadcastmanager/content/LocalBroadcastManager;

    move-result-object v0

    iget-object v2, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v2}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    sget-object v0, Lplugins/MultiScreenPlugin/WebViewPresentation;->instance:Lplugins/MultiScreenPlugin/WebViewPresentation;

    if-ne v0, p0, :cond_1

    sput-object v1, Lplugins/MultiScreenPlugin/WebViewPresentation;->instance:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 212
    :cond_1
    invoke-super {p0}, Landroid/app/Presentation;->onDetachedFromWindow()V

    return-void
.end method

.method public onStart()V
    .locals 1

    .line 181
    invoke-super {p0}, Landroid/app/Presentation;->onStart()V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 183
    invoke-virtual {v0}, Landroid/webkit/WebView;->onResume()V

    :cond_0
    return-void
.end method

.method public onStop()V
    .locals 1

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewPresentation;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 190
    invoke-virtual {v0}, Landroid/webkit/WebView;->onPause()V

    .line 192
    :cond_0
    invoke-super {p0}, Landroid/app/Presentation;->onStop()V

    return-void
.end method
