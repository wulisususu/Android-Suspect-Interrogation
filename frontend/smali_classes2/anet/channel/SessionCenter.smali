.class public Lanet/channel/SessionCenter;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanet/channel/SessionCenter$a;
    }
.end annotation


# static fields
.field public static final TAG:Ljava/lang/String; = "awcn.SessionCenter"

.field static a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lanet/channel/Config;",
            "Lanet/channel/SessionCenter;",
            ">;"
        }
    .end annotation
.end field

.field private static j:Z


# instance fields
.field b:Landroid/content/Context;

.field c:Ljava/lang/String;

.field d:Lanet/channel/Config;

.field final e:Lanet/channel/e;

.field final f:Landroid/util/LruCache;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/LruCache<",
            "Ljava/lang/String;",
            "Lanet/channel/SessionRequest;",
            ">;"
        }
    .end annotation
.end field

.field final g:Lanet/channel/c;

.field final h:Lanet/channel/AccsSessionManager;

.field final i:Lanet/channel/SessionCenter$a;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 52
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lanet/channel/SessionCenter;->a:Ljava/util/Map;

    const/4 v0, 0x0

    sput-boolean v0, Lanet/channel/SessionCenter;->j:Z

    return-void
.end method

.method private constructor <init>(Lanet/channel/Config;)V
    .locals 2

    .line 132
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    new-instance v0, Lanet/channel/e;

    invoke-direct {v0}, Lanet/channel/e;-><init>()V

    iput-object v0, p0, Lanet/channel/SessionCenter;->e:Lanet/channel/e;

    .line 60
    new-instance v0, Landroid/util/LruCache;

    const/16 v1, 0x20

    invoke-direct {v0, v1}, Landroid/util/LruCache;-><init>(I)V

    iput-object v0, p0, Lanet/channel/SessionCenter;->f:Landroid/util/LruCache;

    .line 61
    new-instance v0, Lanet/channel/c;

    invoke-direct {v0}, Lanet/channel/c;-><init>()V

    iput-object v0, p0, Lanet/channel/SessionCenter;->g:Lanet/channel/c;

    .line 63
    new-instance v0, Lanet/channel/SessionCenter$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lanet/channel/SessionCenter$a;-><init>(Lanet/channel/SessionCenter;Lanet/channel/d;)V

    iput-object v0, p0, Lanet/channel/SessionCenter;->i:Lanet/channel/SessionCenter$a;

    .line 133
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getContext()Landroid/content/Context;

    move-result-object v1

    iput-object v1, p0, Lanet/channel/SessionCenter;->b:Landroid/content/Context;

    iput-object p1, p0, Lanet/channel/SessionCenter;->d:Lanet/channel/Config;

    .line 135
    invoke-virtual {p1}, Lanet/channel/Config;->getAppkey()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    .line 136
    invoke-virtual {v0}, Lanet/channel/SessionCenter$a;->a()V

    .line 137
    new-instance v0, Lanet/channel/AccsSessionManager;

    invoke-direct {v0, p0}, Lanet/channel/AccsSessionManager;-><init>(Lanet/channel/SessionCenter;)V

    iput-object v0, p0, Lanet/channel/SessionCenter;->h:Lanet/channel/AccsSessionManager;

    .line 139
    invoke-virtual {p1}, Lanet/channel/Config;->getAppkey()Ljava/lang/String;

    move-result-object v0

    const-string v1, "[default]"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 140
    invoke-virtual {p1}, Lanet/channel/Config;->getSecurity()Lanet/channel/security/ISecurity;

    move-result-object v0

    .line 141
    invoke-virtual {p1}, Lanet/channel/Config;->getAppkey()Ljava/lang/String;

    move-result-object p1

    .line 142
    new-instance v1, Lanet/channel/d;

    invoke-direct {v1, p0, p1, v0}, Lanet/channel/d;-><init>(Lanet/channel/SessionCenter;Ljava/lang/String;Lanet/channel/security/ISecurity;)V

    invoke-static {v1}, Lanet/channel/strategy/dispatch/AmdcRuntimeInfo;->setSign(Lanet/channel/strategy/dispatch/IAmdcSign;)V

    :cond_0
    return-void
.end method

.method private a(Lanet/channel/util/HttpUrl;)Lanet/channel/SessionRequest;
    .locals 2

    .line 393
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object v0

    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->host()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lanet/channel/strategy/IStrategyInstance;->getCNameByHost(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    .line 394
    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->host()Ljava/lang/String;

    move-result-object v0

    .line 395
    :cond_0
    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object v1

    .line 396
    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->isSchemeLocked()Z

    move-result p1

    if-nez p1, :cond_1

    .line 397
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object p1

    invoke-interface {p1, v0, v1}, Lanet/channel/strategy/IStrategyInstance;->getSchemeByHost(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :cond_1
    const-string p1, "://"

    .line 400
    invoke-static {v1, p1, v0}, Lanet/channel/util/StringUtils;->concatString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 401
    invoke-virtual {p0, p1}, Lanet/channel/SessionCenter;->a(Ljava/lang/String;)Lanet/channel/SessionRequest;

    move-result-object p1

    return-object p1
.end method

.method static synthetic a(Lanet/channel/SessionCenter;Lanet/channel/strategy/l$d;)V
    .locals 0

    .line 48
    invoke-direct {p0, p1}, Lanet/channel/SessionCenter;->a(Lanet/channel/strategy/l$d;)V

    return-void
.end method

.method private a(Lanet/channel/strategy/l$b;)V
    .locals 7

    iget-object v0, p0, Lanet/channel/SessionCenter;->e:Lanet/channel/e;

    .line 534
    iget-object v1, p1, Lanet/channel/strategy/l$b;->c:Ljava/lang/String;

    iget-object v2, p1, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    invoke-static {v1, v2}, Lanet/channel/util/StringUtils;->buildKey(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lanet/channel/SessionCenter;->a(Ljava/lang/String;)Lanet/channel/SessionRequest;

    move-result-object v1

    invoke-virtual {v0, v1}, Lanet/channel/e;->a(Lanet/channel/SessionRequest;)Ljava/util/List;

    move-result-object v0

    .line 535
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/Session;

    .line 536
    iget-object v2, v1, Lanet/channel/Session;->l:Ljava/lang/String;

    iget-object v3, p1, Lanet/channel/strategy/l$b;->e:Ljava/lang/String;

    invoke-static {v2, v3}, Lanet/channel/util/StringUtils;->isStringEqual(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 537
    iget-object v2, v1, Lanet/channel/Session;->p:Ljava/lang/String;

    iget-object v3, v1, Lanet/channel/Session;->l:Ljava/lang/String;

    const-string v4, "unit"

    iget-object v5, p1, Lanet/channel/strategy/l$b;->e:Ljava/lang/String;

    const-string v6, "session unit"

    filled-new-array {v6, v3, v4, v5}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "awcn.SessionCenter"

    const-string v5, "unit change"

    invoke-static {v4, v5, v2, v3}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 v2, 0x1

    .line 538
    invoke-virtual {v1, v2}, Lanet/channel/Session;->close(Z)V

    goto :goto_0

    :cond_1
    return-void
.end method

.method private a(Lanet/channel/strategy/l$d;)V
    .locals 4

    const/4 v0, 0x0

    .line 518
    :try_start_0
    iget-object p1, p1, Lanet/channel/strategy/l$d;->b:[Lanet/channel/strategy/l$b;

    move v1, v0

    .line 519
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_2

    .line 520
    aget-object v2, p1, v1

    .line 521
    iget-boolean v3, v2, Lanet/channel/strategy/l$b;->k:Z

    if-eqz v3, :cond_0

    .line 522
    invoke-direct {p0, v2}, Lanet/channel/SessionCenter;->b(Lanet/channel/strategy/l$b;)V

    .line 524
    :cond_0
    iget-object v3, v2, Lanet/channel/strategy/l$b;->e:Ljava/lang/String;

    if-eqz v3, :cond_1

    .line 525
    invoke-direct {p0, v2}, Lanet/channel/SessionCenter;->a(Lanet/channel/strategy/l$b;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object v1, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    new-array v0, v0, [Ljava/lang/Object;

    const-string v2, "awcn.SessionCenter"

    const-string v3, "checkStrategy failed"

    .line 529
    invoke-static {v2, v3, v1, p1, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_2
    return-void
.end method

.method static synthetic a()Z
    .locals 1

    sget-boolean v0, Lanet/channel/SessionCenter;->j:Z

    return v0
.end method

.method private b(Lanet/channel/strategy/l$b;)V
    .locals 17

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    iget-object v2, v0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    const-string v3, "host"

    .line 544
    iget-object v4, v1, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    filled-new-array {v3, v4}, [Ljava/lang/Object;

    move-result-object v3

    const-string v4, "awcn.SessionCenter"

    const-string v5, "find effectNow"

    invoke-static {v4, v5, v2, v3}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 545
    iget-object v2, v1, Lanet/channel/strategy/l$b;->h:[Lanet/channel/strategy/l$a;

    .line 546
    iget-object v3, v1, Lanet/channel/strategy/l$b;->f:[Ljava/lang/String;

    iget-object v5, v0, Lanet/channel/SessionCenter;->e:Lanet/channel/e;

    .line 548
    iget-object v6, v1, Lanet/channel/strategy/l$b;->c:Ljava/lang/String;

    iget-object v1, v1, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    invoke-static {v6, v1}, Lanet/channel/util/StringUtils;->buildKey(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lanet/channel/SessionCenter;->a(Ljava/lang/String;)Lanet/channel/SessionRequest;

    move-result-object v1

    invoke-virtual {v5, v1}, Lanet/channel/e;->a(Lanet/channel/SessionRequest;)Ljava/util/List;

    move-result-object v1

    .line 549
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_7

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lanet/channel/Session;

    .line 550
    invoke-virtual {v5}, Lanet/channel/Session;->getConnType()Lanet/channel/entity/ConnType;

    move-result-object v6

    invoke-virtual {v6}, Lanet/channel/entity/ConnType;->isHttpType()Z

    move-result v6

    if-eqz v6, :cond_0

    goto :goto_0

    :cond_0
    const/4 v6, 0x0

    move v7, v6

    .line 555
    :goto_1
    array-length v8, v3

    const/4 v9, 0x2

    const/4 v10, 0x1

    if-ge v7, v8, :cond_5

    .line 556
    invoke-virtual {v5}, Lanet/channel/Session;->getIp()Ljava/lang/String;

    move-result-object v8

    aget-object v11, v3, v7

    invoke-virtual {v8, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_4

    .line 571
    :goto_2
    array-length v7, v2

    if-ge v6, v7, :cond_2

    .line 572
    invoke-virtual {v5}, Lanet/channel/Session;->getPort()I

    move-result v7

    aget-object v8, v2, v6

    iget v8, v8, Lanet/channel/strategy/l$a;->a:I

    if-ne v7, v8, :cond_1

    invoke-virtual {v5}, Lanet/channel/Session;->getConnType()Lanet/channel/entity/ConnType;

    move-result-object v7

    aget-object v8, v2, v6

    invoke-static {v8}, Lanet/channel/strategy/ConnProtocol;->valueOf(Lanet/channel/strategy/l$a;)Lanet/channel/strategy/ConnProtocol;

    move-result-object v8

    invoke-static {v8}, Lanet/channel/entity/ConnType;->valueOf(Lanet/channel/strategy/ConnProtocol;)Lanet/channel/entity/ConnType;

    move-result-object v8

    invoke-virtual {v7, v8}, Lanet/channel/entity/ConnType;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_1

    goto :goto_0

    :cond_1
    add-int/lit8 v6, v6, 0x1

    goto :goto_2

    .line 579
    :cond_2
    invoke-static {v9}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 580
    iget-object v6, v5, Lanet/channel/Session;->p:Ljava/lang/String;

    const-string v11, "port"

    invoke-virtual {v5}, Lanet/channel/Session;->getPort()I

    move-result v7

    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    const-string v13, "connType"

    invoke-virtual {v5}, Lanet/channel/Session;->getConnType()Lanet/channel/entity/ConnType;

    move-result-object v14

    const-string v15, "aisle"

    .line 581
    invoke-static {v2}, Ljava/util/Arrays;->toString([Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v16

    filled-new-array/range {v11 .. v16}, [Ljava/lang/Object;

    move-result-object v7

    const-string v8, "aisle not match"

    .line 580
    invoke-static {v4, v8, v6, v7}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 583
    :cond_3
    invoke-virtual {v5, v10}, Lanet/channel/Session;->close(Z)V

    goto :goto_0

    :cond_4
    add-int/lit8 v7, v7, 0x1

    goto :goto_1

    .line 563
    :cond_5
    invoke-static {v9}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 564
    iget-object v6, v5, Lanet/channel/Session;->p:Ljava/lang/String;

    invoke-virtual {v5}, Lanet/channel/Session;->getIp()Ljava/lang/String;

    move-result-object v7

    const-string v8, "ips"

    invoke-static {v3}, Ljava/util/Arrays;->toString([Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    const-string v11, "session ip"

    filled-new-array {v11, v7, v8, v9}, [Ljava/lang/Object;

    move-result-object v7

    const-string v8, "ip not match"

    invoke-static {v4, v8, v6, v7}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 566
    :cond_6
    invoke-virtual {v5, v10}, Lanet/channel/Session;->close(Z)V

    goto/16 :goto_0

    :cond_7
    return-void
.end method

.method public static checkAndStartAccsSession()V
    .locals 2

    sget-object v0, Lanet/channel/SessionCenter;->a:Ljava/util/Map;

    .line 383
    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/SessionCenter;

    .line 384
    iget-object v1, v1, Lanet/channel/SessionCenter;->h:Lanet/channel/AccsSessionManager;

    invoke-virtual {v1}, Lanet/channel/AccsSessionManager;->checkAndStartSession()V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public static declared-synchronized getInstance()Lanet/channel/SessionCenter;
    .locals 5
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const-class v0, Lanet/channel/SessionCenter;

    monitor-enter v0

    :try_start_0
    sget-boolean v1, Lanet/channel/SessionCenter;->j:Z

    if-nez v1, :cond_0

    .line 236
    invoke-static {}, Lanet/channel/util/Utils;->getAppContext()Landroid/content/Context;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 238
    invoke-static {v1}, Lanet/channel/SessionCenter;->init(Landroid/content/Context;)V

    :cond_0
    sget-object v1, Lanet/channel/SessionCenter;->a:Ljava/util/Map;

    .line 243
    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    const/4 v2, 0x0

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 244
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lanet/channel/SessionCenter;

    .line 245
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    sget-object v4, Lanet/channel/Config;->DEFAULT_CONFIG:Lanet/channel/Config;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eq v2, v4, :cond_1

    .line 246
    monitor-exit v0

    return-object v3

    :cond_1
    move-object v2, v3

    goto :goto_0

    .line 249
    :cond_2
    monitor-exit v0

    return-object v2

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized getInstance(Lanet/channel/Config;)Lanet/channel/SessionCenter;
    .locals 3

    const-class v0, Lanet/channel/SessionCenter;

    monitor-enter v0

    if-eqz p0, :cond_2

    :try_start_0
    sget-boolean v1, Lanet/channel/SessionCenter;->j:Z

    if-nez v1, :cond_0

    .line 215
    invoke-static {}, Lanet/channel/util/Utils;->getAppContext()Landroid/content/Context;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 217
    invoke-static {v1}, Lanet/channel/SessionCenter;->init(Landroid/content/Context;)V

    :cond_0
    sget-object v1, Lanet/channel/SessionCenter;->a:Ljava/util/Map;

    .line 221
    invoke-interface {v1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/SessionCenter;

    if-nez v1, :cond_1

    .line 223
    new-instance v1, Lanet/channel/SessionCenter;

    invoke-direct {v1, p0}, Lanet/channel/SessionCenter;-><init>(Lanet/channel/Config;)V

    sget-object v2, Lanet/channel/SessionCenter;->a:Ljava/util/Map;

    .line 224
    invoke-interface {v2, p0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 227
    :cond_1
    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception p0

    goto :goto_0

    .line 211
    :cond_2
    :try_start_1
    new-instance p0, Ljava/lang/NullPointerException;

    const-string v1, "config is null!"

    invoke-direct {p0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized getInstance(Ljava/lang/String;)Lanet/channel/SessionCenter;
    .locals 2

    const-class v0, Lanet/channel/SessionCenter;

    monitor-enter v0

    .line 202
    :try_start_0
    invoke-static {p0}, Lanet/channel/Config;->getConfigByTag(Ljava/lang/String;)Lanet/channel/Config;

    move-result-object p0

    if-eqz p0, :cond_0

    .line 206
    invoke-static {p0}, Lanet/channel/SessionCenter;->getInstance(Lanet/channel/Config;)Lanet/channel/SessionCenter;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object p0

    .line 204
    :cond_0
    :try_start_1
    new-instance p0, Ljava/lang/RuntimeException;

    const-string v1, "tag not exist!"

    invoke-direct {p0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized init(Landroid/content/Context;)V
    .locals 5

    const-class v0, Lanet/channel/SessionCenter;

    monitor-enter v0

    if-eqz p0, :cond_3

    .line 70
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lanet/channel/GlobalAppRuntimeInfo;->setContext(Landroid/content/Context;)V

    sget-boolean v1, Lanet/channel/SessionCenter;->j:Z

    if-nez v1, :cond_2

    sget-object v1, Lanet/channel/SessionCenter;->a:Ljava/util/Map;

    .line 72
    sget-object v2, Lanet/channel/Config;->DEFAULT_CONFIG:Lanet/channel/Config;

    new-instance v3, Lanet/channel/SessionCenter;

    sget-object v4, Lanet/channel/Config;->DEFAULT_CONFIG:Lanet/channel/Config;

    invoke-direct {v3, v4}, Lanet/channel/SessionCenter;-><init>(Lanet/channel/Config;)V

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 74
    invoke-static {}, Lanet/channel/util/AppLifecycle;->initialize()V

    .line 76
    invoke-static {p0}, Lanet/channel/status/NetworkStatusHelper;->startListener(Landroid/content/Context;)V

    .line 78
    invoke-static {}, Lanet/channel/AwcnConfig;->isTbNextLaunch()Z

    move-result p0

    if-nez p0, :cond_0

    .line 79
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object p0

    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-interface {p0, v1}, Lanet/channel/strategy/IStrategyInstance;->initialize(Landroid/content/Context;)V

    .line 82
    :cond_0
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isTargetProcess()Z

    move-result p0

    if-eqz p0, :cond_1

    .line 83
    invoke-static {}, Lanet/channel/detect/n;->a()V

    .line 84
    invoke-static {}, Lanet/channel/e/a;->a()V

    :cond_1
    const/4 p0, 0x1

    sput-boolean p0, Lanet/channel/SessionCenter;->j:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 88
    :cond_2
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    goto :goto_0

    :cond_3
    :try_start_1
    const-string p0, "awcn.SessionCenter"

    const-string v1, "context is null!"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    .line 67
    invoke-static {p0, v1, v3, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 68
    new-instance p0, Ljava/lang/NullPointerException;

    const-string v1, "init failed. context is null"

    invoke-direct {p0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized init(Landroid/content/Context;Lanet/channel/Config;)V
    .locals 3

    const-class v0, Lanet/channel/SessionCenter;

    monitor-enter v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-eqz p0, :cond_2

    if-eqz p1, :cond_1

    .line 124
    :try_start_0
    invoke-static {p0}, Lanet/channel/SessionCenter;->init(Landroid/content/Context;)V

    sget-object p0, Lanet/channel/SessionCenter;->a:Ljava/util/Map;

    .line 126
    invoke-interface {p0, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result p0

    if-nez p0, :cond_0

    .line 127
    new-instance p0, Lanet/channel/SessionCenter;

    invoke-direct {p0, p1}, Lanet/channel/SessionCenter;-><init>(Lanet/channel/Config;)V

    sget-object v1, Lanet/channel/SessionCenter;->a:Ljava/util/Map;

    .line 128
    invoke-interface {v1, p1, p0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 130
    :cond_0
    monitor-exit v0

    return-void

    :cond_1
    :try_start_1
    const-string p0, "awcn.SessionCenter"

    const-string p1, "paramter config is null!"

    new-array v1, v1, [Ljava/lang/Object;

    .line 120
    invoke-static {p0, p1, v2, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 121
    new-instance p0, Ljava/lang/NullPointerException;

    const-string p1, "init failed. config is null"

    invoke-direct {p0, p1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_2
    const-string p0, "awcn.SessionCenter"

    const-string p1, "context is null!"

    new-array v1, v1, [Ljava/lang/Object;

    .line 115
    invoke-static {p0, p1, v2, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 116
    new-instance p0, Ljava/lang/NullPointerException;

    const-string p1, "init failed. context is null"

    invoke-direct {p0, p1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized init(Landroid/content/Context;Ljava/lang/String;)V
    .locals 2
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const-class v0, Lanet/channel/SessionCenter;

    monitor-enter v0

    .line 96
    :try_start_0
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getEnv()Lanet/channel/entity/ENV;

    move-result-object v1

    invoke-static {p0, p1, v1}, Lanet/channel/SessionCenter;->init(Landroid/content/Context;Ljava/lang/String;Lanet/channel/entity/ENV;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 97
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized init(Landroid/content/Context;Ljava/lang/String;Lanet/channel/entity/ENV;)V
    .locals 2

    const-class v0, Lanet/channel/SessionCenter;

    monitor-enter v0

    if-eqz p0, :cond_1

    .line 105
    :try_start_0
    invoke-static {p1, p2}, Lanet/channel/Config;->getConfig(Ljava/lang/String;Lanet/channel/entity/ENV;)Lanet/channel/Config;

    move-result-object v1

    if-nez v1, :cond_0

    .line 107
    new-instance v1, Lanet/channel/Config$Builder;

    invoke-direct {v1}, Lanet/channel/Config$Builder;-><init>()V

    invoke-virtual {v1, p1}, Lanet/channel/Config$Builder;->setAppkey(Ljava/lang/String;)Lanet/channel/Config$Builder;

    move-result-object p1

    invoke-virtual {p1, p2}, Lanet/channel/Config$Builder;->setEnv(Lanet/channel/entity/ENV;)Lanet/channel/Config$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lanet/channel/Config$Builder;->build()Lanet/channel/Config;

    move-result-object v1

    .line 110
    :cond_0
    invoke-static {p0, v1}, Lanet/channel/SessionCenter;->init(Landroid/content/Context;Lanet/channel/Config;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 111
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    goto :goto_0

    :cond_1
    :try_start_1
    const-string p0, "awcn.SessionCenter"

    const-string p1, "context is null!"

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    const/4 v1, 0x0

    .line 101
    invoke-static {p0, p1, v1, p2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 102
    new-instance p0, Ljava/lang/NullPointerException;

    const-string p1, "init failed. context is null"

    invoke-direct {p0, p1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    monitor-exit v0

    throw p0
.end method

.method public static declared-synchronized switchEnvironment(Lanet/channel/entity/ENV;)V
    .locals 12

    const-class v0, Lanet/channel/SessionCenter;

    monitor-enter v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    .line 172
    :try_start_0
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getEnv()Lanet/channel/entity/ENV;

    move-result-object v3

    const/4 v4, 0x2

    const/4 v5, 0x1

    if-eq v3, p0, :cond_1

    const-string v3, "awcn.SessionCenter"

    const-string v6, "switch env"

    const/4 v7, 0x4

    new-array v7, v7, [Ljava/lang/Object;

    const-string v8, "old"

    aput-object v8, v7, v2

    .line 173
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getEnv()Lanet/channel/entity/ENV;

    move-result-object v8

    aput-object v8, v7, v5

    const-string v8, "new"

    aput-object v8, v7, v4

    const/4 v8, 0x3

    aput-object p0, v7, v8

    invoke-static {v3, v6, v1, v7}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 174
    invoke-static {p0}, Lanet/channel/GlobalAppRuntimeInfo;->setEnv(Lanet/channel/entity/ENV;)V

    .line 176
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object v3

    invoke-interface {v3}, Lanet/channel/strategy/IStrategyInstance;->switchEnv()V

    .line 177
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getContext()Landroid/content/Context;

    move-result-object v3

    sget-object v6, Lorg/android/spdy/SpdyVersion;->SPDY3:Lorg/android/spdy/SpdyVersion;

    sget-object v7, Lorg/android/spdy/SpdySessionKind;->NONE_SESSION:Lorg/android/spdy/SpdySessionKind;

    invoke-static {v3, v6, v7}, Lorg/android/spdy/SpdyAgent;->getInstance(Landroid/content/Context;Lorg/android/spdy/SpdyVersion;Lorg/android/spdy/SpdySessionKind;)Lorg/android/spdy/SpdyAgent;

    move-result-object v3

    .line 178
    sget-object v6, Lanet/channel/entity/ENV;->TEST:Lanet/channel/entity/ENV;

    if-ne p0, v6, :cond_0

    move v6, v2

    goto :goto_0

    :cond_0
    move v6, v5

    :goto_0
    invoke-virtual {v3, v6}, Lorg/android/spdy/SpdyAgent;->switchAccsServer(I)V

    :cond_1
    sget-object v3, Lanet/channel/SessionCenter;->a:Ljava/util/Map;

    .line 181
    invoke-interface {v3}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .line 182
    :cond_2
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_3

    .line 183
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Map$Entry;

    invoke-interface {v6}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lanet/channel/SessionCenter;

    .line 184
    iget-object v7, v6, Lanet/channel/SessionCenter;->d:Lanet/channel/Config;

    invoke-virtual {v7}, Lanet/channel/Config;->getEnv()Lanet/channel/entity/ENV;

    move-result-object v7

    if-eq v7, p0, :cond_2

    const-string v7, "awcn.SessionCenter"

    const-string v8, "remove instance"

    .line 185
    iget-object v9, v6, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    new-array v10, v4, [Ljava/lang/Object;

    const-string v11, "ENVIRONMENT"

    aput-object v11, v10, v2

    iget-object v11, v6, Lanet/channel/SessionCenter;->d:Lanet/channel/Config;

    invoke-virtual {v11}, Lanet/channel/Config;->getEnv()Lanet/channel/entity/ENV;

    move-result-object v11

    aput-object v11, v10, v5

    invoke-static {v7, v8, v9, v10}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 186
    iget-object v7, v6, Lanet/channel/SessionCenter;->h:Lanet/channel/AccsSessionManager;

    invoke-virtual {v7, v2}, Lanet/channel/AccsSessionManager;->forceCloseSession(Z)V

    .line 187
    iget-object v6, v6, Lanet/channel/SessionCenter;->i:Lanet/channel/SessionCenter$a;

    invoke-virtual {v6}, Lanet/channel/SessionCenter$a;->b()V

    .line 188
    invoke-interface {v3}, Ljava/util/Iterator;->remove()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception p0

    :try_start_1
    const-string v3, "awcn.SessionCenter"

    const-string v4, "switch env error."

    new-array v2, v2, [Ljava/lang/Object;

    .line 192
    invoke-static {v3, v4, v1, p0, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 194
    :cond_3
    monitor-exit v0

    return-void

    :catchall_1
    move-exception p0

    monitor-exit v0

    throw p0
.end method


# virtual methods
.method protected a(Lanet/channel/util/HttpUrl;IJLanet/channel/SessionGetCallback;)Lanet/channel/Session;
    .locals 13
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    move-object v0, p0

    move v8, p2

    move-wide/from16 v9, p3

    sget-boolean v1, Lanet/channel/SessionCenter;->j:Z

    const/4 v2, 0x0

    const-string v3, "awcn.SessionCenter"

    if-eqz v1, :cond_a

    if-eqz p1, :cond_9

    iget-object v1, v0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    const/4 v4, 0x6

    new-array v4, v4, [Ljava/lang/Object;

    const-string v5, "u"

    aput-object v5, v4, v2

    const/4 v5, 0x1

    .line 414
    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->urlString()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v4, v5

    const/4 v5, 0x2

    const-string v6, "sessionType"

    aput-object v6, v4, v5

    sget v5, Lanet/channel/entity/c;->a:I

    if-ne v8, v5, :cond_0

    const-string v5, "LongLink"

    goto :goto_0

    :cond_0
    const-string v5, "ShortLink"

    :goto_0
    const/4 v6, 0x3

    aput-object v5, v4, v6

    const/4 v5, 0x4

    const-string v6, "timeout"

    aput-object v6, v4, v5

    const/4 v5, 0x5

    .line 415
    invoke-static/range {p3 .. p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v6

    aput-object v6, v4, v5

    const-string v5, "getInternal"

    .line 414
    invoke-static {v3, v5, v1, v4}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 417
    invoke-direct {p0, p1}, Lanet/channel/SessionCenter;->a(Lanet/channel/util/HttpUrl;)Lanet/channel/SessionRequest;

    move-result-object v11

    iget-object v1, v0, Lanet/channel/SessionCenter;->e:Lanet/channel/e;

    .line 418
    invoke-virtual {v1, v11, p2}, Lanet/channel/e;->a(Lanet/channel/SessionRequest;I)Lanet/channel/Session;

    move-result-object v12

    if-eqz v12, :cond_1

    iget-object v1, v0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    const-string v2, "session"

    .line 421
    filled-new-array {v2, v12}, [Ljava/lang/Object;

    move-result-object v2

    const-string v4, "get internal hit cache session"

    invoke-static {v3, v4, v1, v2}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto/16 :goto_2

    :cond_1
    iget-object v1, v0, Lanet/channel/SessionCenter;->d:Lanet/channel/Config;

    .line 423
    sget-object v4, Lanet/channel/Config;->DEFAULT_CONFIG:Lanet/channel/Config;

    if-ne v1, v4, :cond_3

    sget v1, Lanet/channel/entity/c;->b:I

    if-eq v8, v1, :cond_3

    if-eqz p5, :cond_2

    .line 426
    invoke-interface/range {p5 .. p5}, Lanet/channel/SessionGetCallback;->onSessionGetFail()V

    :cond_2
    const/4 v1, 0x0

    return-object v1

    .line 431
    :cond_3
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v1

    if-eqz v1, :cond_5

    sget v1, Lanet/channel/entity/c;->a:I

    if-ne v8, v1, :cond_5

    .line 433
    invoke-static {}, Lanet/channel/AwcnConfig;->isAccsSessionCreateForbiddenInBg()Z

    move-result v1

    if-eqz v1, :cond_5

    iget-object v1, v0, Lanet/channel/SessionCenter;->g:Lanet/channel/c;

    .line 434
    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->host()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Lanet/channel/c;->b(Ljava/lang/String;)Lanet/channel/SessionInfo;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 435
    iget-boolean v1, v1, Lanet/channel/SessionInfo;->isAccs:Z

    if-nez v1, :cond_4

    goto :goto_1

    :cond_4
    iget-object v1, v0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, "app background, forbid to create accs session"

    .line 436
    invoke-static {v3, v4, v1, v2}, Lanet/channel/util/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 437
    new-instance v1, Ljava/net/ConnectException;

    const-string v2, "accs session connecting forbidden in background"

    invoke-direct {v1, v2}, Ljava/net/ConnectException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_5
    :goto_1
    iget-object v2, v0, Lanet/channel/SessionCenter;->b:Landroid/content/Context;

    iget-object v1, v0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    .line 440
    invoke-static {v1}, Lanet/channel/util/i;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    move-object v1, v11

    move v3, p2

    move-object/from16 v5, p5

    move-wide/from16 v6, p3

    invoke-virtual/range {v1 .. v7}, Lanet/channel/SessionRequest;->a(Landroid/content/Context;ILjava/lang/String;Lanet/channel/SessionGetCallback;J)V

    if-nez p5, :cond_8

    const-wide/16 v1, 0x0

    cmp-long v1, v9, v1

    if-lez v1, :cond_8

    .line 441
    sget v1, Lanet/channel/entity/c;->c:I

    if-eq v8, v1, :cond_6

    .line 443
    invoke-virtual {v11}, Lanet/channel/SessionRequest;->b()I

    move-result v1

    if-ne v1, v8, :cond_8

    .line 444
    :cond_6
    invoke-virtual {v11, v9, v10}, Lanet/channel/SessionRequest;->a(J)V

    iget-object v1, v0, Lanet/channel/SessionCenter;->e:Lanet/channel/e;

    .line 445
    invoke-virtual {v1, v11, p2}, Lanet/channel/e;->a(Lanet/channel/SessionRequest;I)Lanet/channel/Session;

    move-result-object v12

    if-eqz v12, :cond_7

    goto :goto_2

    .line 447
    :cond_7
    new-instance v1, Ljava/net/ConnectException;

    const-string v2, "session connecting failed or timeout"

    invoke-direct {v1, v2}, Ljava/net/ConnectException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_8
    :goto_2
    return-object v12

    .line 411
    :cond_9
    new-instance v1, Ljava/security/InvalidParameterException;

    const-string v2, "httpUrl is null"

    invoke-direct {v1, v2}, Ljava/security/InvalidParameterException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_a
    iget-object v1, v0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, "getInternal not inited!"

    .line 406
    invoke-static {v3, v4, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 407
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "getInternal not inited"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method protected a(Ljava/lang/String;)Lanet/channel/SessionRequest;
    .locals 3

    .line 589
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    iget-object v0, p0, Lanet/channel/SessionCenter;->f:Landroid/util/LruCache;

    .line 594
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lanet/channel/SessionCenter;->f:Landroid/util/LruCache;

    .line 595
    invoke-virtual {v1, p1}, Landroid/util/LruCache;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/SessionRequest;

    if-nez v1, :cond_1

    .line 597
    new-instance v1, Lanet/channel/SessionRequest;

    invoke-direct {v1, p1, p0}, Lanet/channel/SessionRequest;-><init>(Ljava/lang/String;Lanet/channel/SessionCenter;)V

    iget-object v2, p0, Lanet/channel/SessionCenter;->f:Landroid/util/LruCache;

    .line 598
    invoke-virtual {v2, p1, v1}, Landroid/util/LruCache;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 600
    :cond_1
    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public asyncGet(Lanet/channel/util/HttpUrl;IJLanet/channel/SessionGetCallback;)V
    .locals 2

    if-eqz p5, :cond_1

    const-wide/16 v0, 0x0

    cmp-long v0, p3, v0

    if-lez v0, :cond_0

    .line 350
    :try_start_0
    invoke-virtual/range {p0 .. p5}, Lanet/channel/SessionCenter;->b(Lanet/channel/util/HttpUrl;IJLanet/channel/SessionGetCallback;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 352
    :catch_0
    invoke-interface {p5}, Lanet/channel/SessionGetCallback;->onSessionGetFail()V

    :goto_0
    return-void

    .line 347
    :cond_0
    new-instance p1, Ljava/security/InvalidParameterException;

    const-string p2, "timeout must > 0"

    invoke-direct {p1, p2}, Ljava/security/InvalidParameterException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 344
    :cond_1
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "cb is null"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method protected b(Lanet/channel/util/HttpUrl;IJLanet/channel/SessionGetCallback;)V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    sget-boolean v0, Lanet/channel/SessionCenter;->j:Z

    const/4 v1, 0x0

    const-string v3, "awcn.SessionCenter"

    if-eqz v0, :cond_7

    if-eqz p1, :cond_6

    if-eqz p5, :cond_5

    iget-object v0, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    const/4 v5, 0x6

    new-array v5, v5, [Ljava/lang/Object;

    const-string v6, "u"

    aput-object v6, v5, v1

    const/4 v6, 0x1

    .line 469
    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->urlString()Ljava/lang/String;

    move-result-object v7

    aput-object v7, v5, v6

    const/4 v6, 0x2

    const-string v7, "sessionType"

    aput-object v7, v5, v6

    sget v6, Lanet/channel/entity/c;->a:I

    if-ne p2, v6, :cond_0

    const-string v6, "LongLink"

    goto :goto_0

    :cond_0
    const-string v6, "ShortLink"

    :goto_0
    const/4 v7, 0x3

    aput-object v6, v5, v7

    const/4 v6, 0x4

    const-string v7, "timeout"

    aput-object v7, v5, v6

    const/4 v6, 0x5

    .line 470
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    aput-object v7, v5, v6

    const-string v6, "getInternal"

    .line 469
    invoke-static {v3, v6, v0, v5}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 472
    invoke-direct {p0, p1}, Lanet/channel/SessionCenter;->a(Lanet/channel/util/HttpUrl;)Lanet/channel/SessionRequest;

    move-result-object v0

    iget-object v5, p0, Lanet/channel/SessionCenter;->e:Lanet/channel/e;

    .line 473
    invoke-virtual {v5, v0, p2}, Lanet/channel/e;->a(Lanet/channel/SessionRequest;I)Lanet/channel/Session;

    move-result-object v5

    if-eqz v5, :cond_1

    iget-object v0, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    const-string v1, "session"

    .line 476
    filled-new-array {v1, v5}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "get internal hit cache session"

    invoke-static {v3, v2, v0, v1}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 477
    invoke-interface {p5, v5}, Lanet/channel/SessionGetCallback;->onSessionGetSuccess(Lanet/channel/Session;)V

    return-void

    :cond_1
    iget-object v5, p0, Lanet/channel/SessionCenter;->d:Lanet/channel/Config;

    .line 480
    sget-object v6, Lanet/channel/Config;->DEFAULT_CONFIG:Lanet/channel/Config;

    if-ne v5, v6, :cond_2

    sget v5, Lanet/channel/entity/c;->b:I

    if-eq p2, v5, :cond_2

    .line 482
    invoke-interface {p5}, Lanet/channel/SessionGetCallback;->onSessionGetFail()V

    return-void

    .line 486
    :cond_2
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v5

    if-eqz v5, :cond_4

    sget v5, Lanet/channel/entity/c;->a:I

    if-ne p2, v5, :cond_4

    .line 488
    invoke-static {}, Lanet/channel/AwcnConfig;->isAccsSessionCreateForbiddenInBg()Z

    move-result v5

    if-eqz v5, :cond_4

    iget-object v5, p0, Lanet/channel/SessionCenter;->g:Lanet/channel/c;

    .line 489
    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->host()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lanet/channel/c;->b(Ljava/lang/String;)Lanet/channel/SessionInfo;

    move-result-object v5

    if-eqz v5, :cond_4

    .line 490
    iget-boolean v5, v5, Lanet/channel/SessionInfo;->isAccs:Z

    if-nez v5, :cond_3

    goto :goto_1

    :cond_3
    iget-object v0, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "app background, forbid to create accs session"

    .line 491
    invoke-static {v3, v2, v0, v1}, Lanet/channel/util/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 492
    new-instance v0, Ljava/net/ConnectException;

    const-string v1, "accs session connecting forbidden in background"

    invoke-direct {v0, v1}, Ljava/net/ConnectException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_4
    :goto_1
    iget-object v1, p0, Lanet/channel/SessionCenter;->b:Landroid/content/Context;

    iget-object v3, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    .line 495
    invoke-static {v3}, Lanet/channel/util/i;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    move v2, p2

    move-object v4, p5

    move-wide v5, p3

    invoke-virtual/range {v0 .. v6}, Lanet/channel/SessionRequest;->b(Landroid/content/Context;ILjava/lang/String;Lanet/channel/SessionGetCallback;J)V

    return-void

    .line 466
    :cond_5
    new-instance v0, Ljava/security/InvalidParameterException;

    const-string v1, "sessionGetCallback is null"

    invoke-direct {v0, v1}, Ljava/security/InvalidParameterException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 462
    :cond_6
    new-instance v0, Ljava/security/InvalidParameterException;

    const-string v1, "httpUrl is null"

    invoke-direct {v0, v1}, Ljava/security/InvalidParameterException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_7
    iget-object v0, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "getInternal not inited!"

    .line 457
    invoke-static {v3, v2, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 458
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "getInternal not inited"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public enterBackground()V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 505
    invoke-static {}, Lanet/channel/util/AppLifecycle;->onBackground()V

    return-void
.end method

.method public enterForeground()V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 513
    invoke-static {}, Lanet/channel/util/AppLifecycle;->onForeground()V

    return-void
.end method

.method public forceRecreateAccsSession()V
    .locals 2

    iget-object v0, p0, Lanet/channel/SessionCenter;->h:Lanet/channel/AccsSessionManager;

    const/4 v1, 0x1

    .line 389
    invoke-virtual {v0, v1}, Lanet/channel/AccsSessionManager;->forceCloseSession(Z)V

    return-void
.end method

.method public get(Lanet/channel/util/HttpUrl;IJ)Lanet/channel/Session;
    .locals 10

    const-string v0, "[Get]"

    const-string v1, "url"

    const-string v2, "awcn.SessionCenter"

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v3, p0

    move-object v4, p1

    move v5, p2

    move-wide v6, p3

    .line 318
    :try_start_0
    invoke-virtual/range {v3 .. v8}, Lanet/channel/SessionCenter;->a(Lanet/channel/util/HttpUrl;IJLanet/channel/SessionGetCallback;)Lanet/channel/Session;

    move-result-object v9
    :try_end_0
    .catch Ljava/security/InvalidParameterException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/util/concurrent/TimeoutException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/net/ConnectException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Lanet/channel/NoAvailStrategyException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p2

    .line 332
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    .line 333
    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->urlString()Ljava/lang/String;

    move-result-object p1

    filled-new-array {v1, p1}, [Ljava/lang/Object;

    move-result-object p1

    .line 332
    invoke-static {v2, p2, p3, v9, p1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto :goto_0

    :catch_1
    move-exception p2

    .line 329
    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2}, Lanet/channel/NoAvailStrategyException;->getMessage()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    iget-object p3, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    .line 330
    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->urlString()Ljava/lang/String;

    move-result-object p1

    filled-new-array {v9, v1, p1}, [Ljava/lang/Object;

    move-result-object p1

    .line 329
    invoke-static {v2, p2, p3, p1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :catch_2
    move-exception p2

    iget-object p3, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    .line 326
    invoke-virtual {p2}, Ljava/net/ConnectException;->getMessage()Ljava/lang/String;

    move-result-object p2

    .line 327
    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->urlString()Ljava/lang/String;

    move-result-object p1

    const-string p4, "errMsg"

    filled-new-array {p4, p2, v1, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "[Get]connect exception"

    .line 326
    invoke-static {v2, p2, p3, p1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_0

    :catch_3
    move-exception p2

    iget-object p3, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    .line 324
    invoke-virtual {p1}, Lanet/channel/util/HttpUrl;->urlString()Ljava/lang/String;

    move-result-object p1

    filled-new-array {v1, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p4, "[Get]timeout exception"

    .line 323
    invoke-static {v2, p4, p3, p2, p1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto :goto_0

    :catch_4
    move-exception p2

    iget-object p3, p0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    .line 320
    filled-new-array {v1, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p4, "[Get]param url is invalid"

    invoke-static {v2, p4, p3, p2, p1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    return-object v9
.end method

.method public get(Lanet/channel/util/HttpUrl;Lanet/channel/entity/ConnType$TypeLevel;J)Lanet/channel/Session;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 309
    sget-object v0, Lanet/channel/entity/ConnType$TypeLevel;->SPDY:Lanet/channel/entity/ConnType$TypeLevel;

    if-ne p2, v0, :cond_0

    sget p2, Lanet/channel/entity/c;->a:I

    goto :goto_0

    :cond_0
    sget p2, Lanet/channel/entity/c;->b:I

    :goto_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lanet/channel/SessionCenter;->get(Lanet/channel/util/HttpUrl;IJ)Lanet/channel/Session;

    move-result-object p1

    return-object p1
.end method

.method public get(Ljava/lang/String;J)Lanet/channel/Session;
    .locals 1

    .line 297
    invoke-static {p1}, Lanet/channel/util/HttpUrl;->parse(Ljava/lang/String;)Lanet/channel/util/HttpUrl;

    move-result-object p1

    sget v0, Lanet/channel/entity/c;->c:I

    invoke-virtual {p0, p1, v0, p2, p3}, Lanet/channel/SessionCenter;->get(Lanet/channel/util/HttpUrl;IJ)Lanet/channel/Session;

    move-result-object p1

    return-object p1
.end method

.method public get(Ljava/lang/String;Lanet/channel/entity/ConnType$TypeLevel;J)Lanet/channel/Session;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 302
    invoke-static {p1}, Lanet/channel/util/HttpUrl;->parse(Ljava/lang/String;)Lanet/channel/util/HttpUrl;

    move-result-object p1

    sget-object v0, Lanet/channel/entity/ConnType$TypeLevel;->SPDY:Lanet/channel/entity/ConnType$TypeLevel;

    if-ne p2, v0, :cond_0

    sget p2, Lanet/channel/entity/c;->a:I

    goto :goto_0

    :cond_0
    sget p2, Lanet/channel/entity/c;->b:I

    :goto_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lanet/channel/SessionCenter;->get(Lanet/channel/util/HttpUrl;IJ)Lanet/channel/Session;

    move-result-object p1

    return-object p1
.end method

.method public getThrowsException(Lanet/channel/util/HttpUrl;IJ)Lanet/channel/Session;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move-wide v3, p3

    .line 278
    invoke-virtual/range {v0 .. v5}, Lanet/channel/SessionCenter;->a(Lanet/channel/util/HttpUrl;IJLanet/channel/SessionGetCallback;)Lanet/channel/Session;

    move-result-object p1

    return-object p1
.end method

.method public getThrowsException(Lanet/channel/util/HttpUrl;Lanet/channel/entity/ConnType$TypeLevel;J)Lanet/channel/Session;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 283
    sget-object v0, Lanet/channel/entity/ConnType$TypeLevel;->SPDY:Lanet/channel/entity/ConnType$TypeLevel;

    if-ne p2, v0, :cond_0

    sget p2, Lanet/channel/entity/c;->a:I

    goto :goto_0

    :cond_0
    sget p2, Lanet/channel/entity/c;->b:I

    :goto_0
    move v2, p2

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-wide v3, p3

    invoke-virtual/range {v0 .. v5}, Lanet/channel/SessionCenter;->a(Lanet/channel/util/HttpUrl;IJLanet/channel/SessionGetCallback;)Lanet/channel/Session;

    move-result-object p1

    return-object p1
.end method

.method public getThrowsException(Ljava/lang/String;J)Lanet/channel/Session;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 266
    invoke-static {p1}, Lanet/channel/util/HttpUrl;->parse(Ljava/lang/String;)Lanet/channel/util/HttpUrl;

    move-result-object v1

    sget v2, Lanet/channel/entity/c;->c:I

    const/4 v5, 0x0

    move-object v0, p0

    move-wide v3, p2

    invoke-virtual/range {v0 .. v5}, Lanet/channel/SessionCenter;->a(Lanet/channel/util/HttpUrl;IJLanet/channel/SessionGetCallback;)Lanet/channel/Session;

    move-result-object p1

    return-object p1
.end method

.method public getThrowsException(Ljava/lang/String;Lanet/channel/entity/ConnType$TypeLevel;J)Lanet/channel/Session;
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 271
    invoke-static {p1}, Lanet/channel/util/HttpUrl;->parse(Ljava/lang/String;)Lanet/channel/util/HttpUrl;

    move-result-object v1

    sget-object p1, Lanet/channel/entity/ConnType$TypeLevel;->SPDY:Lanet/channel/entity/ConnType$TypeLevel;

    if-ne p2, p1, :cond_0

    sget p1, Lanet/channel/entity/c;->a:I

    goto :goto_0

    :cond_0
    sget p1, Lanet/channel/entity/c;->b:I

    :goto_0
    move v2, p1

    const/4 v5, 0x0

    move-object v0, p0

    move-wide v3, p3

    invoke-virtual/range {v0 .. v5}, Lanet/channel/SessionCenter;->a(Lanet/channel/util/HttpUrl;IJLanet/channel/SessionGetCallback;)Lanet/channel/Session;

    move-result-object p1

    return-object p1
.end method

.method public registerAccsSessionListener(Lanet/channel/ISessionListener;)V
    .locals 1

    iget-object v0, p0, Lanet/channel/SessionCenter;->h:Lanet/channel/AccsSessionManager;

    .line 371
    invoke-virtual {v0, p1}, Lanet/channel/AccsSessionManager;->registerListener(Lanet/channel/ISessionListener;)V

    return-void
.end method

.method public registerPublicKey(Ljava/lang/String;I)V
    .locals 1

    iget-object v0, p0, Lanet/channel/SessionCenter;->g:Lanet/channel/c;

    .line 379
    invoke-virtual {v0, p1, p2}, Lanet/channel/c;->a(Ljava/lang/String;I)V

    return-void
.end method

.method public registerSessionInfo(Lanet/channel/SessionInfo;)V
    .locals 1

    iget-object v0, p0, Lanet/channel/SessionCenter;->g:Lanet/channel/c;

    .line 357
    invoke-virtual {v0, p1}, Lanet/channel/c;->a(Lanet/channel/SessionInfo;)V

    .line 358
    iget-boolean p1, p1, Lanet/channel/SessionInfo;->isKeepAlive:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lanet/channel/SessionCenter;->h:Lanet/channel/AccsSessionManager;

    .line 359
    invoke-virtual {p1}, Lanet/channel/AccsSessionManager;->checkAndStartSession()V

    :cond_0
    return-void
.end method

.method public declared-synchronized switchEnv(Lanet/channel/entity/ENV;)V
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    monitor-enter p0

    .line 167
    :try_start_0
    invoke-static {p1}, Lanet/channel/SessionCenter;->switchEnvironment(Lanet/channel/entity/ENV;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 168
    monitor-exit p0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public unregisterAccsSessionListener(Lanet/channel/ISessionListener;)V
    .locals 1

    iget-object v0, p0, Lanet/channel/SessionCenter;->h:Lanet/channel/AccsSessionManager;

    .line 375
    invoke-virtual {v0, p1}, Lanet/channel/AccsSessionManager;->unregisterListener(Lanet/channel/ISessionListener;)V

    return-void
.end method

.method public unregisterSessionInfo(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lanet/channel/SessionCenter;->g:Lanet/channel/c;

    .line 364
    invoke-virtual {v0, p1}, Lanet/channel/c;->a(Ljava/lang/String;)Lanet/channel/SessionInfo;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 365
    iget-boolean p1, p1, Lanet/channel/SessionInfo;->isKeepAlive:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lanet/channel/SessionCenter;->h:Lanet/channel/AccsSessionManager;

    .line 366
    invoke-virtual {p1}, Lanet/channel/AccsSessionManager;->checkAndStartSession()V

    :cond_0
    return-void
.end method
