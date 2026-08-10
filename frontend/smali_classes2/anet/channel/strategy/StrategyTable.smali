.class Lanet/channel/strategy/StrategyTable;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanet/channel/strategy/StrategyTable$HostLruCache;
    }
.end annotation


# static fields
.field protected static e:Ljava/util/Comparator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Comparator<",
            "Lanet/channel/strategy/StrategyCollection;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field protected a:Ljava/lang/String;

.field protected volatile b:Ljava/lang/String;

.field c:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field protected transient d:Z

.field private f:Lanet/channel/strategy/StrategyTable$HostLruCache;

.field private volatile transient g:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 54
    new-instance v0, Lanet/channel/strategy/o;

    invoke-direct {v0}, Lanet/channel/strategy/o;-><init>()V

    sput-object v0, Lanet/channel/strategy/StrategyTable;->e:Ljava/util/Comparator;

    return-void
.end method

.method protected constructor <init>(Ljava/lang/String;)V
    .locals 1

    .line 90
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lanet/channel/strategy/StrategyTable;->d:Z

    iput-object p1, p0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    .line 92
    invoke-virtual {p0}, Lanet/channel/strategy/StrategyTable;->a()V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 1

    .line 222
    new-instance v0, Ljava/util/TreeSet;

    invoke-direct {v0}, Ljava/util/TreeSet;-><init>()V

    .line 223
    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 224
    invoke-direct {p0, v0}, Lanet/channel/strategy/StrategyTable;->a(Ljava/util/Set;)V

    return-void
.end method

.method private a(Ljava/util/Set;)V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_8

    .line 247
    invoke-interface {p1}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    .line 251
    :cond_0
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v0

    if-eqz v0, :cond_1

    sget-wide v0, Lanet/channel/util/AppLifecycle;->lastEnterBackgroundTime:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-gtz v0, :cond_2

    :cond_1
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->isConnected()Z

    move-result v0

    if-nez v0, :cond_3

    :cond_2
    const-string p1, "awcn.StrategyTable"

    const-string v0, "app in background or no network"

    iget-object v1, p0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    .line 252
    invoke-static {p1, v0, v1, v2}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 256
    :cond_3
    invoke-static {}, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->getAmdcLimitLevel()I

    move-result v0

    const/4 v1, 0x3

    if-ne v0, v1, :cond_4

    return-void

    .line 261
    :cond_4
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-object v3, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 262
    monitor-enter v3

    .line 263
    :try_start_0
    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_5
    :goto_0
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_6

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    iget-object v6, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 264
    invoke-virtual {v6, v5}, Lanet/channel/strategy/StrategyTable$HostLruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lanet/channel/strategy/StrategyCollection;

    if-eqz v5, :cond_5

    const-wide/16 v6, 0x7530

    add-long/2addr v6, v1

    .line 266
    iput-wide v6, v5, Lanet/channel/strategy/StrategyCollection;->b:J

    goto :goto_0

    .line 269
    :cond_6
    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_7

    .line 272
    invoke-direct {p0, p1}, Lanet/channel/strategy/StrategyTable;->b(Ljava/util/Set;)V

    .line 275
    :cond_7
    invoke-static {}, Lanet/channel/strategy/dispatch/HttpDispatcher;->getInstance()Lanet/channel/strategy/dispatch/HttpDispatcher;

    move-result-object v0

    iget v1, p0, Lanet/channel/strategy/StrategyTable;->g:I

    invoke-virtual {v0, p1, v1}, Lanet/channel/strategy/dispatch/HttpDispatcher;->sendAmdcRequest(Ljava/util/Set;I)V

    return-void

    :catchall_0
    move-exception p1

    .line 269
    :try_start_1
    monitor-exit v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1

    :cond_8
    :goto_1
    return-void
.end method

.method private b()V
    .locals 4

    .line 96
    invoke-static {}, Lanet/channel/strategy/dispatch/HttpDispatcher;->getInstance()Lanet/channel/strategy/dispatch/HttpDispatcher;

    move-result-object v0

    iget-object v1, p0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lanet/channel/strategy/dispatch/HttpDispatcher;->isInitHostsChanged(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 100
    :cond_0
    invoke-static {}, Lanet/channel/strategy/dispatch/HttpDispatcher;->getInstance()Lanet/channel/strategy/dispatch/HttpDispatcher;

    move-result-object v0

    invoke-virtual {v0}, Lanet/channel/strategy/dispatch/HttpDispatcher;->getInitHosts()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iget-object v2, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 101
    new-instance v3, Lanet/channel/strategy/StrategyCollection;

    invoke-direct {v3, v1}, Lanet/channel/strategy/StrategyCollection;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1, v3}, Lanet/channel/strategy/StrategyTable$HostLruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    return-void
.end method

.method private b(Ljava/util/Set;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 279
    new-instance v0, Ljava/util/TreeSet;

    sget-object v1, Lanet/channel/strategy/StrategyTable;->e:Ljava/util/Comparator;

    invoke-direct {v0, v1}, Ljava/util/TreeSet;-><init>(Ljava/util/Comparator;)V

    iget-object v1, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 280
    monitor-enter v1

    :try_start_0
    iget-object v2, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 281
    invoke-virtual {v2}, Lanet/channel/strategy/StrategyTable$HostLruCache;->values()Ljava/util/Collection;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/TreeSet;->addAll(Ljava/util/Collection;)Z

    .line 282
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 283
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    .line 284
    invoke-virtual {v0}, Ljava/util/TreeSet;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 285
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 286
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lanet/channel/strategy/StrategyCollection;

    .line 287
    invoke-virtual {v3}, Lanet/channel/strategy/StrategyCollection;->isExpired()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-interface {p1}, Ljava/util/Set;->size()I

    move-result v4

    const/16 v5, 0x28

    if-ge v4, v5, :cond_0

    const-wide/16 v4, 0x7530

    add-long/2addr v4, v1

    .line 288
    iput-wide v4, v3, Lanet/channel/strategy/StrategyCollection;->b:J

    .line 289
    iget-object v3, v3, Lanet/channel/strategy/StrategyCollection;->a:Ljava/lang/String;

    invoke-interface {p1, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    return-void

    :catchall_0
    move-exception p1

    .line 282
    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method private c()V
    .locals 6

    .line 298
    :try_start_0
    invoke-static {}, Lanet/channel/strategy/dispatch/HttpDispatcher;->getInstance()Lanet/channel/strategy/dispatch/HttpDispatcher;

    move-result-object v0

    iget-object v1, p0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lanet/channel/strategy/dispatch/HttpDispatcher;->isInitHostsChanged(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 300
    monitor-enter v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 301
    :try_start_1
    invoke-static {}, Lanet/channel/strategy/dispatch/HttpDispatcher;->getInstance()Lanet/channel/strategy/dispatch/HttpDispatcher;

    move-result-object v1

    invoke-virtual {v1}, Lanet/channel/strategy/dispatch/HttpDispatcher;->getInitHosts()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    const/4 v2, 0x0

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    iget-object v4, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 302
    invoke-virtual {v4, v3}, Lanet/channel/strategy/StrategyTable$HostLruCache;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_0

    iget-object v4, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 303
    new-instance v5, Lanet/channel/strategy/StrategyCollection;

    invoke-direct {v5, v3}, Lanet/channel/strategy/StrategyCollection;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, v3, v5}, Lanet/channel/strategy/StrategyTable$HostLruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    if-nez v2, :cond_1

    .line 305
    new-instance v2, Ljava/util/TreeSet;

    invoke-direct {v2}, Ljava/util/TreeSet;-><init>()V

    .line 307
    :cond_1
    invoke-interface {v2, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 310
    :cond_2
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    if-eqz v2, :cond_3

    .line 312
    :try_start_2
    invoke-direct {p0, v2}, Lanet/channel/strategy/StrategyTable;->a(Ljava/util/Set;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_1

    :catchall_0
    move-exception v1

    .line 310
    :try_start_3
    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw v1
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    :catch_0
    move-exception v0

    const-string v1, "awcn.StrategyTable"

    const-string v2, "checkInitHost failed"

    iget-object v3, p0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    const/4 v4, 0x0

    new-array v4, v4, [Ljava/lang/Object;

    .line 316
    invoke-static {v1, v2, v3, v0, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_3
    :goto_1
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 4

    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    if-nez v0, :cond_0

    .line 107
    new-instance v0, Lanet/channel/strategy/StrategyTable$HostLruCache;

    const/16 v1, 0x100

    invoke-direct {v0, v1}, Lanet/channel/strategy/StrategyTable$HostLruCache;-><init>(I)V

    iput-object v0, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 108
    invoke-direct {p0}, Lanet/channel/strategy/StrategyTable;->b()V

    :cond_0
    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 110
    invoke-virtual {v0}, Lanet/channel/strategy/StrategyTable$HostLruCache;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/strategy/StrategyCollection;

    .line 111
    invoke-virtual {v1}, Lanet/channel/strategy/StrategyCollection;->checkInit()V

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 114
    invoke-virtual {v0}, Lanet/channel/strategy/StrategyTable$HostLruCache;->size()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    const-string v1, "size"

    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "awcn.StrategyTable"

    const-string v2, "strategy map"

    const/4 v3, 0x0

    invoke-static {v1, v2, v3, v0}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 116
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isTargetProcess()Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x0

    goto :goto_1

    :cond_2
    const/4 v0, -0x1

    :goto_1
    iput v0, p0, Lanet/channel/strategy/StrategyTable;->g:I

    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->c:Ljava/util/Map;

    if-nez v0, :cond_3

    .line 119
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lanet/channel/strategy/StrategyTable;->c:Ljava/util/Map;

    :cond_3
    return-void
.end method

.method a(Ljava/lang/String;Lanet/channel/strategy/IConnStrategy;Lanet/channel/strategy/ConnEvent;)V
    .locals 9

    const/4 v0, 0x1

    .line 324
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const-string v0, "awcn.StrategyTable"

    const-string v2, "[notifyConnEvent]"

    const-string v3, "Host"

    const-string v5, "IConnStrategy"

    const-string v7, "ConnEvent"

    move-object v4, p1

    move-object v6, p2

    move-object v8, p3

    .line 325
    filled-new-array/range {v3 .. v8}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v2, v1, v3}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 328
    :cond_0
    invoke-interface {p2}, Lanet/channel/strategy/IConnStrategy;->getProtocol()Lanet/channel/strategy/ConnProtocol;

    move-result-object v0

    iget-object v0, v0, Lanet/channel/strategy/ConnProtocol;->protocol:Ljava/lang/String;

    const-string v2, "http3"

    .line 330
    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    const-string v2, "http3plain"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 331
    :cond_1
    iget-boolean v0, p3, Lanet/channel/strategy/ConnEvent;->isSuccess:Z

    invoke-static {v0}, Lanet/channel/e/a;->a(Z)V

    const-string v0, "awcn.StrategyTable"

    const-string v2, "enable http3"

    const-string v3, "uniqueId"

    iget-object v4, p0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    const-string v5, "enable"

    .line 332
    iget-boolean v6, p3, Lanet/channel/strategy/ConnEvent;->isSuccess:Z

    invoke-static {v6}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v6

    filled-new-array {v3, v4, v5, v6}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v2, v1, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 335
    :cond_2
    iget-boolean v0, p3, Lanet/channel/strategy/ConnEvent;->isSuccess:Z

    if-nez v0, :cond_3

    invoke-interface {p2}, Lanet/channel/strategy/IConnStrategy;->getIp()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lanet/channel/strategy/utils/c;->b(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->c:Ljava/util/Map;

    .line 336
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-interface {v0, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "awcn.StrategyTable"

    const-string v2, "disable ipv6"

    const-string v3, "uniqueId"

    iget-object v4, p0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    const-string v5, "host"

    .line 337
    filled-new-array {v3, v4, v5, p1}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {v0, v2, v1, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_3
    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 341
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 342
    invoke-virtual {v1, p1}, Lanet/channel/strategy/StrategyTable$HostLruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lanet/channel/strategy/StrategyCollection;

    .line 343
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p1, :cond_4

    .line 345
    invoke-virtual {p1, p2, p3}, Lanet/channel/strategy/StrategyCollection;->notifyConnEvent(Lanet/channel/strategy/IConnStrategy;Lanet/channel/strategy/ConnEvent;)V

    :cond_4
    return-void

    :catchall_0
    move-exception p1

    .line 343
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method protected a(Ljava/lang/String;Z)V
    .locals 6

    .line 228
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 233
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 234
    invoke-virtual {v1, p1}, Lanet/channel/strategy/StrategyTable$HostLruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/strategy/StrategyCollection;

    if-nez v1, :cond_1

    .line 236
    new-instance v1, Lanet/channel/strategy/StrategyCollection;

    invoke-direct {v1, p1}, Lanet/channel/strategy/StrategyCollection;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 237
    invoke-virtual {v2, p1, v1}, Lanet/channel/strategy/StrategyTable$HostLruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 239
    :cond_1
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez p2, :cond_2

    .line 241
    iget-wide v2, v1, Lanet/channel/strategy/StrategyCollection;->b:J

    const-wide/16 v4, 0x0

    cmp-long p2, v2, v4

    if-eqz p2, :cond_2

    invoke-virtual {v1}, Lanet/channel/strategy/StrategyCollection;->isExpired()Z

    move-result p2

    if-eqz p2, :cond_3

    invoke-static {}, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->getAmdcLimitLevel()I

    move-result p2

    if-nez p2, :cond_3

    .line 242
    :cond_2
    invoke-direct {p0, p1}, Lanet/channel/strategy/StrategyTable;->a(Ljava/lang/String;)V

    :cond_3
    return-void

    :catchall_0
    move-exception p1

    .line 239
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method a(Ljava/lang/String;J)Z
    .locals 4

    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->c:Ljava/util/Map;

    .line 350
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 353
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    add-long/2addr v2, p2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p2

    cmp-long p2, v2, p2

    if-gez p2, :cond_1

    iget-object p2, p0, Lanet/channel/strategy/StrategyTable;->c:Ljava/util/Map;

    .line 354
    invoke-interface {p2, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return v1

    :cond_1
    const/4 p1, 0x1

    return p1
.end method

.method public getCnameByHost(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .line 149
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 153
    monitor-enter v0

    :try_start_0
    iget-object v2, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 154
    invoke-virtual {v2, p1}, Lanet/channel/strategy/StrategyTable$HostLruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lanet/channel/strategy/StrategyCollection;

    .line 155
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_1

    .line 156
    invoke-virtual {v2}, Lanet/channel/strategy/StrategyCollection;->isExpired()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->getAmdcLimitLevel()I

    move-result v0

    if-nez v0, :cond_1

    .line 157
    invoke-direct {p0, p1}, Lanet/channel/strategy/StrategyTable;->a(Ljava/lang/String;)V

    :cond_1
    if-eqz v2, :cond_2

    .line 160
    iget-object v1, v2, Lanet/channel/strategy/StrategyCollection;->c:Ljava/lang/String;

    :cond_2
    return-object v1

    :catchall_0
    move-exception p1

    .line 155
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public queryByHost(Ljava/lang/String;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lanet/channel/strategy/IConnStrategy;",
            ">;"
        }
    .end annotation

    .line 128
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_4

    invoke-static {p1}, Lanet/channel/strategy/utils/c;->c(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 132
    :cond_0
    invoke-direct {p0}, Lanet/channel/strategy/StrategyTable;->c()V

    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 135
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 136
    invoke-virtual {v1, p1}, Lanet/channel/strategy/StrategyTable$HostLruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/strategy/StrategyCollection;

    if-nez v1, :cond_1

    .line 138
    new-instance v1, Lanet/channel/strategy/StrategyCollection;

    invoke-direct {v1, p1}, Lanet/channel/strategy/StrategyCollection;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 139
    invoke-virtual {v2, p1, v1}, Lanet/channel/strategy/StrategyTable$HostLruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 141
    :cond_1
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 142
    iget-wide v2, v1, Lanet/channel/strategy/StrategyCollection;->b:J

    const-wide/16 v4, 0x0

    cmp-long v0, v2, v4

    if-eqz v0, :cond_2

    invoke-virtual {v1}, Lanet/channel/strategy/StrategyCollection;->isExpired()Z

    move-result v0

    if-eqz v0, :cond_3

    invoke-static {}, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->getAmdcLimitLevel()I

    move-result v0

    if-nez v0, :cond_3

    .line 143
    :cond_2
    invoke-direct {p0, p1}, Lanet/channel/strategy/StrategyTable;->a(Ljava/lang/String;)V

    .line 145
    :cond_3
    invoke-virtual {v1}, Lanet/channel/strategy/StrategyCollection;->queryStrategyList()Ljava/util/List;

    move-result-object p1

    return-object p1

    :catchall_0
    move-exception p1

    .line 141
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1

    .line 129
    :cond_4
    :goto_0
    sget-object p1, Ljava/util/Collections;->EMPTY_LIST:Ljava/util/List;

    return-object p1
.end method

.method public update(Lanet/channel/strategy/l$d;)V
    .locals 7

    const-string v0, "awcn.StrategyTable"

    const-string v1, "update strategyTable with httpDns response"

    iget-object v2, p0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Object;

    .line 168
    invoke-static {v0, v1, v2, v4}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 170
    :try_start_0
    iget-object v0, p1, Lanet/channel/strategy/l$d;->a:Ljava/lang/String;

    iput-object v0, p0, Lanet/channel/strategy/StrategyTable;->b:Ljava/lang/String;

    .line 171
    iget v0, p1, Lanet/channel/strategy/l$d;->f:I

    iput v0, p0, Lanet/channel/strategy/StrategyTable;->g:I

    .line 172
    iget-object p1, p1, Lanet/channel/strategy/l$d;->b:[Lanet/channel/strategy/l$b;

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 177
    monitor-enter v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move v1, v3

    .line 178
    :goto_0
    :try_start_1
    array-length v2, p1

    if-ge v1, v2, :cond_5

    .line 179
    aget-object v2, p1, v1

    if-eqz v2, :cond_4

    .line 180
    iget-object v4, v2, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    if-nez v4, :cond_1

    goto :goto_1

    .line 184
    :cond_1
    iget-boolean v4, v2, Lanet/channel/strategy/l$b;->j:Z

    if-eqz v4, :cond_2

    iget-object v4, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 185
    iget-object v2, v2, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    invoke-virtual {v4, v2}, Lanet/channel/strategy/StrategyTable$HostLruCache;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_2
    iget-object v4, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 189
    iget-object v5, v2, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    invoke-virtual {v4, v5}, Lanet/channel/strategy/StrategyTable$HostLruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lanet/channel/strategy/StrategyCollection;

    if-nez v4, :cond_3

    .line 191
    new-instance v4, Lanet/channel/strategy/StrategyCollection;

    iget-object v5, v2, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    invoke-direct {v4, v5}, Lanet/channel/strategy/StrategyCollection;-><init>(Ljava/lang/String;)V

    iget-object v5, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 192
    iget-object v6, v2, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    invoke-virtual {v5, v6, v4}, Lanet/channel/strategy/StrategyTable$HostLruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 195
    :cond_3
    invoke-virtual {v4, v2}, Lanet/channel/strategy/StrategyCollection;->update(Lanet/channel/strategy/l$b;)V

    :cond_4
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 197
    :cond_5
    monitor-exit v0

    goto :goto_2

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :catchall_1
    move-exception p1

    const-string v0, "awcn.StrategyTable"

    const-string v1, "fail to update strategyTable"

    iget-object v2, p0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    new-array v4, v3, [Ljava/lang/Object;

    .line 199
    invoke-static {v0, v1, v2, p1, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_2
    const/4 p1, 0x1

    iput-boolean p1, p0, Lanet/channel/strategy/StrategyTable;->d:Z

    .line 204
    invoke-static {p1}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result p1

    if-eqz p1, :cond_7

    .line 205
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "uniqueId : "

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\n-------------------------domains:------------------------------------"

    .line 206
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "awcn.StrategyTable"

    .line 207
    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v2}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 208
    monitor-enter v0

    :try_start_3
    iget-object v1, p0, Lanet/channel/strategy/StrategyTable;->f:Lanet/channel/strategy/StrategyTable$HostLruCache;

    .line 209
    invoke-virtual {v1}, Lanet/channel/strategy/StrategyTable$HostLruCache;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_3
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 210
    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->setLength(I)V

    .line 211
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-virtual {p1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lanet/channel/strategy/StrategyCollection;

    invoke-virtual {v2}, Lanet/channel/strategy/StrategyCollection;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "awcn.StrategyTable"

    .line 212
    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    new-array v6, v3, [Ljava/lang/Object;

    invoke-static {v2, v5, v4, v6}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_3

    .line 214
    :cond_6
    monitor-exit v0

    goto :goto_4

    :catchall_2
    move-exception p1

    monitor-exit v0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    throw p1

    :cond_7
    :goto_4
    return-void
.end method
