.class public final Lcom/taobao/accs/ACCSManager;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/accs/ACCSManager$AccsRequest;
    }
.end annotation

.annotation runtime Ljava/lang/Deprecated;
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "ACCSManager"

.field public static mAccsInstances:Ljava/util/Map; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/accs/IACCSManager;",
            ">;"
        }
    .end annotation
.end field

.field public static mDefaultAppKey:Ljava/lang/String; = null

.field public static mDefaultConfigTag:Ljava/lang/String; = "default"

.field public static mEnv:I

.field public static sContext:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 372
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;-><init>(I)V

    sput-object v0, Lcom/taobao/accs/ACCSManager;->mAccsInstances:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static bindApp(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    sget-object p1, Lcom/taobao/accs/ACCSManager;->mDefaultAppKey:Ljava/lang/String;

    const-string v0, ""

    .line 105
    invoke-static {p0, p1, v0, p2, p3}, Lcom/taobao/accs/ACCSManager;->bindApp(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V

    return-void
.end method

.method public static bindApp(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V
    .locals 6
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    sget-object p1, Lcom/taobao/accs/ACCSManager;->mDefaultAppKey:Ljava/lang/String;

    .line 92
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_0

    .line 95
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    sget-object v2, Lcom/taobao/accs/ACCSManager;->mDefaultAppKey:Ljava/lang/String;

    move-object v1, p0

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-interface/range {v0 .. v5}, Lcom/taobao/accs/IACCSManager;->bindApp(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V

    return-void

    .line 93
    :cond_0
    new-instance p0, Ljava/lang/RuntimeException;

    const-string p1, "old interface!!, please AccsManager.setAppkey() first!"

    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static bindService(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 154
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Lcom/taobao/accs/IACCSManager;->bindService(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public static bindUser(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const/4 v0, 0x0

    .line 123
    invoke-static {p0, p1, v0}, Lcom/taobao/accs/ACCSManager;->bindUser(Landroid/content/Context;Ljava/lang/String;Z)V

    return-void
.end method

.method public static bindUser(Landroid/content/Context;Ljava/lang/String;Z)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    sget-object v0, Lcom/taobao/accs/ACCSManager;->mDefaultAppKey:Ljava/lang/String;

    .line 133
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 136
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1, p2}, Lcom/taobao/accs/IACCSManager;->bindUser(Landroid/content/Context;Ljava/lang/String;Z)V

    return-void

    .line 134
    :cond_0
    new-instance p0, Ljava/lang/RuntimeException;

    const-string p1, "old interface!!, please AccsManager.setAppkey() first!"

    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static clearLoginInfoImpl(Landroid/content/Context;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 283
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0}, Lcom/taobao/accs/IACCSManager;->clearLoginInfo(Landroid/content/Context;)V

    return-void
.end method

.method protected static createAccsInstance(Landroid/content/Context;Ljava/lang/String;)Lcom/taobao/accs/IACCSManager;
    .locals 1

    .line 411
    new-instance v0, Lcom/taobao/accs/internal/ACCSManagerImpl;

    invoke-direct {v0, p0, p1}, Lcom/taobao/accs/internal/ACCSManagerImpl;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    return-object v0
.end method

.method public static forceReConnectChannel(Landroid/content/Context;)Ljava/util/Map;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 307
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object p0

    invoke-interface {p0}, Lcom/taobao/accs/IACCSManager;->forceReConnectChannel()Ljava/util/Map;

    move-result-object p0

    return-object p0
.end method

.method public static getAccsInstance(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/IACCSManager;
    .locals 5

    if-eqz p0, :cond_4

    .line 380
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_2

    .line 385
    :cond_0
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "|"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    sget v0, Lcom/taobao/accs/AccsClientConfig;->mEnv:I

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 386
    sget-object v0, Lcom/taobao/accs/utl/ALog$Level;->D:Lcom/taobao/accs/utl/ALog$Level;

    invoke-static {v0}, Lcom/taobao/accs/utl/ALog;->isPrintLog(Lcom/taobao/accs/utl/ALog$Level;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "ACCSManager"

    const-string v1, "getAccsInstance"

    const-string v2, "key"

    .line 387
    filled-new-array {v2, p1}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    sget-object v0, Lcom/taobao/accs/ACCSManager;->mAccsInstances:Ljava/util/Map;

    .line 389
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_3

    const-class v1, Lcom/taobao/accs/ACCSManager;

    .line 391
    monitor-enter v1

    if-nez v0, :cond_2

    .line 394
    :try_start_0
    invoke-static {p0, p2}, Lcom/taobao/accs/ACCSManager;->createAccsInstance(Landroid/content/Context;Ljava/lang/String;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catch_0
    move-exception p0

    :try_start_1
    const-string p2, "ACCSManager"

    const-string v2, "createAccsInstance error"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    .line 396
    invoke-virtual {p0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p0

    const/4 v4, 0x0

    aput-object p0, v3, v4

    invoke-static {p2, v2, v3}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    if-eqz v0, :cond_2

    sget-object p0, Lcom/taobao/accs/ACCSManager;->mAccsInstances:Ljava/util/Map;

    .line 399
    invoke-interface {p0, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 402
    :cond_2
    monitor-exit v1

    goto :goto_1

    :catchall_0
    move-exception p0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0

    :cond_3
    :goto_1
    return-object v0

    :cond_4
    :goto_2
    const-string p0, "ACCSManager"

    const-string p1, "getAccsInstance param null"

    const-string v0, "configTag"

    .line 381
    filled-new-array {v0, p2}, [Ljava/lang/Object;

    move-result-object p2

    invoke-static {p0, p1, p2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 p0, 0x0

    return-object p0
.end method

.method public static getAppKey(Landroid/content/Context;)[Ljava/lang/String;
    .locals 5

    const-string v0, "getAppKey:"

    const/4 v1, 0x0

    :try_start_0
    const-string v2, "EMAS_ACCS_SDK"

    const/4 v3, 0x0

    .line 417
    invoke-virtual {p0, v2, v3}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    const-string v2, "appkey"

    .line 419
    invoke-interface {p0, v2, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    const-string v2, "ACCSManager"

    .line 420
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v2, v0, v3}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 421
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const-string v0, "\\|"

    invoke-virtual {p0, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v1, p0

    goto :goto_0

    :catchall_0
    move-exception p0

    .line 423
    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    return-object v1
.end method

.method public static getChannelState(Landroid/content/Context;)Ljava/util/Map;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 295
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object p0

    invoke-interface {p0}, Lcom/taobao/accs/IACCSManager;->getChannelState()Ljava/util/Map;

    move-result-object p0

    return-object p0
.end method

.method public static getDefaultAppKey(Landroid/content/Context;)Ljava/lang/String;
    .locals 3
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    sget-object v0, Lcom/taobao/accs/ACCSManager;->mDefaultAppKey:Ljava/lang/String;

    .line 61
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "ACCSManager"

    const-string v2, "old interface!!, please AccsManager.setAppkey() first!"

    .line 62
    invoke-static {v1, v2, v0}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v0, "defaultAppkey"

    const/4 v1, 0x0

    .line 63
    invoke-static {p0, v0, v1}, Lcom/taobao/accs/utl/Utils;->getSpValue(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/taobao/accs/ACCSManager;->mDefaultAppKey:Ljava/lang/String;

    .line 65
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_0

    const-string p0, "0"

    sput-object p0, Lcom/taobao/accs/ACCSManager;->mDefaultAppKey:Ljava/lang/String;

    :cond_0
    sget-object p0, Lcom/taobao/accs/ACCSManager;->mDefaultAppKey:Ljava/lang/String;

    return-object p0
.end method

.method public static getDefaultConfig(Landroid/content/Context;)Ljava/lang/String;
    .locals 0

    sget-object p0, Lcom/taobao/accs/ACCSManager;->mDefaultConfigTag:Ljava/lang/String;

    return-object p0
.end method

.method private static declared-synchronized getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;
    .locals 3

    const-class v0, Lcom/taobao/accs/ACCSManager;

    monitor-enter v0

    .line 369
    :try_start_0
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getDefaultConfig(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {p0, v2, v1}, Lcom/taobao/accs/ACCSManager;->getAccsInstance(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/IACCSManager;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object p0

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static getUserUnit(Landroid/content/Context;)Ljava/lang/String;
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const/4 p0, 0x0

    return-object p0
.end method

.method public static isChannelError(Landroid/content/Context;I)Z
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 327
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object p0

    invoke-interface {p0, p1}, Lcom/taobao/accs/IACCSManager;->isChannelError(I)Z

    move-result p0

    return p0
.end method

.method public static isNetworkReachable(Landroid/content/Context;)Z
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 240
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0}, Lcom/taobao/accs/IACCSManager;->isNetworkReachable(Landroid/content/Context;)Z

    move-result p0

    return p0
.end method

.method public static registerDataListener(Landroid/content/Context;Ljava/lang/String;Lcom/taobao/accs/base/AccsAbstractDataListener;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 353
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    if-nez v0, :cond_0

    const/4 p0, 0x0

    new-array p0, p0, [Ljava/lang/Object;

    const-string p1, "ACCSManager"

    const-string p2, "getManagerImpl null, return"

    .line 354
    invoke-static {p1, p2, p0}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 357
    :cond_0
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1, p2}, Lcom/taobao/accs/IACCSManager;->registerDataListener(Landroid/content/Context;Ljava/lang/String;Lcom/taobao/accs/base/AccsAbstractDataListener;)V

    return-void
.end method

.method public static registerService(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 336
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1, p2}, Lcom/taobao/accs/IACCSManager;->registerService(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static sendData(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 192
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Lcom/taobao/accs/IACCSManager;->sendData(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static sendData(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;)Ljava/lang/String;
    .locals 6
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 174
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-interface/range {v0 .. v5}, Lcom/taobao/accs/IACCSManager;->sendData(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static sendData(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 187
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    invoke-interface/range {v0 .. v6}, Lcom/taobao/accs/IACCSManager;->sendData(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static sendData(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/net/URL;)Ljava/lang/String;
    .locals 8
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 180
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    move-object v7, p6

    invoke-interface/range {v0 .. v7}, Lcom/taobao/accs/IACCSManager;->sendData(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/net/URL;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static sendPushResponse(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;)Ljava/lang/String;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 235
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1, p2}, Lcom/taobao/accs/IACCSManager;->sendPushResponse(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static sendRequest(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 217
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Lcom/taobao/accs/IACCSManager;->sendRequest(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static sendRequest(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;)Ljava/lang/String;
    .locals 6
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    .line 205
    invoke-static/range {v0 .. v5}, Lcom/taobao/accs/ACCSManager;->sendRequest(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static sendRequest(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 211
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    invoke-interface/range {v0 .. v6}, Lcom/taobao/accs/IACCSManager;->sendRequest(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static sendRequest(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/net/URL;)Ljava/lang/String;
    .locals 8
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 198
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    move-object v7, p6

    invoke-interface/range {v0 .. v7}, Lcom/taobao/accs/IACCSManager;->sendRequest(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/net/URL;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static setAppKey(Landroid/content/Context;Ljava/lang/String;I)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 45
    invoke-static {p0, p1}, Lcom/taobao/accs/utl/Utils;->setAgooAppKey(Landroid/content/Context;Ljava/lang/String;)V

    .line 46
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    sput-object p0, Lcom/taobao/accs/ACCSManager;->sContext:Landroid/content/Context;

    sput-object p1, Lcom/taobao/accs/ACCSManager;->mDefaultAppKey:Ljava/lang/String;

    const-string v0, "defaultAppkey"

    .line 48
    invoke-static {p0, v0, p1}, Lcom/taobao/accs/utl/Utils;->setSpValue(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    sput p2, Lcom/taobao/accs/ACCSManager;->mEnv:I

    .line 50
    sput p2, Lcom/taobao/accs/AccsClientConfig;->mEnv:I

    return-void
.end method

.method public static setDefaultConfig(Ljava/lang/String;)V
    .locals 3
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 75
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "configTag"

    .line 76
    filled-new-array {v0, p0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ACCSManager"

    const-string v2, "setDefaultConfig"

    invoke-static {v1, v2, v0}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    sput-object p0, Lcom/taobao/accs/ACCSManager;->mDefaultConfigTag:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public static setLoginInfoImpl(Landroid/content/Context;Lcom/taobao/accs/ILoginInfo;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 278
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Lcom/taobao/accs/IACCSManager;->setLoginInfo(Landroid/content/Context;Lcom/taobao/accs/ILoginInfo;)V

    return-void
.end method

.method public static setMode(Landroid/content/Context;I)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    sput p1, Lcom/taobao/accs/ACCSManager;->mEnv:I

    .line 255
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Lcom/taobao/accs/IACCSManager;->setMode(Landroid/content/Context;I)V

    return-void
.end method

.method public static setProxy(Landroid/content/Context;Ljava/lang/String;I)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 260
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1, p2}, Lcom/taobao/accs/IACCSManager;->setProxy(Landroid/content/Context;Ljava/lang/String;I)V

    return-void
.end method

.method public static setServiceListener(Landroid/content/Context;Ljava/lang/String;Lcom/taobao/accs/IServiceReceiver;)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    return-void
.end method

.method public static startInAppConnection(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    sget-object p1, Lcom/taobao/accs/ACCSManager;->mDefaultAppKey:Ljava/lang/String;

    const-string v0, ""

    .line 273
    invoke-static {p0, p1, v0, p2, p3}, Lcom/taobao/accs/ACCSManager;->startInAppConnection(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V

    return-void
.end method

.method public static startInAppConnection(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V
    .locals 6
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 266
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    sget-object v2, Lcom/taobao/accs/ACCSManager;->mDefaultAppKey:Ljava/lang/String;

    move-object v1, p0

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    invoke-interface/range {v0 .. v5}, Lcom/taobao/accs/IACCSManager;->startInAppConnection(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V

    return-void
.end method

.method public static unRegisterDataListener(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 365
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Lcom/taobao/accs/IACCSManager;->unRegisterDataListener(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public static unbindApp(Landroid/content/Context;)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    return-void
.end method

.method public static unbindService(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 163
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Lcom/taobao/accs/IACCSManager;->unbindService(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public static unbindUser(Landroid/content/Context;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 145
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0}, Lcom/taobao/accs/IACCSManager;->unbindUser(Landroid/content/Context;)V

    return-void
.end method

.method public static unregisterService(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 341
    invoke-static {p0}, Lcom/taobao/accs/ACCSManager;->getManagerImpl(Landroid/content/Context;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Lcom/taobao/accs/IACCSManager;->unRegisterService(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method
