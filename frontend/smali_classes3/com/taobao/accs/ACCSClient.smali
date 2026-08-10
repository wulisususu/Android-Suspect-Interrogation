.class public Lcom/taobao/accs/ACCSClient;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field private static final DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

.field public static mACCSClients:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/accs/ACCSClient;",
            ">;"
        }
    .end annotation
.end field

.field private static sContext:Landroid/content/Context;


# instance fields
.field protected mAccsManager:Lcom/taobao/accs/IACCSManager;

.field private mConfig:Lcom/taobao/accs/AccsClientConfig;

.field private final mListeners:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Lcom/taobao/accs/ConnectionListener;",
            ">;"
        }
    .end annotation
.end field

.field private final mLog:Lcom/alibaba/sdk/android/logger/ILog;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    const-string v0, "ACCSClient"

    .line 40
    invoke-static {v0}, Lcom/taobao/accs/utl/AccsLogger;->getLogger(Ljava/lang/Object;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    sput-object v0, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    .line 60
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/concurrent/ConcurrentHashMap;-><init>(I)V

    sput-object v0, Lcom/taobao/accs/ACCSClient;->mACCSClients:Ljava/util/Map;

    return-void
.end method

.method public constructor <init>(Lcom/taobao/accs/AccsClientConfig;)V
    .locals 2

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/taobao/accs/ACCSClient;->mListeners:Ljava/util/HashSet;

    iput-object p1, p0, Lcom/taobao/accs/ACCSClient;->mConfig:Lcom/taobao/accs/AccsClientConfig;

    .line 52
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "ACCSClient"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->getTag()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/taobao/accs/utl/AccsLogger;->getLogger(Ljava/lang/Object;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    sget-object v0, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 53
    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->getTag()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, v1, p1}, Lcom/taobao/accs/ACCSManager;->getAccsInstance(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/IACCSManager;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    return-void
.end method

.method public static changeNetworkSdkLoggerToAccs()V
    .locals 3

    sget-object v0, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "changeNetworkSdkLoggerToAccs"

    .line 66
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    .line 67
    new-instance v0, Lcom/taobao/accs/utl/k;

    new-instance v1, Lcom/taobao/accs/utl/l;

    invoke-direct {v1}, Lcom/taobao/accs/utl/l;-><init>()V

    invoke-static {}, Lcom/taobao/accs/utl/i;->a()Lcom/taobao/accs/utl/i;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Lcom/taobao/accs/utl/k;-><init>(Lanet/channel/util/ALog$ILog;Lcom/taobao/accs/utl/k$a;)V

    invoke-static {v0}, Lanet/channel/util/ALog;->setLog(Lanet/channel/util/ALog$ILog;)V

    return-void
.end method

.method public static enableChannelProcess(Landroid/content/Context;Z)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 140
    invoke-static {p0, p1}, Lcom/taobao/accs/utl/UtilityImpl;->a(Landroid/content/Context;Z)V

    return-void
.end method

.method public static enableChannelProcessHeartbeat(Landroid/content/Context;Z)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    return-void
.end method

.method public static declared-synchronized getAccsClient(Ljava/lang/String;)Lcom/taobao/accs/ACCSClient;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/taobao/accs/AccsException;
        }
    .end annotation

    const-class v0, Lcom/taobao/accs/ACCSClient;

    monitor-enter v0

    .line 106
    :try_start_0
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string p0, "default"

    sget-object v1, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v2, "getAccsClient with null tag, use default"

    .line 108
    invoke-interface {v1, v2}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    .line 110
    :cond_0
    invoke-static {p0}, Lcom/taobao/accs/AccsClientConfig;->getConfigByTag(Ljava/lang/String;)Lcom/taobao/accs/AccsClientConfig;

    move-result-object v1

    const/4 v2, 0x2

    const/4 v3, 0x1

    const/4 v4, 0x0

    const/4 v5, 0x3

    if-eqz v1, :cond_3

    sget-object v6, Lcom/taobao/accs/ACCSClient;->mACCSClients:Ljava/util/Map;

    .line 115
    invoke-interface {v6, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/taobao/accs/ACCSClient;

    if-nez v6, :cond_1

    sget-object v2, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v3, "getAccsClient create client"

    .line 117
    invoke-interface {v2, v3}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    .line 118
    new-instance v2, Lcom/taobao/accs/ACCSClient;

    invoke-direct {v2, v1}, Lcom/taobao/accs/ACCSClient;-><init>(Lcom/taobao/accs/AccsClientConfig;)V

    sget-object v3, Lcom/taobao/accs/ACCSClient;->mACCSClients:Ljava/util/Map;

    .line 119
    invoke-interface {v3, p0, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 121
    invoke-direct {v2, v1}, Lcom/taobao/accs/ACCSClient;->updateConfig(Lcom/taobao/accs/AccsClientConfig;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 122
    monitor-exit v0

    return-object v2

    .line 125
    :cond_1
    :try_start_1
    iget-object p0, v6, Lcom/taobao/accs/ACCSClient;->mConfig:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v1, p0}, Lcom/taobao/accs/AccsClientConfig;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    goto :goto_0

    :cond_2
    sget-object p0, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    const/4 v7, 0x5

    new-array v7, v7, [Ljava/lang/Object;

    const-string v8, "getAccsClient update config"

    aput-object v8, v7, v4

    const-string v4, "old"

    aput-object v4, v7, v3

    .line 128
    iget-object v3, v6, Lcom/taobao/accs/ACCSClient;->mConfig:Lcom/taobao/accs/AccsClientConfig;

    aput-object v3, v7, v2

    const-string v2, "new"

    aput-object v2, v7, v5

    const/4 v2, 0x4

    aput-object v1, v7, v2

    invoke-interface {p0, v7}, Lcom/alibaba/sdk/android/logger/ILog;->w([Ljava/lang/Object;)V

    .line 129
    invoke-direct {v6, v1}, Lcom/taobao/accs/ACCSClient;->updateConfig(Lcom/taobao/accs/AccsClientConfig;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 131
    :goto_0
    monitor-exit v0

    return-object v6

    :cond_3
    :try_start_2
    sget-object v1, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    new-array v5, v5, [Ljava/lang/Object;

    const-string v6, "getAccsClient with null config, please init config first"

    aput-object v6, v5, v4

    const-string v4, "configTag"

    aput-object v4, v5, v3

    aput-object p0, v5, v2

    .line 112
    invoke-interface {v1, v5}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    .line 113
    new-instance p0, Lcom/taobao/accs/AccsException;

    const-string v1, "configTag not exist"

    invoke-direct {p0, v1}, Lcom/taobao/accs/AccsException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized init(Landroid/content/Context;Lcom/taobao/accs/AccsClientConfig;)Ljava/lang/String;
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/taobao/accs/AccsException;
        }
    .end annotation

    const-class v0, Lcom/taobao/accs/ACCSClient;

    monitor-enter v0

    const/4 v1, 0x3

    const/4 v2, 0x2

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-eqz p0, :cond_0

    if-eqz p1, :cond_0

    .line 84
    :try_start_0
    invoke-static {p0}, Lcom/taobao/accs/client/GlobalClientInfo;->getInstance(Landroid/content/Context;)Lcom/taobao/accs/client/GlobalClientInfo;

    .line 85
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v5

    sput-object v5, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 86
    invoke-static {p0}, Lcom/taobao/accs/ACCSClient;->setCurrentProcessName(Landroid/content/Context;)V

    sget-object p0, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    new-array v1, v1, [Ljava/lang/Object;

    const-string v5, "init"

    aput-object v5, v1, v4

    const-string v5, "config"

    aput-object v5, v1, v3

    aput-object p1, v1, v2

    .line 87
    invoke-interface {p0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->d([Ljava/lang/Object;)V

    .line 88
    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object p0

    const-string v1, "sv"

    const-string v2, "4.8.5-emas"

    invoke-virtual {p0, v1, v2}, Lcom/taobao/accs/AccsState;->a(Ljava/lang/String;Ljava/lang/Object;)V

    .line 89
    invoke-static {}, Lcom/taobao/accs/ACCSClient;->changeNetworkSdkLoggerToAccs()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 91
    :try_start_1
    invoke-static {v4}, Lanet/channel/AwcnConfig;->setAccsSessionCreateForbiddenInBg(Z)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 94
    :catchall_0
    :try_start_2
    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->getTag()Ljava/lang/String;

    move-result-object p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    monitor-exit v0

    return-object p0

    :cond_0
    :try_start_3
    sget-object v5, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    const/4 v6, 0x5

    new-array v6, v6, [Ljava/lang/Object;

    const-string v7, "init AccsClient params error"

    aput-object v7, v6, v4

    const-string v4, "context"

    aput-object v4, v6, v3

    aput-object p0, v6, v2

    const-string p0, "config"

    aput-object p0, v6, v1

    const/4 p0, 0x4

    aput-object p1, v6, p0

    .line 81
    invoke-interface {v5, v6}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    .line 82
    new-instance p0, Lcom/taobao/accs/AccsException;

    const-string p1, "init AccsClient params error"

    invoke-direct {p0, p1}, Lcom/taobao/accs/AccsException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :catchall_1
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static setCurrentProcessName(Landroid/content/Context;)V
    .locals 3

    const-string v0, "setCurrentProcess"

    .line 203
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->getProcessName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lanet/channel/GlobalAppRuntimeInfo;->setCurrentProcess(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    sget-object v2, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    .line 205
    invoke-interface {v2, v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 208
    :goto_0
    :try_start_1
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    invoke-static {p0}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->getTargetProcess(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lanet/channel/GlobalAppRuntimeInfo;->setTargetProcess(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p0

    sget-object v1, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    .line 210
    invoke-interface {v1, v0, p0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_1
    return-void
.end method

.method public static declared-synchronized setEnvironment(Landroid/content/Context;I)V
    .locals 9

    const-class v0, Lcom/taobao/accs/ACCSClient;

    monitor-enter v0

    const/4 v1, 0x3

    const/4 v2, 0x1

    const/4 v3, 0x0

    const/4 v4, 0x2

    if-ltz p1, :cond_0

    if-le p1, v4, :cond_1

    :cond_0
    :try_start_0
    sget-object v5, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    new-array v6, v1, [Ljava/lang/Object;

    const-string v7, "env invalid, reset to release"

    aput-object v7, v6, v3

    const-string v7, "env"

    aput-object v7, v6, v2

    .line 233
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v4

    invoke-interface {v5, v6}, Lcom/alibaba/sdk/android/logger/ILog;->w([Ljava/lang/Object;)V

    move p1, v3

    .line 236
    :cond_1
    sget v5, Lcom/taobao/accs/AccsClientConfig;->mEnv:I

    .line 237
    sput p1, Lcom/taobao/accs/AccsClientConfig;->mEnv:I

    if-eq v5, p1, :cond_4

    .line 239
    invoke-static {p0}, Lcom/taobao/accs/utl/AdapterUtilityImpl;->isTargetProcess(Landroid/content/Context;)Z

    move-result v6

    if-eqz v6, :cond_4

    sget-object v6, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    const/4 v7, 0x5

    new-array v7, v7, [Ljava/lang/Object;

    const-string v8, "setEnvironment"

    aput-object v8, v7, v3

    const-string v3, "pre"

    aput-object v3, v7, v2

    .line 240
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v7, v4

    const-string v3, "to"

    aput-object v3, v7, v1

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v3, 0x4

    aput-object v1, v7, v3

    invoke-interface {v6, v7}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    .line 241
    invoke-static {p0}, Lcom/taobao/accs/utl/Utils;->clearAllSharePreferences(Landroid/content/Context;)V

    .line 242
    invoke-static {p0}, Lcom/taobao/accs/utl/Utils;->clearAgooBindCache(Landroid/content/Context;)V

    .line 243
    invoke-static {p0}, Lcom/taobao/accs/utl/Utils;->killService(Landroid/content/Context;)V

    if-ne p1, v4, :cond_2

    .line 246
    sget-object p0, Lanet/channel/entity/ENV;->TEST:Lanet/channel/entity/ENV;

    invoke-static {p0}, Lanet/channel/SessionCenter;->switchEnvironment(Lanet/channel/entity/ENV;)V

    goto :goto_0

    :cond_2
    if-ne p1, v2, :cond_3

    .line 248
    sget-object p0, Lanet/channel/entity/ENV;->PREPARE:Lanet/channel/entity/ENV;

    invoke-static {p0}, Lanet/channel/SessionCenter;->switchEnvironment(Lanet/channel/entity/ENV;)V

    :cond_3
    :goto_0
    sget-object p0, Lcom/taobao/accs/ACCSClient;->mACCSClients:Ljava/util/Map;

    .line 251
    invoke-interface {p0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_1
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 253
    :try_start_1
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Lcom/taobao/accs/ACCSClient;->getAccsClient(Ljava/lang/String;)Lcom/taobao/accs/ACCSClient;
    :try_end_1
    .catch Lcom/taobao/accs/AccsException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :catch_0
    move-exception v1

    :try_start_2
    sget-object v2, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v3, "setEnvironment update client"

    .line 255
    invoke-interface {v2, v3, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_1

    .line 262
    :cond_4
    :goto_2
    :try_start_3
    invoke-static {p1}, Lcom/taobao/accs/utl/Utils;->setMode(I)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    goto :goto_3

    :catchall_0
    move-exception p0

    :try_start_4
    sget-object v1, Lcom/taobao/accs/ACCSClient;->DEFAULT_LOG:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v2, "setEnvironment"

    .line 260
    invoke-interface {v1, v2, p0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    goto :goto_2

    .line 264
    :goto_3
    monitor-exit v0

    return-void

    :catchall_1
    move-exception p0

    .line 262
    :try_start_5
    invoke-static {p1}, Lcom/taobao/accs/utl/Utils;->setMode(I)V

    .line 263
    throw p0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    :catchall_2
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method private updateConfig(Lcom/taobao/accs/AccsClientConfig;)V
    .locals 3

    iput-object p1, p0, Lcom/taobao/accs/ACCSClient;->mConfig:Lcom/taobao/accs/AccsClientConfig;

    sget-object v0, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 216
    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->getTag()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/taobao/accs/ACCSManager;->getAccsInstance(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/accs/IACCSManager;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-eqz v0, :cond_0

    .line 218
    invoke-interface {v0, p1}, Lcom/taobao/accs/IACCSManager;->updateConfig(Lcom/taobao/accs/AccsClientConfig;)V

    :cond_0
    return-void
.end method


# virtual methods
.method public addConnectionListener(Lcom/taobao/accs/ConnectionListener;)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mListeners:Ljava/util/HashSet;

    .line 556
    invoke-virtual {v0, p1}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public bindApp(Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V
    .locals 8

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    const-string v1, "ACCS_TEST"

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "bindApp mAccsManager null"

    .line 275
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    .line 276
    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 277
    sget-object p1, Lcom/taobao/accs/AccsErrorCode;->ERROR_SHOULD_NEVER_HAPPEN:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    const-string v0, "bindApp accs is null"

    invoke-virtual {p1, v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    const/4 v0, 0x0

    .line 278
    invoke-static {p1, p2, v0}, Lcom/taobao/accs/utl/c;->a(Lcom/alibaba/sdk/android/error/ErrorCode;Lcom/taobao/accs/IAppReceiver;Ljava/lang/String;)V

    return-void

    :cond_0
    const-string v0, "start to bindApp"

    .line 282
    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v2, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    sget-object v3, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mConfig:Lcom/taobao/accs/AccsClientConfig;

    .line 283
    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object v4

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mConfig:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->getAppSecret()Ljava/lang/String;

    move-result-object v5

    move-object v6, p1

    move-object v7, p2

    invoke-interface/range {v2 .. v7}, Lcom/taobao/accs/IACCSManager;->bindApp(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V

    return-void
.end method

.method public bindService(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "bindService mAccsManager null"

    .line 350
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 353
    invoke-interface {v0, v1, p1}, Lcom/taobao/accs/IACCSManager;->bindService(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public bindUser(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "bindUser mAccsManager null"

    .line 309
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 312
    invoke-interface {v0, v1, p1}, Lcom/taobao/accs/IACCSManager;->bindUser(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public bindUser(Ljava/lang/String;Z)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "bindUser mAccsManager null"

    .line 322
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 325
    invoke-interface {v0, v1, p1, p2}, Lcom/taobao/accs/IACCSManager;->bindUser(Landroid/content/Context;Ljava/lang/String;Z)V

    return-void
.end method

.method public cancel(Ljava/lang/String;)Z
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "cancel mAccsManager null"

    .line 458
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    const/4 p1, 0x0

    return p1

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 461
    invoke-interface {v0, v1, p1}, Lcom/taobao/accs/IACCSManager;->cancel(Landroid/content/Context;Ljava/lang/String;)Z

    move-result p1

    return p1
.end method

.method public cleanLocalBindInfo()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "cleanLocalBindInfo mAccsManager null"

    .line 293
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    .line 297
    :cond_0
    invoke-interface {v0}, Lcom/taobao/accs/IACCSManager;->cleanLocalBindInfo()V

    return-void
.end method

.method public clearLoginInfo()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "clearLoginInfo mAccsManager null"

    .line 446
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 449
    invoke-interface {v0, v1}, Lcom/taobao/accs/IACCSManager;->clearLoginInfo(Landroid/content/Context;)V

    return-void
.end method

.method public disconnect()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    .line 588
    invoke-interface {v0}, Lcom/taobao/accs/IACCSManager;->disconnect()V

    return-void
.end method

.method public forceReConnectChannel()Ljava/util/Map;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
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

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "forceReConnectChannel mAccsManager null"

    .line 493
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    const/4 v0, 0x0

    return-object v0

    .line 496
    :cond_0
    invoke-interface {v0}, Lcom/taobao/accs/IACCSManager;->forceReConnectChannel()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public getChannelState()Ljava/util/Map;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
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

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "getChannelState mAccsManager null"

    .line 481
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    const/4 v0, 0x0

    return-object v0

    .line 484
    :cond_0
    invoke-interface {v0}, Lcom/taobao/accs/IACCSManager;->getChannelState()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public getConnectionListeners()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/taobao/accs/ConnectionListener;",
            ">;"
        }
    .end annotation

    .line 567
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/taobao/accs/ACCSClient;->mListeners:Ljava/util/HashSet;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    return-object v0
.end method

.method public getLastConnectErrorCode()I
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    .line 581
    invoke-interface {v0}, Lcom/taobao/accs/IACCSManager;->getLastConnectErrorCode()I

    move-result v0

    return v0
.end method

.method public isChannelError(I)Z
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "isChannelError mAccsManager null"

    .line 469
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    const/4 p1, 0x1

    return p1

    .line 472
    :cond_0
    invoke-interface {v0, p1}, Lcom/taobao/accs/IACCSManager;->isChannelError(I)Z

    move-result p1

    return p1
.end method

.method public isConnected()Z
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    .line 574
    invoke-interface {v0}, Lcom/taobao/accs/IACCSManager;->isConnected()Z

    move-result v0

    return v0
.end method

.method public isNetworkReachable()Z
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "isNetworkReachable mAccsManager null"

    .line 415
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    const/4 v0, 0x0

    return v0

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 418
    invoke-interface {v0, v1}, Lcom/taobao/accs/IACCSManager;->isNetworkReachable(Landroid/content/Context;)Z

    move-result v0

    return v0
.end method

.method public reconnect()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    .line 595
    invoke-interface {v0}, Lcom/taobao/accs/IACCSManager;->reconnect()V

    return-void
.end method

.method public registerDataListener(Ljava/lang/String;Lcom/taobao/accs/base/AccsAbstractDataListener;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "registerDataListener mAccsManager null"

    .line 528
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 531
    invoke-interface {v0, v1, p1, p2}, Lcom/taobao/accs/IACCSManager;->registerDataListener(Landroid/content/Context;Ljava/lang/String;Lcom/taobao/accs/base/AccsAbstractDataListener;)V

    return-void
.end method

.method public registerService(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "registerService mAccsManager null"

    .line 505
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 508
    invoke-interface {v0, v1, p1, p2}, Lcom/taobao/accs/IACCSManager;->registerService(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public removeConnectionListener(Lcom/taobao/accs/ConnectionListener;)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mListeners:Ljava/util/HashSet;

    .line 562
    invoke-virtual {v0, p1}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public reset()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    .line 602
    invoke-interface {v0}, Lcom/taobao/accs/IACCSManager;->reset()V

    return-void
.end method

.method public sendBusinessAck(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;Ljava/util/Map;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "S",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "sendBusinessAck mAccsManager null"

    .line 548
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move v4, p4

    move-object v5, p5

    move-object v6, p6

    .line 551
    invoke-interface/range {v0 .. v6}, Lcom/taobao/accs/IACCSManager;->sendBusinessAck(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;Ljava/util/Map;)V

    return-void
.end method

.method public sendData(Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "sendData mAccsManager null"

    .line 378
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    const/4 p1, 0x0

    return-object p1

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 381
    invoke-interface {v0, v1, p1}, Lcom/taobao/accs/IACCSManager;->sendData(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public sendPushResponse(Lcom/taobao/accs/ACCSManager$AccsRequest;Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;)Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "sendPushResponse mAccsManager null"

    .line 406
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    const/4 p1, 0x0

    return-object p1

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 409
    invoke-interface {v0, v1, p1, p2}, Lcom/taobao/accs/IACCSManager;->sendPushResponse(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public sendRequest(Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "sendRequest mAccsManager null"

    .line 393
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    const/4 p1, 0x0

    return-object p1

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 396
    invoke-interface {v0, v1, p1}, Lcom/taobao/accs/IACCSManager;->sendRequest(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public setLoginInfo(Lcom/taobao/accs/ILoginInfo;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "setLoginInfo mAccsManager null"

    .line 434
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 437
    invoke-interface {v0, v1, p1}, Lcom/taobao/accs/IACCSManager;->setLoginInfo(Landroid/content/Context;Lcom/taobao/accs/ILoginInfo;)V

    return-void
.end method

.method public startInAppConnection(Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V
    .locals 6

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p2, "startInAppConnection mAccsManager null"

    .line 423
    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    iget-object v2, p0, Lcom/taobao/accs/ACCSClient;->mConfig:Lcom/taobao/accs/AccsClientConfig;

    .line 426
    invoke-virtual {v2}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lcom/taobao/accs/ACCSClient;->mConfig:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v3}, Lcom/taobao/accs/AccsClientConfig;->getAppSecret()Ljava/lang/String;

    move-result-object v3

    move-object v4, p1

    move-object v5, p2

    invoke-interface/range {v0 .. v5}, Lcom/taobao/accs/IACCSManager;->startInAppConnection(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/accs/IAppReceiver;)V

    return-void
.end method

.method public unRegisterDataListener(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "unRegisterDataListener mAccsManager null"

    .line 539
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 542
    invoke-interface {v0, v1, p1}, Lcom/taobao/accs/IACCSManager;->unRegisterDataListener(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public unRegisterService(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "unRegisterService mAccsManager null"

    .line 517
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 520
    invoke-interface {v0, v1, p1}, Lcom/taobao/accs/IACCSManager;->unRegisterService(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public unbindService(Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "unbindService mAccsManager null"

    .line 363
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 366
    invoke-interface {v0, v1, p1}, Lcom/taobao/accs/IACCSManager;->unbindService(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method public unbindUser()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mAccsManager:Lcom/taobao/accs/IACCSManager;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/ACCSClient;->mLog:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "unbindUser mAccsManager null"

    .line 335
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    sget-object v1, Lcom/taobao/accs/ACCSClient;->sContext:Landroid/content/Context;

    .line 338
    invoke-interface {v0, v1}, Lcom/taobao/accs/IACCSManager;->unbindUser(Landroid/content/Context;)V

    return-void
.end method
