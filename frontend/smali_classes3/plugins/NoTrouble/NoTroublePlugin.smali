.class public Lplugins/NoTrouble/NoTroublePlugin;
.super Lcom/getcapacitor/Plugin;
.source "NoTroublePlugin.java"


# annotations
.annotation runtime Lcom/getcapacitor/annotation/CapacitorPlugin;
    name = "NoTrouble"
.end annotation


# instance fields
.field private cloudPushService:Lcom/alibaba/sdk/android/push/CloudPushService;

.field private implementation:Lplugins/NoTrouble/NoTrouble;

.field pushChannelOpenedData:Landroidx/lifecycle/MutableLiveData;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/lifecycle/MutableLiveData<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private receiver:Landroid/content/BroadcastReceiver;


# direct methods
.method public static synthetic $r8$lambda$NQXhh17xki1f3m2eyiq1pXkyv0w(Lplugins/NoTrouble/NoTroublePlugin;Lcom/getcapacitor/PluginCall;Ljava/lang/Boolean;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lplugins/NoTrouble/NoTroublePlugin;->lambda$setNotificationConfig$0(Lcom/getcapacitor/PluginCall;Ljava/lang/Boolean;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 43
    invoke-direct {p0}, Lcom/getcapacitor/Plugin;-><init>()V

    .line 47
    invoke-static {}, Lcom/alibaba/sdk/android/push/noonesdk/PushServiceFactory;->getCloudPushService()Lcom/alibaba/sdk/android/push/CloudPushService;

    move-result-object v0

    iput-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin;->cloudPushService:Lcom/alibaba/sdk/android/push/CloudPushService;

    .line 49
    new-instance v0, Landroidx/lifecycle/MutableLiveData;

    const/4 v1, 0x0

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-direct {v0, v1}, Landroidx/lifecycle/MutableLiveData;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin;->pushChannelOpenedData:Landroidx/lifecycle/MutableLiveData;

    .line 52
    new-instance v0, Lplugins/NoTrouble/NoTroublePlugin$1;

    invoke-direct {v0, p0}, Lplugins/NoTrouble/NoTroublePlugin$1;-><init>(Lplugins/NoTrouble/NoTroublePlugin;)V

    iput-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin;->receiver:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method static synthetic access$000(Lplugins/NoTrouble/NoTroublePlugin;Ljava/lang/String;Lcom/getcapacitor/JSObject;)V
    .locals 0

    .line 43
    invoke-virtual {p0, p1, p2}, Lplugins/NoTrouble/NoTroublePlugin;->notifyListeners(Ljava/lang/String;Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method static synthetic lambda$disableKeyboard$1(Landroid/app/Activity;)V
    .locals 1

    .line 342
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object p0

    const/high16 v0, 0x20000

    invoke-virtual {p0, v0, v0}, Landroid/view/Window;->setFlags(II)V

    return-void
.end method

.method private synthetic lambda$setNotificationConfig$0(Lcom/getcapacitor/PluginCall;Ljava/lang/Boolean;)V
    .locals 2

    .line 256
    new-instance p2, Lcom/getcapacitor/JSObject;

    invoke-direct {p2}, Lcom/getcapacitor/JSObject;-><init>()V

    iget-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin;->pushChannelOpenedData:Landroidx/lifecycle/MutableLiveData;

    .line 257
    invoke-virtual {v0}, Landroidx/lifecycle/MutableLiveData;->getValue()Ljava/lang/Object;

    move-result-object v0

    const-string v1, "flag"

    invoke-virtual {p2, v1, v0}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lcom/getcapacitor/JSObject;

    .line 258
    invoke-virtual {p1, p2}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method private onOrientationChanged()V
    .locals 3

    .line 118
    new-instance v0, Lcom/getcapacitor/JSObject;

    invoke-direct {v0}, Lcom/getcapacitor/JSObject;-><init>()V

    iget-object v1, p0, Lplugins/NoTrouble/NoTroublePlugin;->implementation:Lplugins/NoTrouble/NoTrouble;

    .line 119
    invoke-virtual {v1}, Lplugins/NoTrouble/NoTrouble;->getCurrentOrientationType()Ljava/lang/String;

    move-result-object v1

    const-string v2, "type"

    .line 120
    invoke-virtual {v0, v2, v1}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string v1, "screenOrientationChange"

    .line 121
    invoke-virtual {p0, v1, v0}, Lplugins/NoTrouble/NoTroublePlugin;->notifyListeners(Ljava/lang/String;Lcom/getcapacitor/JSObject;)V

    return-void
.end method


# virtual methods
.method public disableKeyboard(Lcom/getcapacitor/PluginCall;)V
    .locals 1
    .annotation runtime Lcom/getcapacitor/PluginMethod;
        returnType = "none"
    .end annotation

    .line 340
    invoke-virtual {p0}, Lplugins/NoTrouble/NoTroublePlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object p1

    .line 341
    new-instance v0, Lplugins/NoTrouble/NoTroublePlugin$$ExternalSyntheticLambda0;

    invoke-direct {v0, p1}, Lplugins/NoTrouble/NoTroublePlugin$$ExternalSyntheticLambda0;-><init>(Landroid/app/Activity;)V

    invoke-virtual {p1, v0}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public getAppInfo(Lcom/getcapacitor/PluginCall;)V
    .locals 6
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    const-string v0, ""

    const/4 v1, 0x0

    .line 141
    :try_start_0
    invoke-virtual {p0}, Lplugins/NoTrouble/NoTroublePlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/appcompat/app/AppCompatActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    .line 142
    invoke-virtual {p0}, Lplugins/NoTrouble/NoTroublePlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v3

    invoke-virtual {v3}, Landroidx/appcompat/app/AppCompatActivity;->getPackageName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v3

    .line 143
    iget-object v4, v3, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 144
    :try_start_1
    iget v1, v3, Landroid/content/pm/PackageInfo;->versionCode:I

    .line 147
    iget-object v3, v3, Landroid/content/pm/PackageInfo;->applicationInfo:Landroid/content/pm/ApplicationInfo;

    invoke-virtual {v3, v2}, Landroid/content/pm/ApplicationInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    if-eqz v4, :cond_0

    .line 149
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v2
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    if-gtz v2, :cond_1

    :cond_0
    return-void

    :catch_0
    move-exception v2

    move-object v3, v2

    move v2, v1

    move-object v1, v0

    move-object v0, v4

    goto :goto_0

    :catch_1
    move-exception v2

    move-object v3, v2

    move v2, v1

    move-object v1, v0

    :goto_0
    const-string v4, "VersionInfo"

    const-string v5, "Exception"

    .line 153
    invoke-static {v4, v5, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-object v4, v0

    move-object v0, v1

    move v1, v2

    :cond_1
    const-string v2, "PDA\u7248\u672c"

    .line 156
    invoke-static {v2, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 158
    new-instance v2, Lcom/getcapacitor/JSObject;

    invoke-direct {v2}, Lcom/getcapacitor/JSObject;-><init>()V

    const-string v3, "platform"

    const-string v5, "android"

    .line 159
    invoke-virtual {v2, v3, v5}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string v3, "version_code"

    .line 160
    invoke-virtual {v2, v3, v1}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;I)Lcom/getcapacitor/JSObject;

    const-string v1, "version_name"

    .line 161
    invoke-virtual {v2, v1, v4}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string v1, "display_name"

    .line 162
    invoke-virtual {v2, v1, v0}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    iget-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin;->cloudPushService:Lcom/alibaba/sdk/android/push/CloudPushService;

    .line 163
    invoke-interface {v0}, Lcom/alibaba/sdk/android/push/CloudPushService;->getDeviceId()Ljava/lang/String;

    move-result-object v0

    const-string v1, "aliyun_device_id"

    invoke-virtual {v2, v1, v0}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 165
    invoke-virtual {p1, v2}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method public getAppList(Lcom/getcapacitor/PluginCall;)V
    .locals 9
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    .line 171
    invoke-virtual {p0}, Lplugins/NoTrouble/NoTroublePlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/appcompat/app/AppCompatActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 172
    new-instance v1, Landroid/content/Intent;

    const-string v2, "android.intent.action.MAIN"

    const/4 v3, 0x0

    invoke-direct {v1, v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    const-string v2, "android.intent.category.LAUNCHER"

    .line 173
    invoke-virtual {v1, v2}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    const/4 v2, 0x0

    .line 175
    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;I)Ljava/util/List;

    move-result-object v1

    .line 177
    new-instance v2, Lcom/getcapacitor/JSObject;

    invoke-direct {v2}, Lcom/getcapacitor/JSObject;-><init>()V

    const-string v3, "platform"

    const-string v4, "android"

    .line 178
    invoke-virtual {v2, v3, v4}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 180
    new-instance v3, Lcom/getcapacitor/JSArray;

    invoke-direct {v3}, Lcom/getcapacitor/JSArray;-><init>()V

    .line 181
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/content/pm/ResolveInfo;

    .line 182
    invoke-virtual {v4, v0}, Landroid/content/pm/ResolveInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    .line 183
    invoke-virtual {v4, v0}, Landroid/content/pm/ResolveInfo;->loadIcon(Landroid/content/pm/PackageManager;)Landroid/graphics/drawable/Drawable;

    move-result-object v6

    .line 184
    iget-object v4, v4, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;

    iget-object v4, v4, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;

    .line 186
    new-instance v7, Lcom/getcapacitor/JSObject;

    invoke-direct {v7}, Lcom/getcapacitor/JSObject;-><init>()V

    const-string v8, "app_name"

    .line 187
    invoke-virtual {v7, v8, v5}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    const-string v5, "app_icon"

    .line 188
    invoke-virtual {v7, v5, v6}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lcom/getcapacitor/JSObject;

    const-string v5, "package_name"

    .line 189
    invoke-virtual {v7, v5, v4}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 190
    invoke-virtual {v3, v7}, Lcom/getcapacitor/JSArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    goto :goto_0

    :cond_0
    const-string v0, "apps"

    .line 193
    invoke-virtual {v2, v0, v3}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lcom/getcapacitor/JSObject;

    .line 195
    invoke-virtual {p1, v2}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method public getNotificationPushStatus(Lcom/getcapacitor/PluginCall;)V
    .locals 2
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    :try_start_0
    iget-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin;->cloudPushService:Lcom/alibaba/sdk/android/push/CloudPushService;

    .line 274
    new-instance v1, Lplugins/NoTrouble/NoTroublePlugin$4;

    invoke-direct {v1, p0, p1}, Lplugins/NoTrouble/NoTroublePlugin$4;-><init>(Lplugins/NoTrouble/NoTroublePlugin;Lcom/getcapacitor/PluginCall;)V

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/push/CloudPushService;->checkPushChannelStatus(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 294
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method

.method public handleOnConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0

    .line 113
    invoke-super {p0, p1}, Lcom/getcapacitor/Plugin;->handleOnConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 114
    invoke-direct {p0}, Lplugins/NoTrouble/NoTroublePlugin;->onOrientationChanged()V

    return-void
.end method

.method public isMicrophoneOccupied(Lcom/getcapacitor/PluginCall;)V
    .locals 4
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    .line 329
    invoke-virtual {p0}, Lplugins/NoTrouble/NoTroublePlugin;->getContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "audio"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    .line 331
    new-instance v1, Lcom/getcapacitor/JSObject;

    invoke-direct {v1}, Lcom/getcapacitor/JSObject;-><init>()V

    const/4 v2, 0x1

    const-string v3, "occupied"

    if-nez v0, :cond_0

    .line 333
    invoke-virtual {v1, v3, v2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Z)Lcom/getcapacitor/JSObject;

    .line 334
    :cond_0
    invoke-virtual {v0}, Landroid/media/AudioManager;->getMode()I

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v1, v3, v2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Z)Lcom/getcapacitor/JSObject;

    .line 335
    invoke-virtual {p1, v1}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method public load()V
    .locals 3

    .line 95
    new-instance v0, Lplugins/NoTrouble/NoTrouble;

    invoke-virtual {p0}, Lplugins/NoTrouble/NoTroublePlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lplugins/NoTrouble/NoTrouble;-><init>(Landroidx/appcompat/app/AppCompatActivity;)V

    iput-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin;->implementation:Lplugins/NoTrouble/NoTrouble;

    .line 98
    :try_start_0
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    const-string v1, "push.notification_opened"

    .line 99
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "push.notification_removed"

    .line 100
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "push.notification"

    .line 101
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    const-string v1, "push.message"

    .line 102
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    .line 104
    invoke-virtual {p0}, Lplugins/NoTrouble/NoTroublePlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-static {v1}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->getInstance(Landroid/content/Context;)Landroidx/localbroadcastmanager/content/LocalBroadcastManager;

    move-result-object v1

    iget-object v2, p0, Lplugins/NoTrouble/NoTroublePlugin;->receiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {v1, v2, v0}, Landroidx/localbroadcastmanager/content/LocalBroadcastManager;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 107
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method

.method public openApp(Lcom/getcapacitor/PluginCall;)V
    .locals 3
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    const-string v0, "package_name"

    .line 201
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 203
    invoke-virtual {p0}, Lplugins/NoTrouble/NoTroublePlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/appcompat/app/AppCompatActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 204
    invoke-virtual {v1, v0}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 206
    invoke-virtual {p0}, Lplugins/NoTrouble/NoTroublePlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroidx/appcompat/app/AppCompatActivity;->startActivity(Landroid/content/Intent;)V

    .line 209
    :cond_0
    new-instance v0, Lcom/getcapacitor/JSObject;

    invoke-direct {v0}, Lcom/getcapacitor/JSObject;-><init>()V

    const-string v1, "platform"

    const-string v2, "android"

    .line 210
    invoke-virtual {v0, v1, v2}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 211
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method public openUrl(Lcom/getcapacitor/PluginCall;)V
    .locals 2
    .annotation runtime Lcom/getcapacitor/PluginMethod;
        returnType = "none"
    .end annotation

    const-string v0, "url"

    .line 317
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    const-string v0, ""

    .line 320
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 321
    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p1

    .line 322
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-direct {v0, v1, p1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    .line 323
    invoke-virtual {p0}, Lplugins/NoTrouble/NoTroublePlugin;->getActivity()Landroidx/appcompat/app/AppCompatActivity;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/AppCompatActivity;->startActivity(Landroid/content/Intent;)V

    :cond_0
    return-void
.end method

.method public orientation(Lcom/getcapacitor/PluginCall;)V
    .locals 3
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    .line 126
    new-instance v0, Lcom/getcapacitor/JSObject;

    invoke-direct {v0}, Lcom/getcapacitor/JSObject;-><init>()V

    iget-object v1, p0, Lplugins/NoTrouble/NoTroublePlugin;->implementation:Lplugins/NoTrouble/NoTrouble;

    .line 127
    invoke-virtual {v1}, Lplugins/NoTrouble/NoTrouble;->getCurrentOrientationType()Ljava/lang/String;

    move-result-object v1

    const-string v2, "type"

    .line 128
    invoke-virtual {v0, v2, v1}, Lcom/getcapacitor/JSObject;->put(Ljava/lang/String;Ljava/lang/String;)Lcom/getcapacitor/JSObject;

    .line 129
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->resolve(Lcom/getcapacitor/JSObject;)V

    return-void
.end method

.method public setNotificationConfig(Lcom/getcapacitor/PluginCall;)V
    .locals 4
    .annotation runtime Lcom/getcapacitor/PluginMethod;
    .end annotation

    :try_start_0
    const-string v0, "flag"

    .line 219
    invoke-virtual {p1, v0}, Lcom/getcapacitor/PluginCall;->getBoolean(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v0

    const-string v1, "NotificationConfig"

    .line 221
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 222
    new-instance v1, Ljava/util/concurrent/CompletableFuture;

    invoke-direct {v1}, Ljava/util/concurrent/CompletableFuture;-><init>()V

    .line 224
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin;->cloudPushService:Lcom/alibaba/sdk/android/push/CloudPushService;

    .line 225
    new-instance v2, Lplugins/NoTrouble/NoTroublePlugin$2;

    invoke-direct {v2, p0, v1}, Lplugins/NoTrouble/NoTroublePlugin$2;-><init>(Lplugins/NoTrouble/NoTroublePlugin;Ljava/util/concurrent/CompletableFuture;)V

    invoke-interface {v0, v2}, Lcom/alibaba/sdk/android/push/CloudPushService;->turnOnPushChannel(Lcom/alibaba/sdk/android/push/CommonCallback;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lplugins/NoTrouble/NoTroublePlugin;->cloudPushService:Lcom/alibaba/sdk/android/push/CloudPushService;

    .line 239
    new-instance v2, Lplugins/NoTrouble/NoTroublePlugin$3;

    invoke-direct {v2, p0, v1}, Lplugins/NoTrouble/NoTroublePlugin$3;-><init>(Lplugins/NoTrouble/NoTroublePlugin;Ljava/util/concurrent/CompletableFuture;)V

    invoke-interface {v0, v2}, Lcom/alibaba/sdk/android/push/CloudPushService;->turnOffPushChannel(Lcom/alibaba/sdk/android/push/CommonCallback;)V

    .line 255
    :goto_0
    new-instance v0, Lplugins/NoTrouble/NoTroublePlugin$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0, p1}, Lplugins/NoTrouble/NoTroublePlugin$$ExternalSyntheticLambda1;-><init>(Lplugins/NoTrouble/NoTroublePlugin;Lcom/getcapacitor/PluginCall;)V

    invoke-virtual {v1, v0}, Ljava/util/concurrent/CompletableFuture;->thenAccept(Ljava/util/function/Consumer;)Ljava/util/concurrent/CompletableFuture;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception p1

    .line 266
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :goto_1
    return-void
.end method
