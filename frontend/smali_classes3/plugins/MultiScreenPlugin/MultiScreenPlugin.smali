.class public Lplugins/MultiScreenPlugin/MultiScreenPlugin;
.super Lcom/getcapacitor/Plugin;
.source "MultiScreenPlugin.java"


# annotations
.annotation runtime Lcom/getcapacitor/annotation/CapacitorPlugin;
    name = "MultiScreen"
.end annotation


# static fields
.field public static presentation:Landroid/app/Presentation;


# instance fields
.field private receiver:Landroid/content/BroadcastReceiver;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 36
    invoke-direct {p0}, Lcom/getcapacitor/Plugin;-><init>()V

    .line 39
    new-instance v0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$1;

    invoke-direct {v0, p0}, Lplugins/MultiScreenPlugin/MultiScreenPlugin$1;-><init>(Lplugins/MultiScreenPlugin/MultiScreenPlugin;)V

    iput-object v0, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->receiver:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method private _terminate(Ljava/lang/Runnable;)V
    .locals 3

    .line 166
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    sget-object v1, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->presentation:Landroid/app/Presentation;

    if-eqz v1, :cond_0

    const/4 v2, 0x0

    sput-object v2, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->presentation:Landroid/app/Presentation;

    .line 170
    new-instance v2, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda0;

    invoke-direct {v2, v1, p1}, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda0;-><init>(Landroid/app/Presentation;Ljava/lang/Runnable;)V

    invoke-virtual {v0, v2}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void

    .line 179
    :cond_0
    sget-object v1, Lplugins/MultiScreenPlugin/WebViewActivity;->instance:Lplugins/MultiScreenPlugin/WebViewActivity;

    if-eqz v1, :cond_1

    .line 181
    new-instance v2, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda1;

    invoke-direct {v2, v1, p1}, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda1;-><init>(Lplugins/MultiScreenPlugin/WebViewActivity;Ljava/lang/Runnable;)V

    invoke-virtual {v0, v2}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    :cond_1
    return-void
.end method

.method static synthetic access$000(Lplugins/MultiScreenPlugin/MultiScreenPlugin;Ljava/lang/String;Lcom/getcapacitor/JSObject;)V
    .locals 0

    .line 36
    invoke-virtual {p0, p1, p2}, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->notifyListeners(Ljava/lang/String;Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method private getDeviceIpAddress()Ljava/lang/String;
    .locals 3

    .line 154
    :try_start_0
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "wifi"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    if-eqz v0, :cond_0

    .line 156
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/wifi/WifiInfo;->getIpAddress()I

    move-result v0

    .line 157
    invoke-static {v0}, Landroid/text/format/Formatter;->formatIpAddress(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    const-string v1, "MultiScreenPlugin"

    const-string v2, "\u83b7\u53d6IP\u5730\u5740\u5931\u8d25"

    .line 160
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method static synthetic lambda$_terminate$3(Landroid/app/Presentation;Ljava/lang/Runnable;)V
    .locals 1

    .line 171
    invoke-virtual {p0}, Landroid/app/Presentation;->dismiss()V

    const-string p0, "MultiScreenPlugin"

    const-string v0, "Presentation\u6a21\u5f0f\u5df2\u7ec8\u6b62"

    .line 172
    invoke-static {p0, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p1, :cond_0

    .line 174
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    :cond_0
    return-void
.end method

.method static synthetic lambda$_terminate$4(Lplugins/MultiScreenPlugin/WebViewActivity;Ljava/lang/Runnable;)V
    .locals 1

    .line 182
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/WebViewActivity;->finish()V

    const-string p0, "MultiScreenPlugin"

    const-string v0, "WebViewActivity\u6a21\u5f0f\u5df2\u7ec8\u6b62"

    .line 183
    invoke-static {p0, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-eqz p1, :cond_0

    .line 185
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    :cond_0
    return-void
.end method

.method static synthetic lambda$open$0()V
    .locals 0

    return-void
.end method

.method static synthetic lambda$open$1(Landroid/app/Activity;Landroid/view/Display;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V
    .locals 1

    .line 83
    new-instance v0, Lplugins/MultiScreenPlugin/WebViewPresentation;

    invoke-direct {v0, p0, p1, p2}, Lplugins/MultiScreenPlugin/WebViewPresentation;-><init>(Landroid/app/Activity;Landroid/view/Display;Ljava/lang/String;)V

    sput-object v0, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->presentation:Landroid/app/Presentation;

    .line 85
    :try_start_0
    invoke-virtual {v0}, Landroid/app/Presentation;->show()V

    const-string p0, "MultiScreenPlugin"

    const-string p1, "\u542f\u7528Presentation\u6a21\u5f0f"

    .line 86
    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 87
    invoke-virtual {p3}, Lcom/getcapacitor/PluginCall;->resolve()V
    :try_end_0
    .catch Landroid/view/WindowManager$InvalidDisplayException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p0

    .line 89
    new-instance p1, Ljava/lang/StringBuilder;

    const-string p2, "Failed to show presentation: "

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Landroid/view/WindowManager$InvalidDisplayException;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p3, p0}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method static synthetic lambda$terminate$2(Lcom/getcapacitor/PluginCall;)V
    .locals 0

    .line 128
    invoke-virtual {p0}, Lcom/getcapacitor/PluginCall;->resolve()V

    return-void
.end method


# virtual methods
.method public getMjpegStreamUrl(Lcom/getcapacitor/PluginCall;)V
    .locals 3
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    const-string v0, "http://localhost:"

    .line 137
    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->getMjpegPort()I

    move-result v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 138
    new-instance v1, Lcom/getcapacitor/JSObject;

    invoke-direct {v1}, Lcom/getcapacitor/JSObject;-><init>()V

    const-string v2, "url"

    .line 139
    invoke-virtual {v1, v2, v0}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 140
    invoke-virtual {p1, v1}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 145
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u83b7\u53d6MJPEG\u6d41URL\u5931\u8d25: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method public load()V
    .locals 3

    .line 61
    invoke-super {p0}, Lcom/getcapacitor/Plugin;->load()V

    .line 63
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    const-string v1, "multi_screen.second_screen_message"

    .line 64
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 65
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-static {v1}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroidx/localbroadcastmanager/content/LocalBroadcastManager;

    move-result-object v1

    iget-object v2, p0, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)V

    return-void
.end method

.method public open(Lcom/getcapacitor/PluginCall;)V
    .locals 6
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    .line 70
    new-instance v0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda3;

    invoke-direct {v0}, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda3;-><init>()V

    invoke-direct {p0, v0}, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->_terminate(Ljava/lang/Runnable;)V

    const-string v0, "url"

    .line 71
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 72
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v2

    const-string v3, "display"

    .line 73
    invoke-virtual {v2, v3}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/hardware/display/DisplayManager;

    .line 74
    invoke-virtual {v3}, Landroid/hardware/display/DisplayManager;->getDisplays()[Landroid/view/Display;

    move-result-object v3

    .line 76
    array-length v4, v3

    const/4 v5, 0x1

    if-le v4, v5, :cond_1

    .line 77
    aget-object v3, v3, v5

    .line 78
    invoke-virtual {v3}, Landroid/view/Display;->getFlags()I

    move-result v4

    and-int/lit8 v4, v4, 0x8

    if-eqz v4, :cond_0

    .line 81
    new-instance v0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda4;

    invoke-direct {v0, v2, v3, v1, p1}, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda4;-><init>(Landroid/app/Activity;Landroid/view/Display;Ljava/lang/String;Lcom/getcapacitor/PluginCall;)V

    invoke-virtual {v2, v0}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_0

    .line 95
    :cond_0
    :try_start_0
    new-instance v4, Landroid/content/Intent;

    const-class v5, Lplugins/MultiScreenPlugin/WebViewActivity;

    invoke-direct {v4, v2, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 96
    invoke-virtual {v4, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 97
    invoke-static {}, Landroid/app/ActivityOptions;->makeBasic()Landroid/app/ActivityOptions;

    move-result-object v0

    .line 98
    invoke-virtual {v3}, Landroid/view/Display;->getDisplayId()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/app/ActivityOptions;->setLaunchDisplayId(I)Landroid/app/ActivityOptions;

    .line 99
    invoke-virtual {v0}, Landroid/app/ActivityOptions;->toBundle()Landroid/os/Bundle;

    move-result-object v0

    invoke-virtual {v2, v4, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;Landroid/os/Bundle;)V

    const-string v0, "MultiScreenPlugin"

    const-string v1, "\u542f\u7528WebViewActivity\u6a21\u5f0f"

    .line 100
    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 101
    invoke-virtual {p1}, Lcom/getcapacitor/PluginCall;->resolve()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 103
    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    const-string v0, "No secondary presentation display available"

    .line 107
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->reject(Ljava/lang/String;)V

    :goto_0
    return-void
.end method

.method public postMessage(Lcom/getcapacitor/PluginCall;)V
    .locals 3
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    const-string v0, "name"

    .line 113
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;)Ljava/lang/String;

    const-string v0, "data"

    .line 114
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->getObject(Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 115
    invoke-virtual {p1}, Lcom/getcapacitor/PluginCall;->getData()Lcom/getcapacitor/JSObject;

    move-result-object v0

    .line 118
    invoke-virtual {v0}, Lcom/getcapacitor/JSObject;->toString()Ljava/lang/String;

    move-result-object v0

    .line 120
    new-instance v1, Landroid/content/Intent;

    const-string v2, "multi_screen.main_screen_message"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v2, "message"

    .line 121
    invoke-virtual {v1, v2, v0}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 122
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-static {v0}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroidx/localbroadcastmanager/content/LocalBroadcastManager;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->sendBroadcast(Landroid/content/Intent;)Z

    .line 123
    invoke-virtual {p1}, Lcom/getcapacitor/PluginCall;->resolve()V

    return-void
.end method

.method public terminate(Lcom/getcapacitor/PluginCall;)V
    .locals 1
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    .line 128
    new-instance v0, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda2;

    invoke-direct {v0, p1}, Lplugins/MultiScreenPlugin/MultiScreenPlugin$$ExternalSyntheticLambda2;-><init>(Lcom/getcapacitor/PluginCall;)V

    invoke-direct {p0, v0}, Lplugins/MultiScreenPlugin/MultiScreenPlugin;->_terminate(Ljava/lang/Runnable;)V

    return-void
.end method
