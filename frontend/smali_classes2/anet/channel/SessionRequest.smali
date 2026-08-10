.class Lanet/channel/SessionRequest;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanet/channel/SessionRequest$IConnCb;,
        Lanet/channel/SessionRequest$a;,
        Lanet/channel/SessionRequest$c;,
        Lanet/channel/SessionRequest$b;
    }
.end annotation


# instance fields
.field a:Lanet/channel/SessionCenter;

.field b:Lanet/channel/e;

.field c:Lanet/channel/SessionInfo;

.field volatile d:Z

.field volatile e:Lanet/channel/Session;

.field volatile f:Z

.field g:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Lanet/channel/SessionGetCallback;",
            "Lanet/channel/SessionRequest$c;",
            ">;"
        }
    .end annotation
.end field

.field h:Lanet/channel/statist/SessionConnStat;

.field private i:Ljava/lang/String;

.field private j:Ljava/lang/String;

.field private volatile k:Ljava/util/concurrent/Future;

.field private l:Ljava/lang/Object;


# direct methods
.method constructor <init>(Ljava/lang/String;Lanet/channel/SessionCenter;)V
    .locals 1

    .line 78
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lanet/channel/SessionRequest;->d:Z

    iput-boolean v0, p0, Lanet/channel/SessionRequest;->f:Z

    .line 72
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    const/4 v0, 0x0

    iput-object v0, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 76
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lanet/channel/SessionRequest;->l:Ljava/lang/Object;

    iput-object p1, p0, Lanet/channel/SessionRequest;->i:Ljava/lang/String;

    const-string v0, "://"

    .line 80
    invoke-virtual {p1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v0

    add-int/lit8 v0, v0, 0x3

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lanet/channel/SessionRequest;->j:Ljava/lang/String;

    iput-object p2, p0, Lanet/channel/SessionRequest;->a:Lanet/channel/SessionCenter;

    .line 82
    iget-object p1, p2, Lanet/channel/SessionCenter;->g:Lanet/channel/c;

    iget-object v0, p0, Lanet/channel/SessionRequest;->j:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lanet/channel/c;->b(Ljava/lang/String;)Lanet/channel/SessionInfo;

    move-result-object p1

    iput-object p1, p0, Lanet/channel/SessionRequest;->c:Lanet/channel/SessionInfo;

    .line 83
    iget-object p1, p2, Lanet/channel/SessionCenter;->e:Lanet/channel/e;

    iput-object p1, p0, Lanet/channel/SessionRequest;->b:Lanet/channel/e;

    return-void
.end method

.method private a(ILjava/lang/String;)Ljava/util/List;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lanet/channel/strategy/IConnStrategy;",
            ">;"
        }
    .end annotation

    const-string v0, "awcn.SessionRequest"

    .line 490
    sget-object v1, Ljava/util/Collections;->EMPTY_LIST:Ljava/util/List;

    const/4 v2, 0x0

    .line 492
    :try_start_0
    invoke-virtual {p0}, Lanet/channel/SessionRequest;->a()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lanet/channel/util/HttpUrl;->parse(Ljava/lang/String;)Lanet/channel/util/HttpUrl;

    move-result-object v3

    if-nez v3, :cond_0

    .line 494
    sget-object p1, Ljava/util/Collections;->EMPTY_LIST:Ljava/util/List;

    return-object p1

    .line 497
    :cond_0
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object v4

    invoke-virtual {v3}, Lanet/channel/util/HttpUrl;->host()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v4, v5}, Lanet/channel/strategy/IStrategyInstance;->getConnStrategyListByHost(Ljava/lang/String;)Ljava/util/List;

    move-result-object v1

    .line 499
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_5

    const-string v4, "https"

    .line 500
    invoke-virtual {v3}, Lanet/channel/util/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v4, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    .line 501
    invoke-static {}, Lanet/channel/util/c;->b()Z

    move-result v4

    .line 502
    invoke-interface {v1}, Ljava/util/List;->listIterator()Ljava/util/ListIterator;

    move-result-object v5

    .line 503
    :cond_1
    :goto_0
    invoke-interface {v5}, Ljava/util/ListIterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_5

    .line 504
    invoke-interface {v5}, Ljava/util/ListIterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lanet/channel/strategy/IConnStrategy;

    .line 505
    invoke-interface {v6}, Lanet/channel/strategy/IConnStrategy;->getProtocol()Lanet/channel/strategy/ConnProtocol;

    move-result-object v7

    invoke-static {v7}, Lanet/channel/entity/ConnType;->valueOf(Lanet/channel/strategy/ConnProtocol;)Lanet/channel/entity/ConnType;

    move-result-object v7

    if-nez v7, :cond_2

    goto :goto_0

    .line 513
    :cond_2
    invoke-virtual {v7}, Lanet/channel/entity/ConnType;->isSSL()Z

    move-result v8

    if-ne v8, v3, :cond_4

    sget v8, Lanet/channel/entity/c;->c:I

    if-eq p1, v8, :cond_3

    .line 514
    invoke-virtual {v7}, Lanet/channel/entity/ConnType;->getType()I

    move-result v7

    if-eq v7, p1, :cond_3

    goto :goto_1

    :cond_3
    if-eqz v4, :cond_1

    .line 516
    invoke-interface {v6}, Lanet/channel/strategy/IConnStrategy;->getIp()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lanet/channel/strategy/utils/c;->b(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_1

    .line 518
    invoke-interface {v5}, Ljava/util/ListIterator;->remove()V

    goto :goto_0

    .line 515
    :cond_4
    :goto_1
    invoke-interface {v5}, Ljava/util/ListIterator;->remove()V

    goto :goto_0

    :cond_5
    const/4 p1, 0x1

    .line 524
    invoke-static {p1}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v3

    if-eqz v3, :cond_6

    const-string v3, "[getAvailStrategy]"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const-string v5, "strategies"

    aput-object v5, v4, v2

    aput-object v1, v4, p1

    .line 525
    invoke-static {v0, v3, p2, v4}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception p1

    const-string v3, ""

    new-array v2, v2, [Ljava/lang/Object;

    .line 529
    invoke-static {v0, v3, p2, p1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_6
    :goto_2
    return-object v1
.end method

.method private a(Ljava/util/List;Ljava/lang/String;)Ljava/util/List;
    .locals 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lanet/channel/strategy/IConnStrategy;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lanet/channel/entity/a;",
            ">;"
        }
    .end annotation

    .line 536
    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 537
    sget-object p1, Ljava/util/Collections;->EMPTY_LIST:Ljava/util/List;

    return-object p1

    .line 539
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const/4 v1, 0x0

    move v2, v1

    move v3, v2

    .line 541
    :goto_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v4

    if-ge v2, v4, :cond_2

    .line 542
    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lanet/channel/strategy/IConnStrategy;

    .line 543
    invoke-interface {v4}, Lanet/channel/strategy/IConnStrategy;->getRetryTimes()I

    move-result v5

    move v6, v1

    :goto_1
    if-gt v6, v5, :cond_1

    add-int/lit8 v3, v3, 0x1

    .line 546
    new-instance v7, Lanet/channel/entity/a;

    invoke-virtual {p0}, Lanet/channel/SessionRequest;->a()Ljava/lang/String;

    move-result-object v8

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v9, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    const-string v10, "_"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v7, v8, v9, v4}, Lanet/channel/entity/a;-><init>(Ljava/lang/String;Ljava/lang/String;Lanet/channel/strategy/IConnStrategy;)V

    .line 547
    iput v6, v7, Lanet/channel/entity/a;->b:I

    .line 548
    iput v5, v7, Lanet/channel/entity/a;->c:I

    .line 549
    invoke-interface {v0, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    return-object v0
.end method

.method private a(Landroid/content/Context;Lanet/channel/entity/a;Lanet/channel/SessionRequest$IConnCb;Ljava/lang/String;)V
    .locals 16

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    .line 556
    invoke-virtual/range {p2 .. p2}, Lanet/channel/entity/a;->c()Lanet/channel/entity/ConnType;

    move-result-object v3

    if-eqz v1, :cond_0

    .line 557
    invoke-virtual {v3}, Lanet/channel/entity/ConnType;->isHttpType()Z

    move-result v3

    if-nez v3, :cond_0

    .line 558
    new-instance v3, Lanet/channel/session/TnetSpdySession;

    invoke-direct {v3, v1, v2}, Lanet/channel/session/TnetSpdySession;-><init>(Landroid/content/Context;Lanet/channel/entity/a;)V

    iget-object v1, v0, Lanet/channel/SessionRequest;->a:Lanet/channel/SessionCenter;

    .line 559
    iget-object v1, v1, Lanet/channel/SessionCenter;->d:Lanet/channel/Config;

    invoke-virtual {v3, v1}, Lanet/channel/session/TnetSpdySession;->initConfig(Lanet/channel/Config;)V

    iget-object v1, v0, Lanet/channel/SessionRequest;->c:Lanet/channel/SessionInfo;

    .line 560
    invoke-virtual {v3, v1}, Lanet/channel/session/TnetSpdySession;->initSessionInfo(Lanet/channel/SessionInfo;)V

    iget-object v1, v0, Lanet/channel/SessionRequest;->a:Lanet/channel/SessionCenter;

    .line 561
    iget-object v1, v1, Lanet/channel/SessionCenter;->g:Lanet/channel/c;

    iget-object v4, v0, Lanet/channel/SessionRequest;->j:Ljava/lang/String;

    invoke-virtual {v1, v4}, Lanet/channel/c;->c(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v3, v1}, Lanet/channel/session/TnetSpdySession;->setTnetPublicKey(I)V

    iput-object v3, v0, Lanet/channel/SessionRequest;->e:Lanet/channel/Session;

    goto :goto_0

    .line 564
    :cond_0
    new-instance v3, Lanet/channel/session/d;

    invoke-direct {v3, v1, v2}, Lanet/channel/session/d;-><init>(Landroid/content/Context;Lanet/channel/entity/a;)V

    iput-object v3, v0, Lanet/channel/SessionRequest;->e:Lanet/channel/Session;

    :goto_0
    const-string v4, "Host"

    .line 566
    invoke-virtual/range {p0 .. p0}, Lanet/channel/SessionRequest;->a()Ljava/lang/String;

    move-result-object v5

    const-string v6, "Type"

    invoke-virtual/range {p2 .. p2}, Lanet/channel/entity/a;->c()Lanet/channel/entity/ConnType;

    move-result-object v7

    const-string v8, "IP"

    invoke-virtual/range {p2 .. p2}, Lanet/channel/entity/a;->a()Ljava/lang/String;

    move-result-object v9

    const-string v10, "Port"

    invoke-virtual/range {p2 .. p2}, Lanet/channel/entity/a;->b()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    const-string v12, "heartbeat"

    invoke-virtual/range {p2 .. p2}, Lanet/channel/entity/a;->g()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v13

    const-string v14, "session"

    iget-object v15, v0, Lanet/channel/SessionRequest;->e:Lanet/channel/Session;

    filled-new-array/range {v4 .. v15}, [Ljava/lang/Object;

    move-result-object v1

    const-string v3, "awcn.SessionRequest"

    const-string v4, "create connection..."

    move-object/from16 v5, p4

    invoke-static {v3, v4, v5, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v1, v0, Lanet/channel/SessionRequest;->e:Lanet/channel/Session;

    .line 567
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    move-object/from16 v5, p3

    invoke-direct {v0, v1, v5, v3, v4}, Lanet/channel/SessionRequest;->a(Lanet/channel/Session;Lanet/channel/SessionRequest$IConnCb;J)V

    iget-object v1, v0, Lanet/channel/SessionRequest;->e:Lanet/channel/Session;

    .line 568
    invoke-virtual {v1}, Lanet/channel/Session;->connect()V

    iget-object v1, v0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 570
    iget v3, v1, Lanet/channel/statist/SessionConnStat;->retryTimes:I

    add-int/lit8 v3, v3, 0x1

    iput v3, v1, Lanet/channel/statist/SessionConnStat;->retryTimes:I

    iget-object v1, v0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 571
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iput-wide v3, v1, Lanet/channel/statist/SessionConnStat;->startConnect:J

    iget-object v1, v0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 572
    iget v1, v1, Lanet/channel/statist/SessionConnStat;->retryTimes:I

    if-nez v1, :cond_1

    iget-object v1, v0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    const-string v3, "firstIp"

    .line 573
    invoke-virtual/range {p2 .. p2}, Lanet/channel/entity/a;->a()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v3, v2}, Lanet/channel/statist/SessionConnStat;->putExtra(Ljava/lang/String;Ljava/lang/Object;)V

    :cond_1
    return-void
.end method

.method private a(Lanet/channel/Session;Lanet/channel/SessionRequest$IConnCb;J)V
    .locals 1

    if-nez p2, :cond_0

    return-void

    .line 581
    :cond_0
    new-instance v0, Lanet/channel/f;

    invoke-direct {v0, p0, p2, p3, p4}, Lanet/channel/f;-><init>(Lanet/channel/SessionRequest;Lanet/channel/SessionRequest$IConnCb;J)V

    const/16 p2, 0xfff

    invoke-virtual {p1, p2, v0}, Lanet/channel/Session;->registerEventcb(ILanet/channel/entity/EventCb;)V

    .line 615
    new-instance p2, Lanet/channel/g;

    invoke-direct {p2, p0, p1}, Lanet/channel/g;-><init>(Lanet/channel/SessionRequest;Lanet/channel/Session;)V

    const/16 p3, 0x700

    invoke-virtual {p1, p3, p2}, Lanet/channel/Session;->registerEventcb(ILanet/channel/entity/EventCb;)V

    return-void
.end method

.method static synthetic a(Lanet/channel/SessionRequest;Landroid/content/Context;Lanet/channel/entity/a;Lanet/channel/SessionRequest$IConnCb;Ljava/lang/String;)V
    .locals 0

    .line 60
    invoke-direct {p0, p1, p2, p3, p4}, Lanet/channel/SessionRequest;->a(Landroid/content/Context;Lanet/channel/entity/a;Lanet/channel/SessionRequest$IConnCb;Ljava/lang/String;)V

    return-void
.end method

.method private b(Lanet/channel/Session;ILjava/lang/String;)V
    .locals 8

    .line 720
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v1, p0, Lanet/channel/SessionRequest;->c:Lanet/channel/SessionInfo;

    if-eqz v1, :cond_3

    .line 725
    iget-boolean v1, v1, Lanet/channel/SessionInfo;->isAccs:Z

    if-nez v1, :cond_1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    const-string v3, "awcn.SessionRequest"

    const-string v4, "sendConnectInfoToAccsByService"

    const/4 v5, 0x0

    .line 728
    invoke-static {v3, v4, v5, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 732
    :try_start_0
    new-instance v2, Landroid/content/Intent;

    const-string v6, "com.taobao.accs.intent.action.RECEIVE"

    invoke-direct {v2, v6}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 733
    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    const-string v6, "com.taobao.accs.data.MsgDistributeService"

    .line 734
    invoke-virtual {v2, v0, v6}, Landroid/content/Intent;->setClassName(Landroid/content/Context;Ljava/lang/String;)Landroid/content/Intent;

    const-string v6, "command"

    const/16 v7, 0x67

    .line 735
    invoke-virtual {v2, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v6, "host"

    .line 736
    invoke-virtual {p1}, Lanet/channel/Session;->getHost()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v2, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v6, "is_center_host"

    const/4 v7, 0x1

    .line 737
    invoke-virtual {v2, v6, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 739
    invoke-virtual {p1}, Lanet/channel/Session;->isAvailable()Z

    move-result p1

    if-nez p1, :cond_2

    const-string v6, "errorCode"

    .line 741
    invoke-virtual {v2, v6, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string p2, "errorDetail"

    .line 742
    invoke-virtual {v2, p2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_2
    const-string p2, "connect_avail"

    .line 744
    invoke-virtual {v2, p2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string p1, "type_inapp"

    .line 745
    invoke-virtual {v2, p1, v7}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 748
    new-instance p1, Lanet/channel/h;

    invoke-direct {p1, p0, v2, v0}, Lanet/channel/h;-><init>(Lanet/channel/SessionRequest;Landroid/content/Intent;Landroid/content/Context;)V

    invoke-virtual {v0, v2, p1, v7}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    new-array p2, v1, [Ljava/lang/Object;

    .line 774
    invoke-static {v3, v4, v5, p1, p2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_3
    :goto_0
    return-void
.end method

.method private c(Lanet/channel/Session;ILjava/lang/String;)V
    .locals 4

    iget-object v0, p0, Lanet/channel/SessionRequest;->c:Lanet/channel/SessionInfo;

    if-eqz v0, :cond_2

    .line 779
    iget-boolean v0, v0, Lanet/channel/SessionInfo;->isAccs:Z

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "awcn.SessionRequest"

    const-string v2, "sendConnectInfoToAccsByCallBack"

    const/4 v3, 0x0

    .line 783
    invoke-static {v1, v2, v3, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 784
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.taobao.ACCS_CONNECT_INFO"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const-string v1, "command"

    const/16 v2, 0x67

    .line 785
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string v1, "host"

    .line 786
    invoke-virtual {p1}, Lanet/channel/Session;->getHost()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "is_center_host"

    const/4 v2, 0x1

    .line 787
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 789
    invoke-virtual {p1}, Lanet/channel/Session;->isAvailable()Z

    move-result p1

    if-nez p1, :cond_1

    const-string v1, "errorCode"

    .line 791
    invoke-virtual {v0, v1, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string p2, "errorDetail"

    .line 792
    invoke-virtual {v0, p2, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_1
    const-string p2, "connect_avail"

    .line 794
    invoke-virtual {v0, p2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string p1, "type_inapp"

    .line 795
    invoke-virtual {v0, p1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    iget-object p1, p0, Lanet/channel/SessionRequest;->a:Lanet/channel/SessionCenter;

    .line 797
    iget-object p1, p1, Lanet/channel/SessionCenter;->h:Lanet/channel/AccsSessionManager;

    invoke-virtual {p1, v0}, Lanet/channel/AccsSessionManager;->notifyListener(Landroid/content/Intent;)V

    :cond_2
    :goto_0
    return-void
.end method


# virtual methods
.method protected a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lanet/channel/SessionRequest;->i:Ljava/lang/String;

    return-object v0
.end method

.method protected a(J)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/InterruptedException;,
            Ljava/util/concurrent/TimeoutException;
        }
    .end annotation

    const-string v0, "awcn.SessionRequest"

    const-string v1, "[await]"

    const-string v2, "timeoutMs"

    .line 675
    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    const/4 v3, 0x0

    invoke-static {v0, v1, v3, v2}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-wide/16 v0, 0x0

    cmp-long v0, p1, v0

    if-gtz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lanet/channel/SessionRequest;->l:Ljava/lang/Object;

    .line 680
    monitor-enter v0

    .line 681
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    add-long/2addr v1, p1

    :goto_0
    iget-boolean p1, p0, Lanet/channel/SessionRequest;->d:Z

    if-eqz p1, :cond_2

    .line 683
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    cmp-long v3, p1, v1

    if-ltz v3, :cond_1

    goto :goto_1

    :cond_1
    iget-object v3, p0, Lanet/channel/SessionRequest;->l:Ljava/lang/Object;

    sub-long p1, v1, p1

    .line 687
    invoke-virtual {v3, p1, p2}, Ljava/lang/Object;->wait(J)V

    goto :goto_0

    :cond_2
    :goto_1
    iget-boolean p1, p0, Lanet/channel/SessionRequest;->d:Z

    if-nez p1, :cond_3

    .line 694
    monitor-exit v0

    return-void

    .line 692
    :cond_3
    new-instance p1, Ljava/util/concurrent/TimeoutException;

    invoke-direct {p1}, Ljava/util/concurrent/TimeoutException;-><init>()V

    throw p1

    :catchall_0
    move-exception p1

    .line 694
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method protected declared-synchronized a(Landroid/content/Context;ILjava/lang/String;Lanet/channel/SessionGetCallback;J)V
    .locals 9

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lanet/channel/SessionRequest;->b:Lanet/channel/e;

    .line 156
    invoke-virtual {v0, p0, p2}, Lanet/channel/e;->a(Lanet/channel/SessionRequest;I)Lanet/channel/Session;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    const-string p1, "awcn.SessionRequest"

    const-string p2, "Available Session exist!!!"

    new-array p5, v1, [Ljava/lang/Object;

    .line 158
    invoke-static {p1, p2, p3, p5}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-eqz p4, :cond_0

    .line 160
    invoke-interface {p4, v0}, Lanet/channel/SessionGetCallback;->onSessionGetSuccess(Lanet/channel/Session;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    .line 162
    :cond_0
    monitor-exit p0

    return-void

    .line 165
    :cond_1
    :try_start_1
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 p3, 0x0

    .line 166
    invoke-static {p3}, Lanet/channel/util/i;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    :cond_2
    const-string v0, "awcn.SessionRequest"

    const-string v2, "SessionRequest start"

    const/4 v3, 0x4

    new-array v4, v3, [Ljava/lang/Object;

    const-string v5, "host"

    aput-object v5, v4, v1

    iget-object v5, p0, Lanet/channel/SessionRequest;->i:Ljava/lang/String;

    const/4 v6, 0x1

    aput-object v5, v4, v6

    const-string v5, "type"

    const/4 v7, 0x2

    aput-object v5, v4, v7

    .line 168
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    const/4 v8, 0x3

    aput-object v5, v4, v8

    invoke-static {v0, v2, p3, v4}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-boolean v0, p0, Lanet/channel/SessionRequest;->d:Z

    if-eqz v0, :cond_5

    const-string p1, "awcn.SessionRequest"

    const-string v0, "session connecting"

    new-array v2, v7, [Ljava/lang/Object;

    const-string v3, "host"

    aput-object v3, v2, v1

    .line 170
    invoke-virtual {p0}, Lanet/channel/SessionRequest;->a()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v2, v6

    invoke-static {p1, v0, p3, v2}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-eqz p4, :cond_4

    .line 172
    invoke-virtual {p0}, Lanet/channel/SessionRequest;->b()I

    move-result p1

    if-ne p1, p2, :cond_3

    .line 173
    new-instance p1, Lanet/channel/SessionRequest$c;

    invoke-direct {p1, p0, p4}, Lanet/channel/SessionRequest$c;-><init>(Lanet/channel/SessionRequest;Lanet/channel/SessionGetCallback;)V

    iget-object p2, p0, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 174
    monitor-enter p2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    :try_start_2
    iget-object p3, p0, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 175
    invoke-virtual {p3, p4, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 176
    monitor-exit p2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 177
    :try_start_3
    sget-object p2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {p1, p5, p6, p2}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 176
    :try_start_4
    monitor-exit p2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    throw p1

    .line 179
    :cond_3
    invoke-interface {p4}, Lanet/channel/SessionGetCallback;->onSessionGetFail()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    .line 182
    :cond_4
    :goto_0
    monitor-exit p0

    return-void

    .line 184
    :cond_5
    :try_start_6
    invoke-virtual {p0, v6}, Lanet/channel/SessionRequest;->a(Z)V

    .line 185
    new-instance v0, Lanet/channel/SessionRequest$b;

    invoke-direct {v0, p0, p3}, Lanet/channel/SessionRequest$b;-><init>(Lanet/channel/SessionRequest;Ljava/lang/String;)V

    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v4, 0x2d

    invoke-static {v0, v4, v5, v2}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/SessionRequest;->k:Ljava/util/concurrent/Future;

    .line 186
    new-instance v0, Lanet/channel/statist/SessionConnStat;

    invoke-direct {v0}, Lanet/channel/statist/SessionConnStat;-><init>()V

    iput-object v0, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 187
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iput-wide v4, v0, Lanet/channel/statist/SessionConnStat;->start:J

    .line 189
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->isConnected()Z

    move-result v0

    if-nez v0, :cond_7

    .line 190
    invoke-static {v6}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result p1

    if-eqz p1, :cond_6

    const-string p1, "awcn.SessionRequest"

    const-string p2, "network is not available, can\'t create session"

    new-array p4, v7, [Ljava/lang/Object;

    const-string p5, "isConnected"

    aput-object p5, p4, v1

    .line 191
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->isConnected()Z

    move-result p5

    invoke-static {p5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p5

    aput-object p5, p4, v6

    invoke-static {p1, p2, p3, p4}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 193
    :cond_6
    invoke-virtual {p0}, Lanet/channel/SessionRequest;->c()V

    .line 194
    new-instance p1, Ljava/lang/RuntimeException;

    const-string p2, "no network"

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 196
    :cond_7
    invoke-direct {p0, p2, p3}, Lanet/channel/SessionRequest;->a(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    .line 198
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_9

    .line 204
    invoke-direct {p0, v0, p3}, Lanet/channel/SessionRequest;->a(Ljava/util/List;Ljava/lang/String;)Ljava/util/List;

    move-result-object p2
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 207
    :try_start_7
    invoke-interface {p2, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lanet/channel/entity/a;

    .line 208
    new-instance v0, Lanet/channel/SessionRequest$a;

    invoke-direct {v0, p0, p1, p2, p3}, Lanet/channel/SessionRequest$a;-><init>(Lanet/channel/SessionRequest;Landroid/content/Context;Ljava/util/List;Lanet/channel/entity/a;)V

    invoke-virtual {p3}, Lanet/channel/entity/a;->h()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p0, p1, p3, v0, p2}, Lanet/channel/SessionRequest;->a(Landroid/content/Context;Lanet/channel/entity/a;Lanet/channel/SessionRequest$IConnCb;Ljava/lang/String;)V

    if-eqz p4, :cond_8

    .line 210
    new-instance p1, Lanet/channel/SessionRequest$c;

    invoke-direct {p1, p0, p4}, Lanet/channel/SessionRequest$c;-><init>(Lanet/channel/SessionRequest;Lanet/channel/SessionGetCallback;)V

    iget-object p2, p0, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 211
    monitor-enter p2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    :try_start_8
    iget-object p3, p0, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 212
    invoke-virtual {p3, p4, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 213
    monitor-exit p2
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    .line 214
    :try_start_9
    sget-object p2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {p1, p5, p6, p2}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    goto :goto_1

    :catchall_1
    move-exception p1

    .line 213
    :try_start_a
    monitor-exit p2
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    :try_start_b
    throw p1
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    .line 217
    :catchall_2
    :try_start_c
    invoke-virtual {p0}, Lanet/channel/SessionRequest;->c()V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_3

    .line 219
    :cond_8
    :goto_1
    monitor-exit p0

    return-void

    :cond_9
    :try_start_d
    const-string p1, "awcn.SessionRequest"

    const-string p4, "no avalible strategy, can\'t create session"

    new-array p5, v3, [Ljava/lang/Object;

    const-string p6, "host"

    aput-object p6, p5, v1

    iget-object p6, p0, Lanet/channel/SessionRequest;->i:Ljava/lang/String;

    aput-object p6, p5, v6

    const-string p6, "type"

    aput-object p6, p5, v7

    .line 199
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    aput-object p2, p5, v8

    invoke-static {p1, p4, p3, p5}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 200
    invoke-virtual {p0}, Lanet/channel/SessionRequest;->c()V

    .line 201
    new-instance p1, Lanet/channel/NoAvailStrategyException;

    const-string p2, "no avalible strategy"

    invoke-direct {p1, p2}, Lanet/channel/NoAvailStrategyException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_3

    :catchall_3
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method a(Lanet/channel/Session;)V
    .locals 4

    .line 452
    new-instance v0, Lanet/channel/statist/AlarmObject;

    invoke-direct {v0}, Lanet/channel/statist/AlarmObject;-><init>()V

    const-string v1, "networkPrefer"

    .line 453
    iput-object v1, v0, Lanet/channel/statist/AlarmObject;->module:Ljava/lang/String;

    const-string v1, "policy"

    .line 454
    iput-object v1, v0, Lanet/channel/statist/AlarmObject;->modulePoint:Ljava/lang/String;

    iget-object v1, p0, Lanet/channel/SessionRequest;->i:Ljava/lang/String;

    .line 455
    iput-object v1, v0, Lanet/channel/statist/AlarmObject;->arg:Ljava/lang/String;

    const/4 v1, 0x1

    .line 456
    iput-boolean v1, v0, Lanet/channel/statist/AlarmObject;->isSuccess:Z

    .line 457
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v2

    invoke-interface {v2, v0}, Lanet/channel/appmonitor/IAppMonitor;->commitAlarm(Lanet/channel/statist/AlarmObject;)V

    iget-object v0, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 460
    invoke-virtual {v0, p1}, Lanet/channel/statist/SessionConnStat;->syncValueFromSession(Lanet/channel/Session;)V

    iget-object p1, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 461
    iput v1, p1, Lanet/channel/statist/SessionConnStat;->ret:I

    iget-object p1, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 462
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object v2, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    iget-wide v2, v2, Lanet/channel/statist/SessionConnStat;->start:J

    sub-long/2addr v0, v2

    iput-wide v0, p1, Lanet/channel/statist/SessionConnStat;->totalTime:J

    .line 463
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    iget-object v0, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    invoke-interface {p1, v0}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    return-void
.end method

.method a(Lanet/channel/Session;II)V
    .locals 4

    const/16 v0, 0x100

    if-ne v0, p2, :cond_0

    const/16 p2, -0xa35

    if-eq p3, p2, :cond_0

    const/16 p2, -0xa29

    if-eq p3, p2, :cond_0

    .line 470
    new-instance p2, Lanet/channel/statist/AlarmObject;

    invoke-direct {p2}, Lanet/channel/statist/AlarmObject;-><init>()V

    const-string v0, "networkPrefer"

    .line 471
    iput-object v0, p2, Lanet/channel/statist/AlarmObject;->module:Ljava/lang/String;

    const-string v0, "policy"

    .line 472
    iput-object v0, p2, Lanet/channel/statist/AlarmObject;->modulePoint:Ljava/lang/String;

    iget-object v0, p0, Lanet/channel/SessionRequest;->i:Ljava/lang/String;

    .line 473
    iput-object v0, p2, Lanet/channel/statist/AlarmObject;->arg:Ljava/lang/String;

    .line 474
    invoke-static {p3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p2, Lanet/channel/statist/AlarmObject;->errorCode:Ljava/lang/String;

    const/4 v0, 0x0

    .line 475
    iput-boolean v0, p2, Lanet/channel/statist/AlarmObject;->isSuccess:Z

    .line 476
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v1

    invoke-interface {v1, p2}, Lanet/channel/appmonitor/IAppMonitor;->commitAlarm(Lanet/channel/statist/AlarmObject;)V

    iget-object p2, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 480
    iput v0, p2, Lanet/channel/statist/SessionConnStat;->ret:I

    iget-object p2, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 481
    invoke-virtual {p2, p3}, Lanet/channel/statist/SessionConnStat;->appendErrorTrace(I)V

    iget-object p2, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 482
    invoke-static {p3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p3

    iput-object p3, p2, Lanet/channel/statist/SessionConnStat;->errorCode:Ljava/lang/String;

    iget-object p2, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 483
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object p3, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    iget-wide v2, p3, Lanet/channel/statist/SessionConnStat;->start:J

    sub-long/2addr v0, v2

    iput-wide v0, p2, Lanet/channel/statist/SessionConnStat;->totalTime:J

    iget-object p2, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 484
    invoke-virtual {p2, p1}, Lanet/channel/statist/SessionConnStat;->syncValueFromSession(Lanet/channel/Session;)V

    .line 485
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    iget-object p2, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    invoke-interface {p1, p2}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    :cond_0
    return-void
.end method

.method a(Lanet/channel/Session;ILjava/lang/String;)V
    .locals 1

    .line 713
    invoke-static {}, Lanet/channel/AwcnConfig;->isSendConnectInfoByService()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 714
    invoke-direct {p0, p1, p2, p3}, Lanet/channel/SessionRequest;->b(Lanet/channel/Session;ILjava/lang/String;)V

    .line 716
    :cond_0
    invoke-direct {p0, p1, p2, p3}, Lanet/channel/SessionRequest;->c(Lanet/channel/Session;ILjava/lang/String;)V

    return-void
.end method

.method protected a(Ljava/lang/String;)V
    .locals 3

    const-string v0, "host"

    iget-object v1, p0, Lanet/channel/SessionRequest;->i:Ljava/lang/String;

    .line 655
    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "awcn.SessionRequest"

    const-string v2, "reCreateSession"

    invoke-static {v1, v2, p1, v0}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 p1, 0x1

    .line 656
    invoke-virtual {p0, p1}, Lanet/channel/SessionRequest;->b(Z)V

    return-void
.end method

.method a(Z)V
    .locals 2

    iput-boolean p1, p0, Lanet/channel/SessionRequest;->d:Z

    if-nez p1, :cond_1

    iget-object p1, p0, Lanet/channel/SessionRequest;->k:Ljava/util/concurrent/Future;

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    iget-object p1, p0, Lanet/channel/SessionRequest;->k:Ljava/util/concurrent/Future;

    const/4 v1, 0x1

    .line 94
    invoke-interface {p1, v1}, Ljava/util/concurrent/Future;->cancel(Z)Z

    iput-object v0, p0, Lanet/channel/SessionRequest;->k:Ljava/util/concurrent/Future;

    :cond_0
    iput-object v0, p0, Lanet/channel/SessionRequest;->e:Lanet/channel/Session;

    :cond_1
    return-void
.end method

.method protected b()I
    .locals 1

    iget-object v0, p0, Lanet/channel/SessionRequest;->e:Lanet/channel/Session;

    if-eqz v0, :cond_0

    .line 700
    iget-object v0, v0, Lanet/channel/Session;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v0}, Lanet/channel/entity/ConnType;->getType()I

    move-result v0

    return v0

    :cond_0
    const/4 v0, -0x1

    return v0
.end method

.method protected declared-synchronized b(Landroid/content/Context;ILjava/lang/String;Lanet/channel/SessionGetCallback;J)V
    .locals 9

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lanet/channel/SessionRequest;->b:Lanet/channel/e;

    .line 222
    invoke-virtual {v0, p0, p2}, Lanet/channel/e;->a(Lanet/channel/SessionRequest;I)Lanet/channel/Session;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const-string p1, "awcn.SessionRequest"

    const-string p2, "Available Session exist!!!"

    new-array p5, v1, [Ljava/lang/Object;

    .line 224
    invoke-static {p1, p2, p3, p5}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 225
    invoke-interface {p4, v0}, Lanet/channel/SessionGetCallback;->onSessionGetSuccess(Lanet/channel/Session;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    .line 226
    monitor-exit p0

    return-void

    .line 229
    :cond_0
    :try_start_1
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/4 p3, 0x0

    .line 230
    invoke-static {p3}, Lanet/channel/util/i;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    :cond_1
    const-string v0, "awcn.SessionRequest"

    const-string v2, "SessionRequest start"

    const/4 v3, 0x4

    new-array v4, v3, [Ljava/lang/Object;

    const-string v5, "host"

    aput-object v5, v4, v1

    iget-object v5, p0, Lanet/channel/SessionRequest;->i:Ljava/lang/String;

    const/4 v6, 0x1

    aput-object v5, v4, v6

    const-string v5, "type"

    const/4 v7, 0x2

    aput-object v5, v4, v7

    .line 232
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    const/4 v8, 0x3

    aput-object v5, v4, v8

    invoke-static {v0, v2, p3, v4}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-boolean v0, p0, Lanet/channel/SessionRequest;->d:Z

    if-eqz v0, :cond_3

    const-string p1, "awcn.SessionRequest"

    const-string v0, "session connecting"

    new-array v2, v7, [Ljava/lang/Object;

    const-string v3, "host"

    aput-object v3, v2, v1

    .line 234
    invoke-virtual {p0}, Lanet/channel/SessionRequest;->a()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v2, v6

    invoke-static {p1, v0, p3, v2}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 235
    invoke-virtual {p0}, Lanet/channel/SessionRequest;->b()I

    move-result p1

    if-ne p1, p2, :cond_2

    .line 236
    new-instance p1, Lanet/channel/SessionRequest$c;

    invoke-direct {p1, p0, p4}, Lanet/channel/SessionRequest$c;-><init>(Lanet/channel/SessionRequest;Lanet/channel/SessionGetCallback;)V

    iget-object p2, p0, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 237
    monitor-enter p2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    :try_start_2
    iget-object p3, p0, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 238
    invoke-virtual {p3, p4, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 239
    monitor-exit p2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 240
    :try_start_3
    sget-object p2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {p1, p5, p6, p2}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 239
    :try_start_4
    monitor-exit p2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    throw p1

    .line 242
    :cond_2
    invoke-interface {p4}, Lanet/channel/SessionGetCallback;->onSessionGetFail()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    .line 244
    :goto_0
    monitor-exit p0

    return-void

    .line 246
    :cond_3
    :try_start_6
    invoke-virtual {p0, v6}, Lanet/channel/SessionRequest;->a(Z)V

    .line 247
    new-instance v0, Lanet/channel/SessionRequest$b;

    invoke-direct {v0, p0, p3}, Lanet/channel/SessionRequest$b;-><init>(Lanet/channel/SessionRequest;Ljava/lang/String;)V

    sget-object v2, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v4, 0x2d

    invoke-static {v0, v4, v5, v2}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/SessionRequest;->k:Ljava/util/concurrent/Future;

    .line 248
    new-instance v0, Lanet/channel/statist/SessionConnStat;

    invoke-direct {v0}, Lanet/channel/statist/SessionConnStat;-><init>()V

    iput-object v0, p0, Lanet/channel/SessionRequest;->h:Lanet/channel/statist/SessionConnStat;

    .line 249
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iput-wide v4, v0, Lanet/channel/statist/SessionConnStat;->start:J

    .line 251
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->isConnected()Z

    move-result v0

    if-nez v0, :cond_5

    .line 252
    invoke-static {v6}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result p1

    if-eqz p1, :cond_4

    const-string p1, "awcn.SessionRequest"

    const-string p2, "network is not available, can\'t create session"

    new-array p4, v7, [Ljava/lang/Object;

    const-string p5, "isConnected"

    aput-object p5, p4, v1

    .line 253
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->isConnected()Z

    move-result p5

    invoke-static {p5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p5

    aput-object p5, p4, v6

    invoke-static {p1, p2, p3, p4}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 255
    :cond_4
    invoke-virtual {p0}, Lanet/channel/SessionRequest;->c()V

    .line 256
    new-instance p1, Ljava/lang/RuntimeException;

    const-string p2, "no network"

    invoke-direct {p1, p2}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 258
    :cond_5
    invoke-direct {p0, p2, p3}, Lanet/channel/SessionRequest;->a(ILjava/lang/String;)Ljava/util/List;

    move-result-object v0

    .line 260
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_6

    .line 266
    invoke-direct {p0, v0, p3}, Lanet/channel/SessionRequest;->a(Ljava/util/List;Ljava/lang/String;)Ljava/util/List;

    move-result-object p2
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    .line 269
    :try_start_7
    invoke-interface {p2, v1}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lanet/channel/entity/a;

    .line 270
    new-instance v0, Lanet/channel/SessionRequest$a;

    invoke-direct {v0, p0, p1, p2, p3}, Lanet/channel/SessionRequest$a;-><init>(Lanet/channel/SessionRequest;Landroid/content/Context;Ljava/util/List;Lanet/channel/entity/a;)V

    invoke-virtual {p3}, Lanet/channel/entity/a;->h()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p0, p1, p3, v0, p2}, Lanet/channel/SessionRequest;->a(Landroid/content/Context;Lanet/channel/entity/a;Lanet/channel/SessionRequest$IConnCb;Ljava/lang/String;)V

    .line 271
    new-instance p1, Lanet/channel/SessionRequest$c;

    invoke-direct {p1, p0, p4}, Lanet/channel/SessionRequest$c;-><init>(Lanet/channel/SessionRequest;Lanet/channel/SessionGetCallback;)V

    iget-object p2, p0, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 272
    monitor-enter p2
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    :try_start_8
    iget-object p3, p0, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 273
    invoke-virtual {p3, p4, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 274
    monitor-exit p2
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    .line 275
    :try_start_9
    sget-object p2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {p1, p5, p6, p2}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    goto :goto_1

    :catchall_1
    move-exception p1

    .line 274
    :try_start_a
    monitor-exit p2
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    :try_start_b
    throw p1
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    .line 277
    :catchall_2
    :try_start_c
    invoke-virtual {p0}, Lanet/channel/SessionRequest;->c()V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_3

    .line 279
    :goto_1
    monitor-exit p0

    return-void

    :cond_6
    :try_start_d
    const-string p1, "awcn.SessionRequest"

    const-string p4, "no avalible strategy, can\'t create session"

    new-array p5, v3, [Ljava/lang/Object;

    const-string p6, "host"

    aput-object p6, p5, v1

    iget-object p6, p0, Lanet/channel/SessionRequest;->i:Ljava/lang/String;

    aput-object p6, p5, v6

    const-string p6, "type"

    aput-object p6, p5, v7

    .line 261
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    aput-object p2, p5, v8

    invoke-static {p1, p4, p3, p5}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 262
    invoke-virtual {p0}, Lanet/channel/SessionRequest;->c()V

    .line 263
    new-instance p1, Lanet/channel/NoAvailStrategyException;

    const-string p2, "no avalible strategy"

    invoke-direct {p1, p2}, Lanet/channel/NoAvailStrategyException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_3

    :catchall_3
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method protected b(Z)V
    .locals 5

    iget-object v0, p0, Lanet/channel/SessionRequest;->a:Lanet/channel/SessionCenter;

    .line 637
    iget-object v0, v0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    iget-object v1, p0, Lanet/channel/SessionRequest;->i:Ljava/lang/String;

    const-string v2, "autoCreate"

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    const-string v4, "host"

    filled-new-array {v4, v1, v2, v3}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "awcn.SessionRequest"

    const-string v3, "closeSessions"

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    if-nez p1, :cond_0

    iget-object v0, p0, Lanet/channel/SessionRequest;->e:Lanet/channel/Session;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lanet/channel/SessionRequest;->e:Lanet/channel/Session;

    const/4 v1, 0x0

    .line 640
    iput-boolean v1, v0, Lanet/channel/Session;->u:Z

    iget-object v0, p0, Lanet/channel/SessionRequest;->e:Lanet/channel/Session;

    .line 641
    invoke-virtual {v0, v1}, Lanet/channel/Session;->close(Z)V

    :cond_0
    iget-object v0, p0, Lanet/channel/SessionRequest;->b:Lanet/channel/e;

    .line 643
    invoke-virtual {v0, p0}, Lanet/channel/e;->a(Lanet/channel/SessionRequest;)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 645
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/Session;

    if-eqz v1, :cond_1

    .line 648
    invoke-virtual {v1, p1}, Lanet/channel/Session;->close(Z)V

    goto :goto_0

    :cond_2
    return-void
.end method

.method c()V
    .locals 2

    const/4 v0, 0x0

    .line 706
    invoke-virtual {p0, v0}, Lanet/channel/SessionRequest;->a(Z)V

    iget-object v0, p0, Lanet/channel/SessionRequest;->l:Ljava/lang/Object;

    .line 707
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lanet/channel/SessionRequest;->l:Ljava/lang/Object;

    .line 708
    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 709
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method
