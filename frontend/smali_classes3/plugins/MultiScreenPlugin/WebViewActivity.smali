.class public Lplugins/MultiScreenPlugin/WebViewActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "WebViewActivity.java"


# static fields
.field private static final PERMISSION_REQUEST_CODE:I = 0x1

.field public static instance:Lplugins/MultiScreenPlugin/WebViewActivity;


# instance fields
.field private currentPermissionRequest:Landroid/webkit/PermissionRequest;

.field private isServiceBound:Z

.field private receiver:Landroid/content/BroadcastReceiver;

.field private screenCaptureService:Lplugins/MultiScreenPlugin/ScreenCaptureService;

.field private serviceConnection:Landroid/content/ServiceConnection;

.field private url:Ljava/lang/String;

.field private webView:Landroid/webkit/WebView;


# direct methods
.method static bridge synthetic -$$Nest$fgetscreenCaptureService(Lplugins/MultiScreenPlugin/WebViewActivity;)Lplugins/MultiScreenPlugin/ScreenCaptureService;
    .locals 0

    iget-object p0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->screenCaptureService:Lplugins/MultiScreenPlugin/ScreenCaptureService;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fgetwebView(Lplugins/MultiScreenPlugin/WebViewActivity;)Landroid/webkit/WebView;
    .locals 0

    iget-object p0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$fputcurrentPermissionRequest(Lplugins/MultiScreenPlugin/WebViewActivity;Landroid/webkit/PermissionRequest;)V
    .locals 0

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->currentPermissionRequest:Landroid/webkit/PermissionRequest;

    return-void
.end method

.method static bridge synthetic -$$Nest$fputisServiceBound(Lplugins/MultiScreenPlugin/WebViewActivity;Z)V
    .locals 0

    iput-boolean p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->isServiceBound:Z

    return-void
.end method

.method static bridge synthetic -$$Nest$fputscreenCaptureService(Lplugins/MultiScreenPlugin/WebViewActivity;Lplugins/MultiScreenPlugin/ScreenCaptureService;)V
    .locals 0

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->screenCaptureService:Lplugins/MultiScreenPlugin/ScreenCaptureService;

    return-void
.end method

.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 34
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->isServiceBound:Z

    .line 45
    new-instance v0, Lplugins/MultiScreenPlugin/WebViewActivity$1;

    invoke-direct {v0, p0}, Lplugins/MultiScreenPlugin/WebViewActivity$1;-><init>(Lplugins/MultiScreenPlugin/WebViewActivity;)V

    iput-object v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->receiver:Landroid/content/BroadcastReceiver;

    .line 60
    new-instance v0, Lplugins/MultiScreenPlugin/WebViewActivity$2;

    invoke-direct {v0, p0}, Lplugins/MultiScreenPlugin/WebViewActivity$2;-><init>(Lplugins/MultiScreenPlugin/WebViewActivity;)V

    iput-object v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->serviceConnection:Landroid/content/ServiceConnection;

    return-void
.end method

.method private startScreenCaptureService()V
    .locals 3

    .line 134
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lplugins/MultiScreenPlugin/ScreenCaptureService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 135
    invoke-virtual {p0, v0}, Lplugins/MultiScreenPlugin/WebViewActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    iget-object v1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->serviceConnection:Landroid/content/ServiceConnection;

    const/4 v2, 0x1

    .line 136
    invoke-virtual {p0, v0, v1, v2}, Lplugins/MultiScreenPlugin/WebViewActivity;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    return-void
.end method

.method private stopScreenCaptureService()V
    .locals 2

    iget-boolean v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->isServiceBound:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->serviceConnection:Landroid/content/ServiceConnection;

    .line 144
    invoke-virtual {p0, v0}, Lplugins/MultiScreenPlugin/WebViewActivity;->unbindService(Landroid/content/ServiceConnection;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->isServiceBound:Z

    .line 147
    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lplugins/MultiScreenPlugin/ScreenCaptureService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 148
    invoke-virtual {p0, v0}, Lplugins/MultiScreenPlugin/WebViewActivity;->stopService(Landroid/content/Intent;)Z

    return-void
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .locals 3

    .line 84
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    sput-object p0, Lplugins/MultiScreenPlugin/WebViewActivity;->instance:Lplugins/MultiScreenPlugin/WebViewActivity;

    .line 86
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "url"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->url:Ljava/lang/String;

    .line 87
    new-instance p1, Landroid/webkit/WebView;

    invoke-direct {p1, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    .line 88
    invoke-virtual {p1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object p1

    const/4 v0, 0x1

    .line 89
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    const/4 v1, 0x2

    .line 90
    invoke-virtual {p1, v1}, Landroid/webkit/WebSettings;->setCacheMode(I)V

    .line 91
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    .line 92
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V

    .line 93
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setAllowContentAccess(Z)V

    .line 94
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    const/4 v1, 0x0

    .line 95
    invoke-virtual {p1, v1}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V

    .line 96
    invoke-virtual {p1, v0}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    .line 99
    new-instance v1, Lplugins/MultiScreenPlugin/WebAppInterface;

    invoke-direct {v1, p0}, Lplugins/MultiScreenPlugin/WebAppInterface;-><init>(Landroid/content/Context;)V

    const-string v2, "AndroidInterface"

    invoke-virtual {p1, v1, v2}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    .line 100
    new-instance v1, Landroid/webkit/WebViewClient;

    invoke-direct {v1}, Landroid/webkit/WebViewClient;-><init>()V

    invoke-virtual {p1, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    .line 101
    new-instance v1, Lplugins/MultiScreenPlugin/WebViewActivity$3;

    invoke-direct {v1, p0}, Lplugins/MultiScreenPlugin/WebViewActivity$3;-><init>(Lplugins/MultiScreenPlugin/WebViewActivity;)V

    invoke-virtual {p1, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    .line 109
    invoke-virtual {p0, p1}, Lplugins/MultiScreenPlugin/WebViewActivity;->setContentView(Landroid/view/View;)V

    const-string p1, "android.permission.CAMERA"

    .line 111
    invoke-static {p0, p1}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    const-string v2, "android.permission.RECORD_AUDIO"

    if-nez v1, :cond_1

    .line 113
    invoke-static {p0, v2}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->url:Ljava/lang/String;

    .line 119
    invoke-virtual {p1, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    goto :goto_1

    .line 115
    :cond_1
    :goto_0
    filled-new-array {p1, v2}, [Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1, v0}, Landroidx/core/app/ActivityCompat;->requestPermissions(Landroid/app/Activity;[Ljava/lang/String;I)V

    .line 122
    :goto_1
    new-instance p1, Landroid/content/IntentFilter;

    invoke-direct {p1}, Landroid/content/IntentFilter;-><init>()V

    const-string v0, "multi_screen.main_screen_message"

    .line 123
    invoke-virtual {p1, v0}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 124
    invoke-static {p0}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroidx/localbroadcastmanager/content/LocalBroadcastManager;

    move-result-object v0

    iget-object v1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v1, p1}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)V

    .line 127
    invoke-direct {p0}, Lplugins/MultiScreenPlugin/WebViewActivity;->startScreenCaptureService()V

    return-void
.end method

.method public onDestroy()V
    .locals 3

    .line 172
    invoke-direct {p0}, Lplugins/MultiScreenPlugin/WebViewActivity;->stopScreenCaptureService()V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const-string v2, "AndroidInterface"

    .line 175
    invoke-virtual {v0, v2}, Landroid/webkit/WebView;->removeJavascriptInterface(Ljava/lang/String;)V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    .line 176
    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V

    iput-object v1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    :cond_0
    iput-object v1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->currentPermissionRequest:Landroid/webkit/PermissionRequest;

    .line 180
    invoke-static {p0}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroidx/localbroadcastmanager/content/LocalBroadcastManager;

    move-result-object v0

    iget-object v2, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v0, v2}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    sget-object v0, Lplugins/MultiScreenPlugin/WebViewActivity;->instance:Lplugins/MultiScreenPlugin/WebViewActivity;

    if-ne v0, p0, :cond_1

    sput-object v1, Lplugins/MultiScreenPlugin/WebViewActivity;->instance:Lplugins/MultiScreenPlugin/WebViewActivity;

    .line 184
    :cond_1
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onDestroy()V

    return-void
.end method

.method public onPause()V
    .locals 1

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 190
    invoke-virtual {v0}, Landroid/webkit/WebView;->onPause()V

    .line 192
    :cond_0
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onPause()V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 0

    .line 153
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AppCompatActivity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    const/4 p2, 0x1

    if-ne p1, p2, :cond_0

    .line 155
    array-length p1, p3

    if-lez p1, :cond_0

    const/4 p1, 0x0

    aget p1, p3, p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    iget-object p2, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->url:Ljava/lang/String;

    .line 156
    invoke-virtual {p1, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public onResume()V
    .locals 1

    .line 163
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onResume()V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity;->webView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 165
    invoke-virtual {v0}, Landroid/webkit/WebView;->onResume()V

    :cond_0
    return-void
.end method
