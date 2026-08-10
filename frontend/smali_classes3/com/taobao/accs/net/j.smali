.class public Lcom/taobao/accs/net/j;
.super Lcom/taobao/accs/net/b;
.source "Taobao"

# interfaces
.implements Lanet/channel/DataFrameCb;
.implements Lanet/channel/ISessionListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/accs/net/j$a;
    }
.end annotation


# instance fields
.field private n:Z

.field private o:J

.field private p:Ljava/util/concurrent/ScheduledFuture;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ScheduledFuture<",
            "*>;"
        }
    .end annotation
.end field

.field private q:Ljava/util/concurrent/ScheduledFuture;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ScheduledFuture<",
            "*>;"
        }
    .end annotation
.end field

.field private r:Z

.field private s:Lcom/alibaba/sdk/android/error/ErrorCode;

.field private final t:Lcom/alibaba/sdk/android/logger/ILog;

.field private final u:Ljava/lang/Runnable;

.field private final v:Ljava/lang/Runnable;

.field private final w:Ljava/lang/Runnable;

.field private final x:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;ILjava/lang/String;)V
    .locals 8

    .line 107
    invoke-direct {p0, p1, p2, p3}, Lcom/taobao/accs/net/b;-><init>(Landroid/content/Context;ILjava/lang/String;)V

    const/4 p2, 0x1

    iput-boolean p2, p0, Lcom/taobao/accs/net/j;->n:Z

    const-wide/32 v0, 0x36ee80

    iput-wide v0, p0, Lcom/taobao/accs/net/j;->o:J

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/net/j;->r:Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/accs/net/j;->s:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 77
    new-instance v0, Lcom/taobao/accs/net/k;

    invoke-direct {v0, p0}, Lcom/taobao/accs/net/k;-><init>(Lcom/taobao/accs/net/j;)V

    iput-object v0, p0, Lcom/taobao/accs/net/j;->u:Ljava/lang/Runnable;

    .line 84
    new-instance v0, Lcom/taobao/accs/net/l;

    invoke-direct {v0, p0}, Lcom/taobao/accs/net/l;-><init>(Lcom/taobao/accs/net/j;)V

    iput-object v0, p0, Lcom/taobao/accs/net/j;->v:Ljava/lang/Runnable;

    .line 484
    new-instance v2, Lcom/taobao/accs/net/q;

    invoke-direct {v2, p0}, Lcom/taobao/accs/net/q;-><init>(Lcom/taobao/accs/net/j;)V

    iput-object v2, p0, Lcom/taobao/accs/net/j;->w:Ljava/lang/Runnable;

    .line 572
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedSet(Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/accs/net/j;->x:Ljava/util/Set;

    .line 108
    invoke-virtual {p0}, Lcom/taobao/accs/net/j;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/taobao/accs/utl/AccsLogger;->getLogger(Ljava/lang/Object;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    .line 109
    invoke-static {p2}, Lcom/taobao/accs/utl/OrangeAdapter;->isTnetLogOff(Z)Z

    move-result p2

    if-nez p2, :cond_0

    .line 111
    iget-object p2, p0, Lcom/taobao/accs/net/j;->d:Landroid/content/Context;

    const-string v1, "inapp"

    invoke-static {p2, v1}, Lcom/taobao/accs/utl/UtilityImpl;->d(Landroid/content/Context;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 112
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "config tnet log path:"

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    .line 113
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    const/high16 v1, 0x500000

    const/4 v3, 0x5

    .line 114
    invoke-static {p1, p2, v1, v3}, Lanet/channel/Session;->configTnetALog(Landroid/content/Context;Ljava/lang/String;II)V

    .line 118
    :cond_0
    invoke-static {p3}, Lcom/taobao/accs/AccsClientConfig;->getConfigByTag(Ljava/lang/String;)Lcom/taobao/accs/AccsClientConfig;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 119
    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->isChannelLoopStart()Z

    move-result p2

    if-eqz p2, :cond_1

    const-string p2, "channel loop start"

    .line 120
    invoke-interface {v0, p2}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    .line 121
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v1

    const-wide/32 v3, 0x1d4c0

    .line 122
    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->getLoopInterval()J

    move-result-wide v5

    sget-object v7, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    .line 121
    invoke-virtual/range {v1 .. v7}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->scheduleWithFixedDelay(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    goto :goto_0

    :cond_1
    const-string p1, "channel delay start"

    .line 125
    invoke-interface {v0, p1}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    .line 126
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object p1

    const-wide/32 p2, 0x1d4c0

    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {p1, v2, p2, p3, v0}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    :goto_0
    return-void
.end method

.method static synthetic a(Lcom/taobao/accs/net/j;)Lcom/alibaba/sdk/android/logger/ILog;
    .locals 0

    .line 60
    iget-object p0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    return-object p0
.end method

.method private a(ZLcom/alibaba/sdk/android/error/ErrorCode;)V
    .locals 4

    .line 674
    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/net/j;->m:Ljava/lang/String;

    invoke-static {v0}, Lcom/taobao/accs/ACCSClient;->getAccsClient(Ljava/lang/String;)Lcom/taobao/accs/ACCSClient;

    move-result-object v0

    .line 675
    invoke-virtual {v0}, Lcom/taobao/accs/ACCSClient;->getConnectionListeners()Ljava/util/List;

    move-result-object v0

    .line 676
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/accs/ConnectionListener;

    if-eqz p1, :cond_0

    .line 678
    invoke-interface {v1}, Lcom/taobao/accs/ConnectionListener;->onConnect()V

    goto :goto_0

    .line 680
    :cond_0
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v2

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Lcom/taobao/accs/ConnectionListener;->onDisconnect(ILjava/lang/String;)V
    :try_end_0
    .catch Lcom/taobao/accs/AccsException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 684
    invoke-virtual {p1}, Lcom/taobao/accs/AccsException;->printStackTrace()V

    :cond_1
    return-void
.end method

.method static synthetic b(Lcom/taobao/accs/net/j;)J
    .locals 2

    .line 60
    iget-wide v0, p0, Lcom/taobao/accs/net/j;->o:J

    return-wide v0
.end method

.method static synthetic c(Lcom/taobao/accs/net/j;)V
    .locals 0

    .line 60
    invoke-direct {p0}, Lcom/taobao/accs/net/j;->q()V

    return-void
.end method

.method static synthetic d(Lcom/taobao/accs/net/j;)V
    .locals 0

    .line 60
    invoke-direct {p0}, Lcom/taobao/accs/net/j;->r()V

    return-void
.end method

.method private q()V
    .locals 8

    .line 750
    iget-object v0, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->isAccsHeartbeatEnable()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 751
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/accs/net/j;->v:Ljava/lang/Runnable;

    iget-wide v5, p0, Lcom/taobao/accs/net/j;->o:J

    sget-object v7, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    move-wide v3, v5

    .line 752
    invoke-virtual/range {v1 .. v7}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->scheduleAtFixedRate(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/accs/net/j;->p:Ljava/util/concurrent/ScheduledFuture;

    :cond_0
    return-void
.end method

.method private r()V
    .locals 9

    .line 759
    invoke-direct {p0}, Lcom/taobao/accs/net/j;->s()V

    iget-object v0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "startReconnectTask"

    .line 760
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    .line 761
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v2

    iget-object v3, p0, Lcom/taobao/accs/net/j;->u:Ljava/lang/Runnable;

    const-wide/16 v4, 0x78

    const-wide/16 v6, 0x78

    sget-object v8, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    .line 762
    invoke-virtual/range {v2 .. v8}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->scheduleWithFixedDelay(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/accs/net/j;->q:Ljava/util/concurrent/ScheduledFuture;

    return-void
.end method

.method private s()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/net/j;->q:Ljava/util/concurrent/ScheduledFuture;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    .line 768
    invoke-interface {v0, v1}, Ljava/util/concurrent/ScheduledFuture;->cancel(Z)Z

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/accs/net/j;->q:Ljava/util/concurrent/ScheduledFuture;

    :cond_0
    return-void
.end method


# virtual methods
.method public declared-synchronized a()V
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "start"

    .line 133
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/accs/net/j;->n:Z

    .line 135
    iget-object v0, p0, Lcom/taobao/accs/net/j;->d:Landroid/content/Context;

    invoke-virtual {p0, v0}, Lcom/taobao/accs/net/j;->a(Landroid/content/Context;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 136
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method protected a(Landroid/content/Context;)V
    .locals 3

    .line 552
    :try_start_0
    iget-boolean v0, p0, Lcom/taobao/accs/net/j;->g:Z

    if-eqz v0, :cond_0

    return-void

    .line 555
    :cond_0
    invoke-super {p0, p1}, Lcom/taobao/accs/net/b;->a(Landroid/content/Context;)V

    .line 557
    iget-object p1, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->getInappHost()Ljava/lang/String;

    move-result-object p1

    .line 559
    invoke-virtual {p0}, Lcom/taobao/accs/net/j;->h()Z

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->isKeepalive()Z

    move-result v0

    if-eqz v0, :cond_1

    move v0, v1

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v2, "initAwcn close keep alive"

    .line 562
    invoke-interface {v0, v2}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 564
    :goto_0
    iget-object v2, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v2}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lanet/channel/SessionCenter;->getInstance(Ljava/lang/String;)Lanet/channel/SessionCenter;

    move-result-object v2

    invoke-virtual {p0, v2, p1, v0}, Lcom/taobao/accs/net/j;->a(Lanet/channel/SessionCenter;Ljava/lang/String;Z)V

    .line 565
    iput-boolean v1, p0, Lcom/taobao/accs/net/j;->g:Z

    iget-object p1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "initAwcn success!"

    .line 566
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "initAwcn"

    .line 568
    invoke-interface {v0, v1, p1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_1
    return-void
.end method

.method public a(Lanet/channel/SessionCenter;Ljava/lang/String;Z)V
    .locals 7

    iget-object v0, p0, Lcom/taobao/accs/net/j;->x:Ljava/util/Set;

    .line 576
    invoke-interface {v0, p2}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v3, 0x1

    .line 579
    new-instance v4, Lcom/taobao/accs/net/j$a;

    invoke-direct {v4, p0, p2}, Lcom/taobao/accs/net/j$a;-><init>(Lcom/taobao/accs/net/b;Ljava/lang/String;)V

    const/4 v5, 0x0

    move-object v1, p2

    move v2, p3

    move-object v6, p0

    invoke-static/range {v1 .. v6}, Lanet/channel/SessionInfo;->create(Ljava/lang/String;ZZLanet/channel/IAuth;Lanet/channel/heartbeat/IHeartbeat;Lanet/channel/DataFrameCb;)Lanet/channel/SessionInfo;

    move-result-object p3

    .line 581
    invoke-virtual {p1, p0}, Lanet/channel/SessionCenter;->registerAccsSessionListener(Lanet/channel/ISessionListener;)V

    .line 582
    iget-object v0, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->getInappPubKey()I

    move-result v0

    invoke-virtual {p1, p2, v0}, Lanet/channel/SessionCenter;->registerPublicKey(Ljava/lang/String;I)V

    .line 583
    invoke-virtual {p1, p3}, Lanet/channel/SessionCenter;->registerSessionInfo(Lanet/channel/SessionInfo;)V

    iget-object p1, p0, Lcom/taobao/accs/net/j;->x:Ljava/util/Set;

    .line 584
    invoke-interface {p1, p2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p3, "registerSessionInfo"

    const-string v0, "host"

    .line 585
    filled-new-array {p3, v0, p2}, [Ljava/lang/Object;

    move-result-object p2

    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    return-void
.end method

.method public a(Lcom/taobao/accs/AccsClientConfig;)V
    .locals 7

    const-string v0, "updateConfig"

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "updateConfig null"

    .line 590
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    return-void

    .line 593
    :cond_0
    iget-object v1, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {p1, v1}, Lcom/taobao/accs/AccsClientConfig;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "updateConfig not any changed"

    .line 594
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    return-void

    :cond_1
    :try_start_0
    iget-object v1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const/4 v2, 0x5

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    const-string v4, "old"

    const/4 v5, 0x1

    aput-object v4, v2, v5

    .line 598
    iget-object v4, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    const/4 v6, 0x2

    aput-object v4, v2, v6

    const-string v4, "new"

    const/4 v6, 0x3

    aput-object v4, v2, v6

    const/4 v4, 0x4

    aput-object p1, v2, v4

    invoke-interface {v1, v2}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    .line 599
    iget-object v1, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v1}, Lcom/taobao/accs/AccsClientConfig;->getInappHost()Ljava/lang/String;

    move-result-object v1

    .line 600
    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->getInappHost()Ljava/lang/String;

    move-result-object v2

    .line 601
    iget-object v4, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v4}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lanet/channel/SessionCenter;->getInstance(Ljava/lang/String;)Lanet/channel/SessionCenter;

    move-result-object v4

    if-nez v4, :cond_2

    iget-object p1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "old session not exist, no need update"

    .line 603
    invoke-interface {p1, v1}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    return-void

    .line 607
    :cond_2
    invoke-virtual {v4, v1}, Lanet/channel/SessionCenter;->unregisterSessionInfo(Ljava/lang/String;)V

    iget-object v6, p0, Lcom/taobao/accs/net/j;->x:Ljava/util/Set;

    .line 608
    invoke-interface {v6, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    iget-object v6, p0, Lcom/taobao/accs/net/j;->x:Ljava/util/Set;

    .line 609
    invoke-interface {v6, v1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 612
    :cond_3
    iget-object v1, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v1}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object v1

    .line 613
    iput-object p1, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    .line 614
    iget-object p1, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/accs/net/j;->b:Ljava/lang/String;

    .line 615
    iget-object p1, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->getTag()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/accs/net/j;->m:Ljava/lang/String;

    .line 616
    iget-object p1, p0, Lcom/taobao/accs/net/j;->b:Ljava/lang/String;

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_4

    .line 617
    iget-object p1, p0, Lcom/taobao/accs/net/j;->b:Ljava/lang/String;

    invoke-static {p1}, Lanet/channel/SessionCenter;->getInstance(Ljava/lang/String;)Lanet/channel/SessionCenter;

    move-result-object v4

    .line 620
    :cond_4
    invoke-virtual {p0}, Lcom/taobao/accs/net/j;->h()Z

    move-result p1

    if-eqz p1, :cond_5

    iget-object p1, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {p1}, Lcom/taobao/accs/AccsClientConfig;->isKeepalive()Z

    move-result p1

    if-eqz p1, :cond_5

    move v3, v5

    goto :goto_0

    :cond_5
    iget-object p1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "updateConfig close keepalive"

    .line 623
    invoke-interface {p1, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    .line 625
    :goto_0
    invoke-virtual {p0, v4, v2, v3}, Lcom/taobao/accs/net/j;->a(Lanet/channel/SessionCenter;Ljava/lang/String;Z)V

    iget-object p1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "updateConfig done"

    .line 626
    invoke-interface {p1, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception p1

    iget-object v1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    .line 628
    invoke-interface {v1, v0, p1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_1
    return-void
.end method

.method protected a(Lcom/taobao/accs/data/Message;Z)V
    .locals 4

    iget-boolean p2, p0, Lcom/taobao/accs/net/j;->n:Z

    if-eqz p2, :cond_6

    if-nez p1, :cond_0

    goto/16 :goto_1

    .line 144
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getSendScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object p2

    invoke-virtual {p2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/concurrent/BlockingQueue;->size()I

    move-result p2

    const/16 v0, 0x3e8

    if-gt p2, v0, :cond_4

    .line 148
    iget-wide v0, p1, Lcom/taobao/accs/data/Message;->Q:J

    const-wide/16 v2, 0x0

    cmp-long p2, v0, v2

    if-gtz p2, :cond_1

    const-wide/16 v0, 0x1

    .line 152
    :cond_1
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getSendScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object p2

    new-instance v2, Lcom/taobao/accs/net/m;

    invoke-direct {v2, p0, p1}, Lcom/taobao/accs/net/m;-><init>(Lcom/taobao/accs/net/j;Lcom/taobao/accs/data/Message;)V

    sget-object v3, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    .line 153
    invoke-virtual {p2, v2, v0, v1, v3}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object p2

    .line 291
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->a()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    iget-object v0, p1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    if-eqz v0, :cond_3

    .line 294
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->c()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 295
    iget-object v0, p1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/taobao/accs/net/j;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 296
    iget-object v0, p0, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {v0, p1}, Lcom/taobao/accs/data/d;->b(Lcom/taobao/accs/data/Message;)V

    .line 299
    :cond_2
    iget-object v0, p0, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    iget-object v0, v0, Lcom/taobao/accs/data/d;->a:Ljava/util/concurrent/ConcurrentMap;

    iget-object v1, p1, Lcom/taobao/accs/data/Message;->O:Ljava/lang/String;

    invoke-interface {v0, v1, p2}, Ljava/util/concurrent/ConcurrentMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 303
    :cond_3
    invoke-virtual {p1}, Lcom/taobao/accs/data/Message;->e()Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;

    move-result-object p2

    if-eqz p2, :cond_5

    .line 305
    iget-object v0, p0, Lcom/taobao/accs/net/j;->d:Landroid/content/Context;

    .line 306
    invoke-static {v0}, Lcom/taobao/accs/utl/UtilityImpl;->getDeviceId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 305
    invoke-virtual {p2, v0}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setDeviceId(Ljava/lang/String;)V

    .line 307
    iget v0, p0, Lcom/taobao/accs/net/j;->c:I

    invoke-virtual {p2, v0}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->setConnType(I)V

    .line 308
    invoke-virtual {p2}, Lcom/taobao/accs/ut/monitor/NetPerformanceMonitor;->onEnterQueueData()V

    goto :goto_0

    .line 146
    :cond_4
    new-instance p2, Ljava/util/concurrent/RejectedExecutionException;

    const-string v0, "accs"

    invoke-direct {p2, v0}, Ljava/util/concurrent/RejectedExecutionException;-><init>(Ljava/lang/String;)V

    throw p2
    :try_end_0
    .catch Ljava/util/concurrent/RejectedExecutionException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    move-exception p2

    iget-object v0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "send error"

    .line 317
    invoke-interface {v0, v1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 318
    iget-object v0, p0, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    sget-object v1, Lcom/taobao/accs/AccsErrorCode;->SEND_LOCAL_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 319
    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    invoke-static {p2}, Lcom/taobao/accs/AccsErrorCode;->getExceptionInfo(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p2

    .line 320
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p2

    .line 318
    invoke-virtual {v0, p1, p2}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    goto :goto_0

    .line 311
    :catch_0
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getSendScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object p2

    invoke-virtual {p2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->getQueue()Ljava/util/concurrent/BlockingQueue;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/concurrent/BlockingQueue;->size()I

    move-result p2

    .line 312
    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->MESSAGE_QUEUE_FULL:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "inapp "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p2

    .line 313
    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p2

    .line 314
    iget-object v0, p0, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {v0, p1, p2}, Lcom/taobao/accs/data/d;->a(Lcom/taobao/accs/data/Message;Lcom/alibaba/sdk/android/error/ErrorCode;)V

    iget-object p1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "send queue full"

    const-string v1, "err"

    .line 315
    filled-new-array {v0, v1, p2}, [Ljava/lang/Object;

    move-result-object p2

    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    :cond_5
    :goto_0
    return-void

    :cond_6
    :goto_1
    iget-object p1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    .line 140
    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "not running or msg null! "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/taobao/accs/net/j;->n:Z

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-interface {p1, p2}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    return-void
.end method

.method protected a(Ljava/lang/String;ZJ)V
    .locals 7

    .line 327
    new-instance v6, Lcom/taobao/accs/net/n;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-wide v3, p3

    move v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/taobao/accs/net/n;-><init>(Lcom/taobao/accs/net/j;Ljava/lang/String;JZ)V

    .line 339
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object p1

    sget-object p2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {p1, v6, p3, p4, p2}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    return-void
.end method

.method protected a(Ljava/lang/String;ZLjava/lang/String;)V
    .locals 2

    .line 383
    :try_start_0
    iget-object p3, p0, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    invoke-virtual {p3, p1}, Lcom/taobao/accs/data/d;->b(Ljava/lang/String;)Lcom/taobao/accs/data/Message;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 384
    iget-object p3, p1, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    if-eqz p3, :cond_1

    .line 385
    iget-object p3, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {p3}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object p3

    invoke-static {p3}, Lanet/channel/SessionCenter;->getInstance(Ljava/lang/String;)Lanet/channel/SessionCenter;

    move-result-object p3

    iget-object p1, p1, Lcom/taobao/accs/data/Message;->f:Ljava/net/URL;

    .line 386
    invoke-virtual {p1}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object p1

    const-wide/16 v0, 0x0

    .line 385
    invoke-virtual {p3, p1, v0, v1}, Lanet/channel/SessionCenter;->get(Ljava/lang/String;J)Lanet/channel/Session;

    move-result-object p1

    if-eqz p1, :cond_1

    const/4 p3, 0x1

    if-eqz p2, :cond_0

    .line 389
    invoke-virtual {p1, p3}, Lanet/channel/Session;->close(Z)V

    goto :goto_0

    .line 391
    :cond_0
    invoke-virtual {p1, p3}, Lanet/channel/Session;->ping(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string p3, "onTimeOut"

    .line 396
    invoke-interface {p2, p3, p1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public a(Lorg/json/JSONObject;)V
    .locals 12

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v0, "onReceiveAccsHeartbeatResp response data is null"

    .line 520
    invoke-interface {p1, v0}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "data"

    const-string v2, "onReceiveAccsHeartbeatResp"

    .line 524
    filled-new-array {v2, v1, p1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    :try_start_0
    const-string v0, "timeInterval"

    .line 527
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result p1

    const/4 v0, -0x1

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lcom/taobao/accs/net/j;->p:Ljava/util/concurrent/ScheduledFuture;

    if-eqz p1, :cond_3

    const/4 v0, 0x1

    .line 531
    invoke-interface {p1, v0}, Ljava/util/concurrent/ScheduledFuture;->cancel(Z)Z

    goto :goto_0

    :cond_1
    iget-wide v0, p0, Lcom/taobao/accs/net/j;->o:J

    mul-int/lit16 v3, p1, 0x3e8

    int-to-long v3, v3

    cmp-long v0, v0, v3

    if-eqz v0, :cond_3

    if-nez p1, :cond_2

    const-wide/32 v3, 0x36ee80

    :cond_2
    iput-wide v3, p0, Lcom/taobao/accs/net/j;->o:J

    .line 535
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v5

    iget-object v6, p0, Lcom/taobao/accs/net/j;->v:Ljava/lang/Runnable;

    iget-wide v9, p0, Lcom/taobao/accs/net/j;->o:J

    sget-object v11, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    move-wide v7, v9

    .line 536
    invoke-virtual/range {v5 .. v11}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->scheduleAtFixedRate(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/accs/net/j;->p:Ljava/util/concurrent/ScheduledFuture;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    .line 541
    invoke-interface {v0, v2, p1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_3
    :goto_0
    return-void
.end method

.method public a(ZZ)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;)Z
    .locals 4

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    .line 508
    :cond_0
    iget-object v1, p0, Lcom/taobao/accs/net/j;->e:Lcom/taobao/accs/data/d;

    iget-object v1, v1, Lcom/taobao/accs/data/d;->a:Ljava/util/concurrent/ConcurrentMap;

    invoke-interface {v1, p1}, Ljava/util/concurrent/ConcurrentMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/concurrent/ScheduledFuture;

    if-eqz v1, :cond_1

    .line 510
    invoke-interface {v1, v0}, Ljava/util/concurrent/ScheduledFuture;->cancel(Z)Z

    move-result v0

    :cond_1
    if-eqz v0, :cond_2

    iget-object v1, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v2, "cancel"

    const-string v3, "customDataId"

    .line 513
    filled-new-array {v2, v3, p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-interface {v1, p1}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    :cond_2
    return v0
.end method

.method public b()V
    .locals 1

    const/4 v0, 0x0

    .line 356
    iput v0, p0, Lcom/taobao/accs/net/j;->f:I

    return-void
.end method

.method public c()Lcom/taobao/accs/ut/a/c;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method protected d()Ljava/lang/String;
    .locals 2

    .line 547
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "InAppConn_"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/taobao/accs/net/j;->m:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public e()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "shut down"

    .line 345
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/net/j;->n:Z

    return-void
.end method

.method public l()Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/accs/net/j;->r:Z

    return v0
.end method

.method public m()I
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/net/j;->s:Lcom/alibaba/sdk/android/error/ErrorCode;

    if-eqz v0, :cond_0

    .line 781
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public n()V
    .locals 2

    .line 789
    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v0}, Lcom/taobao/accs/AccsClientConfig;->getAppKey()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lanet/channel/SessionCenter;->getInstance(Ljava/lang/String;)Lanet/channel/SessionCenter;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    .line 793
    :cond_0
    iget-object v1, p0, Lcom/taobao/accs/net/j;->i:Lcom/taobao/accs/AccsClientConfig;

    invoke-virtual {v1}, Lcom/taobao/accs/AccsClientConfig;->getInappHost()Ljava/lang/String;

    move-result-object v1

    .line 794
    invoke-virtual {v0, v1}, Lanet/channel/SessionCenter;->unregisterSessionInfo(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/taobao/accs/net/j;->x:Ljava/util/Set;

    .line 795
    invoke-interface {v0, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/taobao/accs/net/j;->x:Ljava/util/Set;

    .line 796
    invoke-interface {v0, v1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public o()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "reconnect begin"

    .line 805
    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 806
    iput-boolean v0, p0, Lcom/taobao/accs/net/j;->g:Z

    .line 807
    iget-object v0, p0, Lcom/taobao/accs/net/j;->d:Landroid/content/Context;

    invoke-virtual {p0, v0}, Lcom/taobao/accs/net/j;->a(Landroid/content/Context;)V

    .line 810
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getSendScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    new-instance v1, Lcom/taobao/accs/net/r;

    invoke-direct {v1, p0}, Lcom/taobao/accs/net/r;-><init>(Lcom/taobao/accs/net/j;)V

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onConnectionChanged(Landroid/content/Intent;)V
    .locals 7

    const-string v0, "connect_avail"

    const/4 v1, 0x0

    .line 634
    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v0

    const-string v1, "host"

    .line 635
    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 636
    invoke-static {p1}, Lcom/taobao/accs/common/Constants;->getErrorCode(Landroid/content/Intent;)Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    .line 637
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_5

    if-nez v0, :cond_2

    .line 639
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v2

    sget-object v3, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v3}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v3

    if-ne v2, v3, :cond_1

    .line 640
    iget-object p1, p0, Lcom/taobao/accs/net/j;->d:Landroid/content/Context;

    invoke-static {p1}, Lcom/taobao/accs/utl/UtilityImpl;->g(Landroid/content/Context;)Z

    move-result p1

    const-string v2, "lost connect"

    if-eqz p1, :cond_0

    .line 641
    sget-object p1, Lcom/taobao/accs/AccsErrorCode;->INAPP_CON_DISCONNECTED:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    .line 642
    invoke-static {v2}, Lcom/taobao/accs/AccsErrorCode;->getAllDetails(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 641
    invoke-virtual {p1, v2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    .line 642
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    goto :goto_0

    .line 644
    :cond_0
    sget-object p1, Lcom/taobao/accs/AccsErrorCode;->NO_NETWORK:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    .line 645
    invoke-static {v2}, Lcom/taobao/accs/AccsErrorCode;->getAllDetails(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 644
    invoke-virtual {p1, v2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    .line 645
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    :cond_1
    :goto_0
    iget-object v2, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v3, "InAppConnection Not Available "

    const-string v4, "error"

    .line 648
    filled-new-array {v3, v4, p1}, [Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    .line 649
    invoke-direct {p0}, Lcom/taobao/accs/net/j;->r()V

    goto :goto_1

    :cond_2
    iget-object v2, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    iget-boolean v3, p0, Lcom/taobao/accs/net/j;->r:Z

    .line 651
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    const-string v4, "InAppConnection Available. last status"

    filled-new-array {v4, v3}, [Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v2, v3}, Lcom/alibaba/sdk/android/logger/ILog;->i([Ljava/lang/Object;)V

    .line 652
    invoke-direct {p0}, Lcom/taobao/accs/net/j;->s()V

    iget-boolean v2, p0, Lcom/taobao/accs/net/j;->r:Z

    if-nez v2, :cond_3

    .line 655
    iget-object v2, p0, Lcom/taobao/accs/net/j;->d:Landroid/content/Context;

    invoke-virtual {p0, v2}, Lcom/taobao/accs/net/j;->b(Landroid/content/Context;)V

    :cond_3
    :goto_1
    iput-boolean v0, p0, Lcom/taobao/accs/net/j;->r:Z

    iput-object p1, p0, Lcom/taobao/accs/net/j;->s:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v2, "a"

    const-string v3, "h"

    const-string v4, "cc"

    if-eqz p1, :cond_4

    .line 660
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v5

    sget-object v6, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v6}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v6

    if-eq v5, v6, :cond_4

    .line 661
    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "c"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 662
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 661
    invoke-virtual {v5, v4, v1}, Lcom/taobao/accs/AccsState;->b(Ljava/lang/String;Ljava/lang/Object;)V

    .line 663
    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object v1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "re"

    invoke-virtual {v1, v3, v2}, Lcom/taobao/accs/AccsState;->b(Ljava/lang/String;Ljava/lang/Object;)V

    goto :goto_2

    .line 665
    :cond_4
    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object v5

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v5, v4, v1}, Lcom/taobao/accs/AccsState;->b(Ljava/lang/String;Ljava/lang/Object;)V

    .line 668
    :goto_2
    invoke-direct {p0, v0, p1}, Lcom/taobao/accs/net/j;->a(ZLcom/alibaba/sdk/android/error/ErrorCode;)V

    :cond_5
    return-void
.end method

.method public onDataReceive(Lanet/channel/session/TnetSpdySession;[BII)V
    .locals 8

    .line 404
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    new-instance v7, Lcom/taobao/accs/net/o;

    move-object v1, v7

    move-object v2, p0

    move v3, p4

    move v4, p3

    move-object v5, p2

    move-object v6, p1

    invoke-direct/range {v1 .. v6}, Lcom/taobao/accs/net/o;-><init>(Lcom/taobao/accs/net/j;II[BLanet/channel/session/TnetSpdySession;)V

    invoke-virtual {v0, v7}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onException(IIZLjava/lang/String;)V
    .locals 10

    iget-object v0, p0, Lcom/taobao/accs/net/j;->t:Lcom/alibaba/sdk/android/logger/ILog;

    const-string v1, "onException"

    const-string v2, "dataId"

    .line 436
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    const-string v4, "errorId"

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    const-string v6, "needRetry"

    invoke-static {p3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    const-string v8, "detail"

    move-object v9, p4

    filled-new-array/range {v1 .. v9}, [Ljava/lang/Object;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/alibaba/sdk/android/logger/ILog;->e([Ljava/lang/Object;)V

    .line 439
    invoke-static {}, Lcom/taobao/accs/common/ThreadPoolExecutorFactory;->getScheduledExecutor()Ljava/util/concurrent/ScheduledThreadPoolExecutor;

    move-result-object v0

    new-instance v7, Lcom/taobao/accs/net/p;

    move-object v1, v7

    move-object v2, p0

    move v3, p2

    move-object v4, p4

    move v5, p1

    move v6, p3

    invoke-direct/range {v1 .. v6}, Lcom/taobao/accs/net/p;-><init>(Lcom/taobao/accs/net/j;ILjava/lang/String;IZ)V

    invoke-virtual {v0, v7}, Ljava/util/concurrent/ScheduledThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method
