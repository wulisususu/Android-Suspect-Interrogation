.class public Lanet/channel/session/TnetSpdySession;
.super Lanet/channel/Session;
.source "Taobao"

# interfaces
.implements Lorg/android/spdy/SessionCb;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanet/channel/session/TnetSpdySession$a;
    }
.end annotation


# instance fields
.field protected A:J

.field protected B:I

.field protected C:Lanet/channel/DataFrameCb;

.field protected D:Lanet/channel/heartbeat/IHeartbeat;

.field protected E:Lanet/channel/IAuth;

.field protected F:Ljava/lang/String;

.field protected G:Lanet/channel/security/ISecurity;

.field private H:I

.field private I:Z

.field protected w:Lorg/android/spdy/SpdyAgent;

.field protected x:Lorg/android/spdy/SpdySession;

.field protected volatile y:Z

.field protected z:J


# direct methods
.method public constructor <init>(Landroid/content/Context;Lanet/channel/entity/a;)V
    .locals 2

    .line 94
    invoke-direct {p0, p1, p2}, Lanet/channel/Session;-><init>(Landroid/content/Context;Lanet/channel/entity/a;)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lanet/channel/session/TnetSpdySession;->y:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lanet/channel/session/TnetSpdySession;->A:J

    iput p1, p0, Lanet/channel/session/TnetSpdySession;->H:I

    const/4 p2, -0x1

    iput p2, p0, Lanet/channel/session/TnetSpdySession;->B:I

    const/4 p2, 0x0

    iput-object p2, p0, Lanet/channel/session/TnetSpdySession;->C:Lanet/channel/DataFrameCb;

    iput-object p2, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    iput-object p2, p0, Lanet/channel/session/TnetSpdySession;->E:Lanet/channel/IAuth;

    iput-object p2, p0, Lanet/channel/session/TnetSpdySession;->F:Ljava/lang/String;

    iput-object p2, p0, Lanet/channel/session/TnetSpdySession;->G:Lanet/channel/security/ISecurity;

    iput-boolean p1, p0, Lanet/channel/session/TnetSpdySession;->I:Z

    return-void
.end method

.method static synthetic a(Lanet/channel/session/TnetSpdySession;I)I
    .locals 0

    .line 68
    iput p1, p0, Lanet/channel/session/TnetSpdySession;->H:I

    return p1
.end method

.method private a(IIZLjava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->C:Lanet/channel/DataFrameCb;

    if-eqz v0, :cond_0

    .line 272
    invoke-interface {v0, p1, p2, p3, p4}, Lanet/channel/DataFrameCb;->onException(IIZLjava/lang/String;)V

    :cond_0
    return-void
.end method

.method static synthetic a(Lanet/channel/session/TnetSpdySession;ILanet/channel/entity/b;)V
    .locals 0

    .line 68
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/TnetSpdySession;->handleCallbacks(ILanet/channel/entity/b;)V

    return-void
.end method

.method static synthetic a(Lanet/channel/session/TnetSpdySession;Lanet/channel/request/Request;I)V
    .locals 0

    .line 68
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/TnetSpdySession;->handleResponseCode(Lanet/channel/request/Request;I)V

    return-void
.end method

.method static synthetic a(Lanet/channel/session/TnetSpdySession;Lanet/channel/request/Request;Ljava/util/Map;)V
    .locals 0

    .line 68
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/TnetSpdySession;->handleResponseHeaders(Lanet/channel/request/Request;Ljava/util/Map;)V

    return-void
.end method

.method static synthetic a(Lanet/channel/session/TnetSpdySession;)Z
    .locals 0

    .line 68
    iget-boolean p0, p0, Lanet/channel/session/TnetSpdySession;->I:Z

    return p0
.end method

.method static synthetic b(Lanet/channel/session/TnetSpdySession;)Ljava/lang/String;
    .locals 0

    .line 68
    iget-object p0, p0, Lanet/channel/session/TnetSpdySession;->d:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic b(Lanet/channel/session/TnetSpdySession;ILanet/channel/entity/b;)V
    .locals 0

    .line 68
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    return-void
.end method

.method static synthetic c(Lanet/channel/session/TnetSpdySession;)Lanet/channel/strategy/IConnStrategy;
    .locals 0

    .line 68
    iget-object p0, p0, Lanet/channel/session/TnetSpdySession;->k:Lanet/channel/strategy/IConnStrategy;

    return-object p0
.end method

.method private c()V
    .locals 7

    const-string v0, "tnet disableHeaderCache"

    const-string v1, "awcn.TnetSpdySession"

    const/4 v2, 0x0

    .line 511
    sput-boolean v2, Lorg/android/spdy/SpdyAgent;->enableDebug:Z

    .line 512
    iget-object v3, p0, Lanet/channel/session/TnetSpdySession;->a:Landroid/content/Context;

    sget-object v4, Lorg/android/spdy/SpdyVersion;->SPDY3:Lorg/android/spdy/SpdyVersion;

    sget-object v5, Lorg/android/spdy/SpdySessionKind;->NONE_SESSION:Lorg/android/spdy/SpdySessionKind;

    invoke-static {v3, v4, v5}, Lorg/android/spdy/SpdyAgent;->getInstance(Landroid/content/Context;Lorg/android/spdy/SpdyVersion;Lorg/android/spdy/SpdySessionKind;)Lorg/android/spdy/SpdyAgent;

    move-result-object v3

    iput-object v3, p0, Lanet/channel/session/TnetSpdySession;->w:Lorg/android/spdy/SpdyAgent;

    iget-object v3, p0, Lanet/channel/session/TnetSpdySession;->G:Lanet/channel/security/ISecurity;

    if-eqz v3, :cond_0

    .line 513
    invoke-interface {v3}, Lanet/channel/security/ISecurity;->isSecOff()Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v3, p0, Lanet/channel/session/TnetSpdySession;->w:Lorg/android/spdy/SpdyAgent;

    .line 514
    new-instance v4, Lanet/channel/session/j;

    invoke-direct {v4, p0}, Lanet/channel/session/j;-><init>(Lanet/channel/session/TnetSpdySession;)V

    invoke-virtual {v3, v4}, Lorg/android/spdy/SpdyAgent;->setAccsSslCallback(Lorg/android/spdy/AccsSSLCallback;)V

    .line 531
    :cond_0
    invoke-static {}, Lanet/channel/AwcnConfig;->isTnetHeaderCacheEnable()Z

    move-result v3

    if-nez v3, :cond_1

    const/4 v3, 0x0

    :try_start_0
    iget-object v4, p0, Lanet/channel/session/TnetSpdySession;->w:Lorg/android/spdy/SpdyAgent;

    .line 533
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    const-string v5, "disableHeaderCache"

    new-array v6, v2, [Ljava/lang/Class;

    .line 534
    invoke-virtual {v4, v5, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iget-object v5, p0, Lanet/channel/session/TnetSpdySession;->w:Lorg/android/spdy/SpdyAgent;

    new-array v6, v2, [Ljava/lang/Object;

    invoke-virtual {v4, v5, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    new-array v4, v2, [Ljava/lang/Object;

    .line 535
    invoke-static {v1, v0, v3, v4}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v4

    new-array v2, v2, [Ljava/lang/Object;

    .line 537
    invoke-static {v1, v0, v3, v4, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_1
    :goto_0
    return-void
.end method

.method static synthetic c(Lanet/channel/session/TnetSpdySession;ILanet/channel/entity/b;)V
    .locals 0

    .line 68
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    return-void
.end method

.method static synthetic d(Lanet/channel/session/TnetSpdySession;)Landroid/content/Context;
    .locals 0

    .line 68
    iget-object p0, p0, Lanet/channel/session/TnetSpdySession;->a:Landroid/content/Context;

    return-object p0
.end method

.method static synthetic d(Lanet/channel/session/TnetSpdySession;ILanet/channel/entity/b;)V
    .locals 0

    .line 68
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/TnetSpdySession;->handleCallbacks(ILanet/channel/entity/b;)V

    return-void
.end method

.method static synthetic e(Lanet/channel/session/TnetSpdySession;)I
    .locals 1

    .line 68
    iget v0, p0, Lanet/channel/session/TnetSpdySession;->H:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lanet/channel/session/TnetSpdySession;->H:I

    return v0
.end method

.method static synthetic e(Lanet/channel/session/TnetSpdySession;ILanet/channel/entity/b;)V
    .locals 0

    .line 68
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/TnetSpdySession;->handleCallbacks(ILanet/channel/entity/b;)V

    return-void
.end method

.method static synthetic f(Lanet/channel/session/TnetSpdySession;)Ljava/lang/String;
    .locals 0

    .line 68
    iget-object p0, p0, Lanet/channel/session/TnetSpdySession;->d:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic g(Lanet/channel/session/TnetSpdySession;)Lanet/channel/strategy/IConnStrategy;
    .locals 0

    .line 68
    iget-object p0, p0, Lanet/channel/session/TnetSpdySession;->k:Lanet/channel/strategy/IConnStrategy;

    return-object p0
.end method


# virtual methods
.method protected b()V
    .locals 2

    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->E:Lanet/channel/IAuth;

    if-eqz v0, :cond_0

    .line 469
    new-instance v1, Lanet/channel/session/i;

    invoke-direct {v1, p0}, Lanet/channel/session/i;-><init>(Lanet/channel/session/TnetSpdySession;)V

    invoke-interface {v0, p0, v1}, Lanet/channel/IAuth;->auth(Lanet/channel/Session;Lanet/channel/IAuth$AuthCallback;)V

    goto :goto_0

    :cond_0
    const/4 v0, 0x4

    const/4 v1, 0x0

    .line 495
    invoke-virtual {p0, v0, v1}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    .line 496
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    const/4 v1, 0x1

    iput v1, v0, Lanet/channel/statist/SessionStatistic;->ret:I

    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    if-eqz v0, :cond_1

    .line 498
    invoke-interface {v0, p0}, Lanet/channel/heartbeat/IHeartbeat;->start(Lanet/channel/Session;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public bioPingRecvCallback(Lorg/android/spdy/SpdySession;I)V
    .locals 0

    return-void
.end method

.method public close()V
    .locals 4

    .line 356
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    const-string v1, "session"

    filled-new-array {v1, p0}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "awcn.TnetSpdySession"

    const-string v3, "force close!"

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 v0, 0x7

    const/4 v1, 0x0

    .line 357
    invoke-virtual {p0, v0, v1}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    :try_start_0
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    if-eqz v0, :cond_0

    .line 361
    invoke-interface {v0}, Lanet/channel/heartbeat/IHeartbeat;->stop()V

    iput-object v1, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    :cond_0
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->x:Lorg/android/spdy/SpdySession;

    if-eqz v0, :cond_1

    .line 366
    invoke-virtual {v0}, Lorg/android/spdy/SpdySession;->closeSession()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public connect()V
    .locals 16

    move-object/from16 v10, p0

    const-string v11, "awcn.TnetSpdySession"

    .line 281
    iget v0, v10, Lanet/channel/session/TnetSpdySession;->n:I

    const/4 v12, 0x1

    if-eq v0, v12, :cond_a

    iget v0, v10, Lanet/channel/session/TnetSpdySession;->n:I

    if-eqz v0, :cond_a

    iget v0, v10, Lanet/channel/session/TnetSpdySession;->n:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    goto/16 :goto_4

    :cond_0
    const/4 v13, 0x0

    const/4 v14, 0x2

    const/4 v15, 0x0

    :try_start_0
    iget-object v0, v10, Lanet/channel/session/TnetSpdySession;->w:Lorg/android/spdy/SpdyAgent;

    if-nez v0, :cond_1

    .line 287
    invoke-direct/range {p0 .. p0}, Lanet/channel/session/TnetSpdySession;->c()V

    .line 292
    :cond_1
    invoke-static {}, Lanet/channel/util/c;->a()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, v10, Lanet/channel/session/TnetSpdySession;->e:Ljava/lang/String;

    invoke-static {v0}, Lanet/channel/strategy/utils/c;->a(Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_2

    .line 294
    :try_start_1
    iget-object v0, v10, Lanet/channel/session/TnetSpdySession;->e:Ljava/lang/String;

    invoke-static {v0}, Lanet/channel/util/c;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v10, Lanet/channel/session/TnetSpdySession;->f:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 299
    :catch_0
    :cond_2
    :try_start_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v7

    const-string v0, "connect"

    .line 301
    iget-object v2, v10, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    const/16 v3, 0xe

    new-array v3, v3, [Ljava/lang/Object;

    const-string v4, "host"

    aput-object v4, v3, v15

    iget-object v4, v10, Lanet/channel/session/TnetSpdySession;->c:Ljava/lang/String;

    aput-object v4, v3, v12

    const-string v4, "ip"

    aput-object v4, v3, v14

    iget-object v4, v10, Lanet/channel/session/TnetSpdySession;->f:Ljava/lang/String;

    const/4 v5, 0x3

    aput-object v4, v3, v5

    const-string v4, "port"

    aput-object v4, v3, v1

    iget v1, v10, Lanet/channel/session/TnetSpdySession;->g:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 v4, 0x5

    aput-object v1, v3, v4

    const-string v1, "sessionId"

    const/4 v4, 0x6

    aput-object v1, v3, v4

    const/4 v1, 0x7

    aput-object v7, v3, v1

    const-string v1, "SpdyProtocol,"

    const/16 v4, 0x8

    aput-object v1, v3, v4

    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->j:Lanet/channel/entity/ConnType;

    const/16 v4, 0x9

    aput-object v1, v3, v4

    const-string v1, "proxyIp,"

    const/16 v4, 0xa

    aput-object v1, v3, v4

    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->h:Ljava/lang/String;

    const/16 v4, 0xb

    aput-object v1, v3, v4

    const-string v1, "proxyPort,"

    const/16 v4, 0xc

    aput-object v1, v3, v4

    iget v1, v10, Lanet/channel/session/TnetSpdySession;->i:I

    .line 303
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/16 v4, 0xd

    aput-object v1, v3, v4

    .line 301
    invoke-static {v11, v0, v2, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 304
    new-instance v0, Lorg/android/spdy/SessionInfo;

    iget-object v2, v10, Lanet/channel/session/TnetSpdySession;->f:Ljava/lang/String;

    iget v3, v10, Lanet/channel/session/TnetSpdySession;->g:I

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, v10, Lanet/channel/session/TnetSpdySession;->c:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "_"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v4, v10, Lanet/channel/session/TnetSpdySession;->F:Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    iget-object v5, v10, Lanet/channel/session/TnetSpdySession;->h:Ljava/lang/String;

    iget v6, v10, Lanet/channel/session/TnetSpdySession;->i:I

    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v1}, Lanet/channel/entity/ConnType;->getTnetConType()I

    move-result v9

    move-object v1, v0

    move-object/from16 v8, p0

    invoke-direct/range {v1 .. v9}, Lorg/android/spdy/SessionInfo;-><init>(Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ILjava/lang/Object;Lorg/android/spdy/SessionCb;I)V

    .line 305
    iget v1, v10, Lanet/channel/session/TnetSpdySession;->r:I

    int-to-float v1, v1

    invoke-static {}, Lanet/channel/util/Utils;->getNetworkTimeFactor()F

    move-result v2

    mul-float/2addr v1, v2

    float-to-int v1, v1

    invoke-virtual {v0, v1}, Lorg/android/spdy/SessionInfo;->setConnectionTimeoutMs(I)V

    .line 307
    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v1}, Lanet/channel/entity/ConnType;->isPublicKeyAuto()Z

    move-result v1

    if-nez v1, :cond_6

    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v1}, Lanet/channel/entity/ConnType;->isH2S()Z

    move-result v1

    if-nez v1, :cond_6

    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v1}, Lanet/channel/entity/ConnType;->isHTTP3()Z

    move-result v1

    if-eqz v1, :cond_3

    goto :goto_1

    :cond_3
    iget v1, v10, Lanet/channel/session/TnetSpdySession;->B:I

    if-ltz v1, :cond_4

    .line 311
    invoke-virtual {v0, v1}, Lorg/android/spdy/SessionInfo;->setPubKeySeqNum(I)V

    goto :goto_3

    .line 313
    :cond_4
    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->j:Lanet/channel/entity/ConnType;

    iget-object v2, v10, Lanet/channel/session/TnetSpdySession;->G:Lanet/channel/security/ISecurity;

    if-eqz v2, :cond_5

    invoke-interface {v2}, Lanet/channel/security/ISecurity;->isSecOff()Z

    move-result v2

    goto :goto_0

    :cond_5
    move v2, v12

    :goto_0
    invoke-virtual {v1, v2}, Lanet/channel/entity/ConnType;->getTnetPublicKey(Z)I

    move-result v1

    iput v1, v10, Lanet/channel/session/TnetSpdySession;->B:I

    .line 314
    invoke-virtual {v0, v1}, Lorg/android/spdy/SessionInfo;->setPubKeySeqNum(I)V

    goto :goto_3

    .line 308
    :cond_6
    :goto_1
    iget-boolean v1, v10, Lanet/channel/session/TnetSpdySession;->m:Z

    if-eqz v1, :cond_7

    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->e:Ljava/lang/String;

    goto :goto_2

    :cond_7
    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->d:Ljava/lang/String;

    :goto_2
    invoke-virtual {v0, v1}, Lorg/android/spdy/SessionInfo;->setCertHost(Ljava/lang/String;)V

    .line 318
    :goto_3
    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v1}, Lanet/channel/entity/ConnType;->isHTTP3()Z

    move-result v1

    if-eqz v1, :cond_8

    .line 319
    invoke-static {}, Lanet/channel/AwcnConfig;->getXquicCongControl()I

    move-result v1

    if-ltz v1, :cond_8

    .line 321
    invoke-virtual {v0, v1}, Lorg/android/spdy/SessionInfo;->setXquicCongControl(I)V

    :cond_8
    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->w:Lorg/android/spdy/SpdyAgent;

    .line 325
    invoke-virtual {v1, v0}, Lorg/android/spdy/SpdyAgent;->createSession(Lorg/android/spdy/SessionInfo;)Lorg/android/spdy/SpdySession;

    move-result-object v0

    iput-object v0, v10, Lanet/channel/session/TnetSpdySession;->x:Lorg/android/spdy/SpdySession;

    .line 327
    invoke-virtual {v0}, Lorg/android/spdy/SpdySession;->getRefCount()I

    move-result v0

    if-le v0, v12, :cond_9

    const-string v0, "get session ref count > 1!!!"

    .line 328
    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v2, v15, [Ljava/lang/Object;

    invoke-static {v11, v0, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 329
    new-instance v0, Lanet/channel/entity/b;

    invoke-direct {v0, v12}, Lanet/channel/entity/b;-><init>(I)V

    invoke-virtual {v10, v15, v0}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    .line 330
    invoke-virtual/range {p0 .. p0}, Lanet/channel/session/TnetSpdySession;->b()V

    return-void

    .line 334
    :cond_9
    invoke-virtual {v10, v12, v13}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    .line 335
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, v10, Lanet/channel/session/TnetSpdySession;->z:J

    .line 339
    iget-object v0, v10, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->h:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    xor-int/2addr v1, v12

    iput v1, v0, Lanet/channel/statist/SessionStatistic;->isProxy:I

    .line 340
    iget-object v0, v10, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    const-string v1, "false"

    iput-object v1, v0, Lanet/channel/statist/SessionStatistic;->isTunnel:Ljava/lang/String;

    .line 341
    iget-object v0, v10, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v1

    iput-boolean v1, v0, Lanet/channel/statist/SessionStatistic;->isBackground:Z

    const-wide/16 v0, 0x0

    iput-wide v0, v10, Lanet/channel/session/TnetSpdySession;->A:J
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_4

    :catchall_0
    move-exception v0

    .line 345
    invoke-virtual {v10, v14, v13}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    .line 346
    iget-object v1, v10, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v2, v15, [Ljava/lang/Object;

    const-string v3, "connect exception "

    invoke-static {v11, v3, v1, v0, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_a
    :goto_4
    return-void
.end method

.method protected getRecvTimeOutRunnable()Ljava/lang/Runnable;
    .locals 1

    .line 380
    new-instance v0, Lanet/channel/session/h;

    invoke-direct {v0, p0}, Lanet/channel/session/h;-><init>(Lanet/channel/session/TnetSpdySession;)V

    return-object v0
.end method

.method public getSSLMeta(Lorg/android/spdy/SpdySession;)[B
    .locals 7

    const-string v0, "accs_ssl_key2_"

    .line 708
    invoke-virtual {p1}, Lorg/android/spdy/SpdySession;->getDomain()Ljava/lang/String;

    move-result-object p1

    .line 709
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v2, 0x0

    const-string v3, "awcn.TnetSpdySession"

    const/4 v4, 0x0

    if-eqz v1, :cond_0

    const-string p1, "get sslticket host is null"

    new-array v0, v2, [Ljava/lang/Object;

    .line 710
    invoke-static {v3, p1, v4, v0}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-object v4

    :cond_0
    :try_start_0
    iget-object v1, p0, Lanet/channel/session/TnetSpdySession;->G:Lanet/channel/security/ISecurity;

    if-eqz v1, :cond_1

    .line 716
    iget-object v5, p0, Lanet/channel/session/TnetSpdySession;->a:Landroid/content/Context;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v1, v5, p1}, Lanet/channel/security/ISecurity;->getBytes(Landroid/content/Context;Ljava/lang/String;)[B

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v4, p1

    goto :goto_0

    :catchall_0
    move-exception p1

    const-string v0, "getSSLMeta"

    new-array v1, v2, [Ljava/lang/Object;

    .line 719
    invoke-static {v3, v0, v4, p1, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_1
    :goto_0
    return-object v4
.end method

.method public initConfig(Lanet/channel/Config;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 99
    invoke-virtual {p1}, Lanet/channel/Config;->getAppkey()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/session/TnetSpdySession;->F:Ljava/lang/String;

    .line 100
    invoke-virtual {p1}, Lanet/channel/Config;->getSecurity()Lanet/channel/security/ISecurity;

    move-result-object p1

    iput-object p1, p0, Lanet/channel/session/TnetSpdySession;->G:Lanet/channel/security/ISecurity;

    :cond_0
    return-void
.end method

.method public initSessionInfo(Lanet/channel/SessionInfo;)V
    .locals 3

    if-eqz p1, :cond_1

    .line 106
    iget-object v0, p1, Lanet/channel/SessionInfo;->dataFrameCb:Lanet/channel/DataFrameCb;

    iput-object v0, p0, Lanet/channel/session/TnetSpdySession;->C:Lanet/channel/DataFrameCb;

    .line 107
    iget-object v0, p1, Lanet/channel/SessionInfo;->auth:Lanet/channel/IAuth;

    iput-object v0, p0, Lanet/channel/session/TnetSpdySession;->E:Lanet/channel/IAuth;

    .line 108
    iget-boolean v0, p1, Lanet/channel/SessionInfo;->isKeepAlive:Z

    if-eqz v0, :cond_1

    .line 109
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    const-wide/16 v1, 0x1

    iput-wide v1, v0, Lanet/channel/statist/SessionStatistic;->isKL:J

    const/4 v0, 0x1

    .line 110
    iput-boolean v0, p0, Lanet/channel/session/TnetSpdySession;->t:Z

    .line 111
    iget-object v0, p1, Lanet/channel/SessionInfo;->heartbeat:Lanet/channel/heartbeat/IHeartbeat;

    iput-object v0, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    .line 112
    iget-boolean v0, p1, Lanet/channel/SessionInfo;->isAccs:Z

    iput-boolean v0, p0, Lanet/channel/session/TnetSpdySession;->I:Z

    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    if-nez v0, :cond_1

    .line 114
    iget-boolean p1, p1, Lanet/channel/SessionInfo;->isAccs:Z

    if-eqz p1, :cond_0

    invoke-static {}, Lanet/channel/AwcnConfig;->isAccsSessionCreateForbiddenInBg()Z

    move-result p1

    if-nez p1, :cond_0

    .line 115
    invoke-static {}, Lanet/channel/heartbeat/HeartbeatManager;->getDefaultBackgroundAccsHeartbeat()Lanet/channel/heartbeat/IHeartbeat;

    move-result-object p1

    iput-object p1, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    goto :goto_0

    .line 117
    :cond_0
    invoke-static {}, Lanet/channel/heartbeat/HeartbeatManager;->getDefaultHeartbeat()Lanet/channel/heartbeat/IHeartbeat;

    move-result-object p1

    iput-object p1, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    .line 123
    :cond_1
    :goto_0
    invoke-static {}, Lanet/channel/AwcnConfig;->isIdleSessionCloseEnable()Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    if-nez p1, :cond_2

    .line 124
    new-instance p1, Lanet/channel/heartbeat/c;

    invoke-direct {p1}, Lanet/channel/heartbeat/c;-><init>()V

    iput-object p1, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    :cond_2
    return-void
.end method

.method public isAvailable()Z
    .locals 2

    .line 504
    iget v0, p0, Lanet/channel/session/TnetSpdySession;->n:I

    const/4 v1, 0x4

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method protected onDisconnect()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lanet/channel/session/TnetSpdySession;->y:Z

    return-void
.end method

.method public ping(Z)V
    .locals 1

    .line 406
    iget v0, p0, Lanet/channel/session/TnetSpdySession;->s:I

    invoke-virtual {p0, p1, v0}, Lanet/channel/session/TnetSpdySession;->ping(ZI)V

    return-void
.end method

.method public ping(ZI)V
    .locals 9

    const/4 v0, 0x1

    .line 415
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v1

    const-string v2, "ping"

    const-string v3, "awcn.TnetSpdySession"

    if-eqz v1, :cond_0

    .line 416
    iget-object v1, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    iget-object v4, p0, Lanet/channel/session/TnetSpdySession;->c:Ljava/lang/String;

    .line 417
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v5

    const-string v6, "host"

    const-string v7, "thread"

    filled-new-array {v6, v4, v7, v5}, [Ljava/lang/Object;

    move-result-object v4

    .line 416
    invoke-static {v3, v2, v1, v4}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    if-eqz p1, :cond_8

    const/4 v1, 0x0

    :try_start_0
    iget-object v4, p0, Lanet/channel/session/TnetSpdySession;->x:Lorg/android/spdy/SpdySession;

    if-eqz v4, :cond_4

    .line 422
    iget v4, p0, Lanet/channel/session/TnetSpdySession;->n:I

    if-eqz v4, :cond_1

    iget v4, p0, Lanet/channel/session/TnetSpdySession;->n:I

    const/4 v5, 0x4

    if-ne v4, v5, :cond_8

    :cond_1
    const/16 v4, 0x40

    const/4 v5, 0x0

    .line 423
    invoke-virtual {p0, v4, v5}, Lanet/channel/session/TnetSpdySession;->handleCallbacks(ILanet/channel/entity/b;)V

    iget-boolean v4, p0, Lanet/channel/session/TnetSpdySession;->y:Z

    if-eqz v4, :cond_2

    return-void

    :cond_2
    iput-boolean v0, p0, Lanet/channel/session/TnetSpdySession;->y:Z

    .line 429
    iget-object v4, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-wide v5, v4, Lanet/channel/statist/SessionStatistic;->ppkgCount:J

    const-wide/16 v7, 0x1

    add-long/2addr v5, v7

    iput-wide v5, v4, Lanet/channel/statist/SessionStatistic;->ppkgCount:J

    iget-object v4, p0, Lanet/channel/session/TnetSpdySession;->x:Lorg/android/spdy/SpdySession;

    .line 430
    invoke-virtual {v4}, Lorg/android/spdy/SpdySession;->submitPing()I

    .line 431
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 432
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v4, p0, Lanet/channel/session/TnetSpdySession;->c:Ljava/lang/String;

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " submit ping ms:"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    iget-wide v6, p0, Lanet/channel/session/TnetSpdySession;->z:J

    sub-long/2addr v4, v6

    invoke-virtual {v0, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v4, " force:"

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v4, v1, [Ljava/lang/Object;

    invoke-static {v3, p1, v0, v4}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 435
    :cond_3
    invoke-virtual {p0, p2}, Lanet/channel/session/TnetSpdySession;->setPingTimeout(I)V

    .line 436
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iput-wide p1, p0, Lanet/channel/session/TnetSpdySession;->z:J

    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    if-eqz p1, :cond_8

    .line 439
    invoke-interface {p1}, Lanet/channel/heartbeat/IHeartbeat;->reSchedule()V

    goto :goto_0

    .line 444
    :cond_4
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    if-eqz p1, :cond_5

    .line 445
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    const-string p2, "session null"

    iput-object p2, p1, Lanet/channel/statist/SessionStatistic;->closeReason:Ljava/lang/String;

    .line 447
    :cond_5
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->c:Ljava/lang/String;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " session null"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v0, v1, [Ljava/lang/Object;

    invoke-static {v3, p1, p2, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 448
    invoke-virtual {p0}, Lanet/channel/session/TnetSpdySession;->close()V
    :try_end_0
    .catch Lorg/android/spdy/SpdyErrorException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 459
    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v0, v1, [Ljava/lang/Object;

    invoke-static {v3, v2, p2, p1, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto :goto_0

    :catch_1
    move-exception p1

    .line 452
    invoke-virtual {p1}, Lorg/android/spdy/SpdyErrorException;->SpdyErrorGetCode()I

    move-result p2

    const/16 v0, -0x450

    if-eq p2, v0, :cond_6

    .line 453
    invoke-virtual {p1}, Lorg/android/spdy/SpdyErrorException;->SpdyErrorGetCode()I

    move-result p2

    const/16 v0, -0x44f

    if-ne p2, v0, :cond_7

    .line 454
    :cond_6
    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v0, v1, [Ljava/lang/Object;

    const-string v4, "Send request on closed session!!!"

    invoke-static {v3, v4, p2, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 455
    new-instance p2, Lanet/channel/entity/b;

    const/4 v0, 0x2

    invoke-direct {p2, v0}, Lanet/channel/entity/b;-><init>(I)V

    const/4 v0, 0x6

    invoke-virtual {p0, v0, p2}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    .line 457
    :cond_7
    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v0, v1, [Ljava/lang/Object;

    invoke-static {v3, v2, p2, p1, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_8
    :goto_0
    return-void
.end method

.method public putSSLMeta(Lorg/android/spdy/SpdySession;[B)I
    .locals 6

    const-string v0, "accs_ssl_key2_"

    .line 728
    invoke-virtual {p1}, Lorg/android/spdy/SpdySession;->getDomain()Ljava/lang/String;

    move-result-object p1

    .line 729
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v2, -0x1

    if-eqz v1, :cond_0

    return v2

    :cond_0
    const/4 v1, 0x0

    :try_start_0
    iget-object v3, p0, Lanet/channel/session/TnetSpdySession;->G:Lanet/channel/security/ISecurity;

    if-eqz v3, :cond_1

    .line 734
    iget-object v4, p0, Lanet/channel/session/TnetSpdySession;->a:Landroid/content/Context;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v3, v4, p1, p2}, Lanet/channel/security/ISecurity;->saveBytes(Landroid/content/Context;Ljava/lang/String;[B)Z

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p1, :cond_1

    move v2, v1

    goto :goto_0

    :catchall_0
    move-exception p1

    const/4 p2, 0x0

    new-array v0, v1, [Ljava/lang/Object;

    const-string v1, "awcn.TnetSpdySession"

    const-string v3, "putSSLMeta"

    .line 737
    invoke-static {v1, v3, p2, p1, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_1
    :goto_0
    return v2
.end method

.method public request(Lanet/channel/request/Request;Lanet/channel/RequestCb;)Lanet/channel/request/Cancelable;
    .locals 24

    move-object/from16 v1, p0

    move-object/from16 v0, p1

    move-object/from16 v2, p2

    const-string v3, "Host"

    const-string v4, "awcn.TnetSpdySession"

    .line 135
    sget-object v5, Lanet/channel/request/c;->NULL:Lanet/channel/request/c;

    if-eqz v0, :cond_0

    .line 137
    iget-object v6, v0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    goto :goto_0

    :cond_0
    new-instance v6, Lanet/channel/statist/RequestStatistic;

    iget-object v7, v1, Lanet/channel/session/TnetSpdySession;->d:Ljava/lang/String;

    const/4 v8, 0x0

    invoke-direct {v6, v7, v8}, Lanet/channel/statist/RequestStatistic;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 138
    :goto_0
    iget-object v7, v1, Lanet/channel/session/TnetSpdySession;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v6, v7}, Lanet/channel/statist/RequestStatistic;->setConnType(Lanet/channel/entity/ConnType;)V

    .line 139
    iget-wide v7, v6, Lanet/channel/statist/RequestStatistic;->start:J

    const-wide/16 v9, 0x0

    cmp-long v7, v7, v9

    if-nez v7, :cond_1

    .line 140
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    iput-wide v7, v6, Lanet/channel/statist/RequestStatistic;->reqStart:J

    iput-wide v7, v6, Lanet/channel/statist/RequestStatistic;->start:J

    .line 142
    :cond_1
    iget-object v7, v1, Lanet/channel/session/TnetSpdySession;->f:Ljava/lang/String;

    iget v8, v1, Lanet/channel/session/TnetSpdySession;->g:I

    invoke-virtual {v6, v7, v8}, Lanet/channel/statist/RequestStatistic;->setIPAndPort(Ljava/lang/String;I)V

    .line 143
    iget-object v7, v1, Lanet/channel/session/TnetSpdySession;->k:Lanet/channel/strategy/IConnStrategy;

    invoke-interface {v7}, Lanet/channel/strategy/IConnStrategy;->getIpSource()I

    move-result v7

    iput v7, v6, Lanet/channel/statist/RequestStatistic;->ipRefer:I

    .line 144
    iget-object v7, v1, Lanet/channel/session/TnetSpdySession;->k:Lanet/channel/strategy/IConnStrategy;

    invoke-interface {v7}, Lanet/channel/strategy/IConnStrategy;->getIpType()I

    move-result v7

    iput v7, v6, Lanet/channel/statist/RequestStatistic;->ipType:I

    .line 145
    iget-object v7, v1, Lanet/channel/session/TnetSpdySession;->l:Ljava/lang/String;

    iput-object v7, v6, Lanet/channel/statist/RequestStatistic;->unit:Ljava/lang/String;

    if-eqz v0, :cond_10

    if-nez v2, :cond_2

    goto/16 :goto_8

    :cond_2
    const/4 v7, 0x0

    const/4 v8, 0x2

    :try_start_0
    iget-object v9, v1, Lanet/channel/session/TnetSpdySession;->x:Lorg/android/spdy/SpdySession;

    if-eqz v9, :cond_d

    .line 158
    iget v9, v1, Lanet/channel/session/TnetSpdySession;->n:I

    if-eqz v9, :cond_3

    iget v9, v1, Lanet/channel/session/TnetSpdySession;->n:I

    const/4 v10, 0x4

    if-ne v9, v10, :cond_d

    .line 159
    :cond_3
    iget-boolean v9, v1, Lanet/channel/session/TnetSpdySession;->m:Z

    if-eqz v9, :cond_4

    .line 160
    iget-object v9, v1, Lanet/channel/session/TnetSpdySession;->e:Ljava/lang/String;

    iget v10, v1, Lanet/channel/session/TnetSpdySession;->g:I

    invoke-virtual {v0, v9, v10}, Lanet/channel/request/Request;->setDnsOptimize(Ljava/lang/String;I)V

    .line 162
    :cond_4
    iget-object v9, v1, Lanet/channel/session/TnetSpdySession;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v9}, Lanet/channel/entity/ConnType;->isSSL()Z

    move-result v9

    invoke-virtual {v0, v9}, Lanet/channel/request/Request;->setUrlScheme(Z)V

    .line 163
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getUrl()Ljava/net/URL;

    move-result-object v11

    .line 164
    invoke-static {v8}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v9
    :try_end_0
    .catch Lorg/android/spdy/SpdyErrorException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    const-string v15, ""

    const/16 v21, 0x1

    if-eqz v9, :cond_5

    .line 165
    :try_start_1
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v9

    new-array v10, v8, [Ljava/lang/Object;

    const-string v12, "request URL"

    aput-object v12, v10, v7

    invoke-virtual {v11}, Ljava/net/URL;->toString()Ljava/lang/String;

    move-result-object v12

    aput-object v12, v10, v21

    invoke-static {v4, v15, v9, v10}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 166
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v9

    new-array v10, v8, [Ljava/lang/Object;

    const-string v12, "request Method"

    aput-object v12, v10, v7

    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getMethod()Ljava/lang/String;

    move-result-object v12

    aput-object v12, v10, v21

    invoke-static {v4, v15, v9, v10}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 167
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v9

    new-array v10, v8, [Ljava/lang/Object;

    const-string v12, "request headers"

    aput-object v12, v10, v7

    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getHeaders()Ljava/util/Map;

    move-result-object v12

    aput-object v12, v10, v21

    invoke-static {v4, v15, v9, v10}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 171
    :cond_5
    iget-object v9, v1, Lanet/channel/session/TnetSpdySession;->h:Ljava/lang/String;

    invoke-static {v9}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_7

    iget v9, v1, Lanet/channel/session/TnetSpdySession;->i:I

    if-gtz v9, :cond_6

    goto :goto_1

    .line 176
    :cond_6
    new-instance v9, Lorg/android/spdy/SpdyRequest;

    invoke-virtual {v11}, Ljava/net/URL;->getHost()Ljava/lang/String;

    move-result-object v12

    .line 177
    invoke-virtual {v11}, Ljava/net/URL;->getPort()I

    move-result v13

    iget-object v14, v1, Lanet/channel/session/TnetSpdySession;->h:Ljava/lang/String;

    iget v10, v1, Lanet/channel/session/TnetSpdySession;->i:I

    .line 178
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getMethod()Ljava/lang/String;

    move-result-object v16

    sget-object v17, Lorg/android/spdy/RequestPriority;->DEFAULT_PRIORITY:Lorg/android/spdy/RequestPriority;

    const/16 v18, -0x1

    .line 180
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getConnectTimeout()I

    move-result v19

    const/16 v20, 0x0

    move/from16 v22, v10

    move-object v10, v9

    move-object/from16 v23, v15

    move/from16 v15, v22

    invoke-direct/range {v10 .. v20}, Lorg/android/spdy/SpdyRequest;-><init>(Ljava/net/URL;Ljava/lang/String;ILjava/lang/String;ILjava/lang/String;Lorg/android/spdy/RequestPriority;III)V

    goto :goto_2

    :cond_7
    :goto_1
    move-object/from16 v23, v15

    .line 172
    new-instance v9, Lorg/android/spdy/SpdyRequest;

    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getMethod()Ljava/lang/String;

    move-result-object v12

    sget-object v13, Lorg/android/spdy/RequestPriority;->DEFAULT_PRIORITY:Lorg/android/spdy/RequestPriority;

    const/4 v14, -0x1

    .line 174
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getConnectTimeout()I

    move-result v15

    move-object v10, v9

    invoke-direct/range {v10 .. v15}, Lorg/android/spdy/SpdyRequest;-><init>(Ljava/net/URL;Ljava/lang/String;Lorg/android/spdy/RequestPriority;II)V

    .line 183
    :goto_2
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getReadTimeout()I

    move-result v10

    invoke-virtual {v9, v10}, Lorg/android/spdy/SpdyRequest;->setRequestRdTimeoutMs(I)V

    .line 184
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getHeaders()Ljava/util/Map;

    move-result-object v10

    .line 185
    invoke-interface {v10, v3}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v11
    :try_end_1
    .catch Lorg/android/spdy/SpdyErrorException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2

    const-string v12, ":host"

    if-nez v11, :cond_9

    .line 186
    :try_start_2
    invoke-virtual {v9, v10}, Lorg/android/spdy/SpdyRequest;->addHeaders(Ljava/util/Map;)V

    .line 187
    iget-boolean v3, v1, Lanet/channel/session/TnetSpdySession;->m:Z

    if-eqz v3, :cond_8

    iget-object v3, v1, Lanet/channel/session/TnetSpdySession;->e:Ljava/lang/String;

    goto :goto_3

    :cond_8
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getHost()Ljava/lang/String;

    move-result-object v3

    :goto_3
    invoke-virtual {v9, v12, v3}, Lorg/android/spdy/SpdyRequest;->addHeader(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_4

    .line 189
    :cond_9
    new-instance v10, Ljava/util/HashMap;

    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getHeaders()Ljava/util/Map;

    move-result-object v11

    invoke-direct {v10, v11}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    .line 190
    invoke-interface {v10, v3}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 191
    iget-boolean v11, v1, Lanet/channel/session/TnetSpdySession;->m:Z

    if-eqz v11, :cond_a

    iget-object v3, v1, Lanet/channel/session/TnetSpdySession;->e:Ljava/lang/String;

    :cond_a
    invoke-interface {v10, v12, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 192
    invoke-virtual {v9, v10}, Lorg/android/spdy/SpdyRequest;->addHeaders(Ljava/util/Map;)V

    .line 195
    :goto_4
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getBodyBytes()[B

    move-result-object v3

    .line 196
    new-instance v10, Lorg/android/spdy/SpdyDataProvider;

    invoke-direct {v10, v3}, Lorg/android/spdy/SpdyDataProvider;-><init>([B)V

    .line 198
    iget-object v3, v0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    iput-wide v11, v3, Lanet/channel/statist/RequestStatistic;->sendStart:J

    .line 199
    iget-object v3, v0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-object v11, v0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v11, v11, Lanet/channel/statist/RequestStatistic;->sendStart:J

    iget-object v13, v0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    iget-wide v13, v13, Lanet/channel/statist/RequestStatistic;->start:J

    sub-long/2addr v11, v13

    iput-wide v11, v3, Lanet/channel/statist/RequestStatistic;->processTime:J

    iget-object v3, v1, Lanet/channel/session/TnetSpdySession;->x:Lorg/android/spdy/SpdySession;

    .line 200
    new-instance v11, Lanet/channel/session/TnetSpdySession$a;

    invoke-direct {v11, v1, v0, v2}, Lanet/channel/session/TnetSpdySession$a;-><init>(Lanet/channel/session/TnetSpdySession;Lanet/channel/request/Request;Lanet/channel/RequestCb;)V

    invoke-virtual {v3, v9, v10, v1, v11}, Lorg/android/spdy/SpdySession;->submitRequest(Lorg/android/spdy/SpdyRequest;Lorg/android/spdy/SpdyDataProvider;Ljava/lang/Object;Lorg/android/spdy/Spdycb;)I

    move-result v3

    .line 201
    invoke-static/range {v21 .. v21}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v9

    if-eqz v9, :cond_b

    .line 202
    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v9

    new-array v10, v8, [Ljava/lang/Object;

    const-string v11, "streamId"

    aput-object v11, v10, v7

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    aput-object v11, v10, v21

    move-object/from16 v11, v23

    invoke-static {v4, v11, v9, v10}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 204
    :cond_b
    new-instance v9, Lanet/channel/request/c;

    iget-object v10, v1, Lanet/channel/session/TnetSpdySession;->x:Lorg/android/spdy/SpdySession;

    invoke-virtual/range {p1 .. p1}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v9, v10, v3, v0}, Lanet/channel/request/c;-><init>(Lorg/android/spdy/SpdySession;ILjava/lang/String;)V
    :try_end_2
    .catch Lorg/android/spdy/SpdyErrorException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    .line 205
    :try_start_3
    iget-object v0, v1, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-wide v10, v0, Lanet/channel/statist/SessionStatistic;->requestCount:J

    const-wide/16 v12, 0x1

    add-long/2addr v10, v12

    iput-wide v10, v0, Lanet/channel/statist/SessionStatistic;->requestCount:J

    .line 206
    iget-object v0, v1, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-wide v10, v0, Lanet/channel/statist/SessionStatistic;->stdRCount:J

    add-long/2addr v10, v12

    iput-wide v10, v0, Lanet/channel/statist/SessionStatistic;->stdRCount:J

    .line 207
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v10

    iput-wide v10, v1, Lanet/channel/session/TnetSpdySession;->z:J

    iget-object v0, v1, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    if-eqz v0, :cond_c

    .line 210
    invoke-interface {v0}, Lanet/channel/heartbeat/IHeartbeat;->reSchedule()V
    :try_end_3
    .catch Lorg/android/spdy/SpdyErrorException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    :cond_c
    move-object v5, v9

    goto :goto_7

    :catch_0
    move-object v5, v9

    goto :goto_5

    :catch_1
    move-exception v0

    move-object v5, v9

    goto :goto_6

    :cond_d
    const/16 v3, -0x12d

    .line 214
    :try_start_4
    invoke-static {v3}, Lanet/channel/util/ErrorConstant;->getErrMsg(I)Ljava/lang/String;

    move-result-object v9

    iget-object v0, v0, Lanet/channel/request/Request;->a:Lanet/channel/statist/RequestStatistic;

    invoke-interface {v2, v3, v9, v0}, Lanet/channel/RequestCb;->onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V
    :try_end_4
    .catch Lorg/android/spdy/SpdyErrorException; {:try_start_4 .. :try_end_4} :catch_3
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_7

    :catch_2
    :goto_5
    const/16 v0, -0x65

    .line 226
    invoke-static {v0}, Lanet/channel/util/ErrorConstant;->getErrMsg(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v0, v3, v6}, Lanet/channel/RequestCb;->onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V

    goto :goto_7

    :catch_3
    move-exception v0

    .line 217
    :goto_6
    invoke-virtual {v0}, Lorg/android/spdy/SpdyErrorException;->SpdyErrorGetCode()I

    move-result v3

    const/16 v9, -0x450

    if-eq v3, v9, :cond_e

    .line 218
    invoke-virtual {v0}, Lorg/android/spdy/SpdyErrorException;->SpdyErrorGetCode()I

    move-result v3

    const/16 v9, -0x44f

    if-ne v3, v9, :cond_f

    .line 219
    :cond_e
    iget-object v3, v1, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v7, v7, [Ljava/lang/Object;

    const-string v9, "Send request on closed session!!!"

    invoke-static {v4, v9, v3, v7}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 220
    new-instance v3, Lanet/channel/entity/b;

    invoke-direct {v3, v8}, Lanet/channel/entity/b;-><init>(I)V

    const/4 v4, 0x6

    invoke-virtual {v1, v4, v3}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    .line 224
    :cond_f
    invoke-virtual {v0}, Lorg/android/spdy/SpdyErrorException;->SpdyErrorGetCode()I

    move-result v0

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    const/16 v3, -0x12c

    .line 223
    invoke-static {v3, v0}, Lanet/channel/util/ErrorConstant;->formatMsg(ILjava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 222
    invoke-interface {v2, v3, v0, v6}, Lanet/channel/RequestCb;->onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V

    :goto_7
    return-object v5

    :cond_10
    :goto_8
    if-eqz v2, :cond_11

    const/16 v0, -0x66

    .line 152
    invoke-static {v0}, Lanet/channel/util/ErrorConstant;->getErrMsg(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v0, v3, v6}, Lanet/channel/RequestCb;->onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V

    :cond_11
    return-object v5
.end method

.method public sendCustomFrame(I[BI)V
    .locals 14

    move-object v1, p0

    move v8, p1

    move-object/from16 v0, p2

    const-string v2, "sendCustomFrame"

    const-string v9, "sendCustomFrame error"

    const-string v10, "awcn.TnetSpdySession"

    const-string v3, "sendCustomFrame con invalid mStatus:"

    const/4 v11, 0x1

    const/4 v12, 0x0

    :try_start_0
    iget-object v4, v1, Lanet/channel/session/TnetSpdySession;->C:Lanet/channel/DataFrameCb;

    if-nez v4, :cond_0

    return-void

    .line 243
    :cond_0
    iget-object v4, v1, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    const/4 v5, 0x4

    new-array v6, v5, [Ljava/lang/Object;

    const-string v7, "dataId"

    aput-object v7, v6, v12

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    aput-object v7, v6, v11

    const-string v7, "type"

    const/4 v13, 0x2

    aput-object v7, v6, v13

    invoke-static/range {p3 .. p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    const/4 v13, 0x3

    aput-object v7, v6, v13

    invoke-static {v10, v2, v4, v6}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 244
    iget v4, v1, Lanet/channel/session/TnetSpdySession;->n:I

    if-ne v4, v5, :cond_3

    iget-object v4, v1, Lanet/channel/session/TnetSpdySession;->x:Lorg/android/spdy/SpdySession;

    if-eqz v4, :cond_3

    if-eqz v0, :cond_1

    .line 245
    array-length v2, v0

    const/16 v3, 0x4000

    if-le v2, v3, :cond_1

    const/16 v0, -0x12f

    const/4 v2, 0x0

    .line 246
    invoke-direct {p0, p1, v0, v12, v2}, Lanet/channel/session/TnetSpdySession;->a(IIZLjava/lang/String;)V

    goto/16 :goto_1

    :cond_1
    const/4 v5, 0x0

    if-nez v0, :cond_2

    move v6, v12

    goto :goto_0

    .line 248
    :cond_2
    array-length v2, v0

    move v6, v2

    :goto_0
    move-object v2, v4

    move v3, p1

    move/from16 v4, p3

    move-object/from16 v7, p2

    invoke-virtual/range {v2 .. v7}, Lorg/android/spdy/SpdySession;->sendCustomControlFrame(IIII[B)I

    .line 250
    iget-object v0, v1, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-wide v2, v0, Lanet/channel/statist/SessionStatistic;->requestCount:J

    const-wide/16 v4, 0x1

    add-long/2addr v2, v4

    iput-wide v2, v0, Lanet/channel/statist/SessionStatistic;->requestCount:J

    .line 251
    iget-object v0, v1, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-wide v2, v0, Lanet/channel/statist/SessionStatistic;->cfRCount:J

    add-long/2addr v2, v4

    iput-wide v2, v0, Lanet/channel/statist/SessionStatistic;->cfRCount:J

    .line 252
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iput-wide v2, v1, Lanet/channel/session/TnetSpdySession;->z:J

    iget-object v0, v1, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    if-eqz v0, :cond_4

    .line 254
    invoke-interface {v0}, Lanet/channel/heartbeat/IHeartbeat;->reSchedule()V

    goto :goto_1

    .line 258
    :cond_3
    iget-object v0, v1, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v4, v11, [Ljava/lang/Object;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v3, v1, Lanet/channel/session/TnetSpdySession;->n:I

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v4, v12

    invoke-static {v10, v2, v0, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-string v0, "session invalid"

    const/16 v2, -0x12d

    .line 259
    invoke-direct {p0, p1, v2, v11, v0}, Lanet/channel/session/TnetSpdySession;->a(IIZLjava/lang/String;)V
    :try_end_0
    .catch Lorg/android/spdy/SpdyErrorException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    .line 265
    iget-object v2, v1, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v3, v12, [Ljava/lang/Object;

    invoke-static {v10, v9, v2, v0, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    const/16 v2, -0x65

    .line 266
    invoke-virtual {v0}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, p1, v2, v11, v0}, Lanet/channel/session/TnetSpdySession;->a(IIZLjava/lang/String;)V

    goto :goto_1

    :catch_1
    move-exception v0

    .line 262
    iget-object v2, v1, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v3, v12, [Ljava/lang/Object;

    invoke-static {v10, v9, v2, v0, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 263
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "SpdyErrorException: "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lorg/android/spdy/SpdyErrorException;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/16 v2, -0x12c

    invoke-direct {p0, p1, v2, v11, v0}, Lanet/channel/session/TnetSpdySession;->a(IIZLjava/lang/String;)V

    :cond_4
    :goto_1
    return-void
.end method

.method public setTnetPublicKey(I)V
    .locals 0

    iput p1, p0, Lanet/channel/session/TnetSpdySession;->B:I

    return-void
.end method

.method public spdyCustomControlFrameFailCallback(Lorg/android/spdy/SpdySession;Ljava/lang/Object;II)V
    .locals 2

    .line 701
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    const-string p2, "dataId"

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    filled-new-array {p2, v0}, [Ljava/lang/Object;

    move-result-object p2

    const-string v0, "awcn.TnetSpdySession"

    const-string v1, "spdyCustomControlFrameFailCallback"

    invoke-static {v0, v1, p1, p2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 p1, 0x1

    const-string p2, "tnet error"

    .line 702
    invoke-direct {p0, p3, p4, p1, p2}, Lanet/channel/session/TnetSpdySession;->a(IIZLjava/lang/String;)V

    return-void
.end method

.method public spdyCustomControlFrameRecvCallback(Lorg/android/spdy/SpdySession;Ljava/lang/Object;IIII[B)V
    .locals 2

    .line 585
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    invoke-static {p6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const-string p5, "frameCb"

    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->C:Lanet/channel/DataFrameCb;

    const-string v1, "len"

    filled-new-array {v1, p2, p5, v0}, [Ljava/lang/Object;

    move-result-object p2

    const-string p5, "awcn.TnetSpdySession"

    const-string v0, "[spdyCustomControlFrameRecvCallback]"

    invoke-static {p5, v0, p1, p2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 p1, 0x1

    .line 586
    invoke-static {p1}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result p1

    const/4 p2, 0x0

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    const/16 p1, 0x200

    if-ge p6, p1, :cond_1

    const-string p1, ""

    move p6, v0

    .line 589
    :goto_0
    array-length v1, p7

    if-ge p6, v1, :cond_0

    .line 590
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    aget-byte v1, p7, p6

    and-int/lit16 v1, v1, 0xff

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, " "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    add-int/lit8 p6, p6, 0x1

    goto :goto_0

    .line 592
    :cond_0
    iget-object p6, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    const-string v1, "str"

    filled-new-array {v1, p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {p5, p2, p6, p1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->C:Lanet/channel/DataFrameCb;

    if-eqz p1, :cond_2

    .line 597
    invoke-interface {p1, p0, p7, p3, p4}, Lanet/channel/DataFrameCb;->onDataReceive(Lanet/channel/session/TnetSpdySession;[BII)V

    goto :goto_1

    .line 599
    :cond_2
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array p3, v0, [Ljava/lang/Object;

    const-string p4, "AccsFrameCb is null"

    invoke-static {p5, p4, p1, p3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 600
    new-instance p1, Lanet/channel/statist/ExceptionStatistic;

    const/16 p3, -0x69

    const-string p4, "rt"

    invoke-direct {p1, p3, p2, p4}, Lanet/channel/statist/ExceptionStatistic;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    .line 601
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p2

    invoke-interface {p2, p1}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    .line 603
    :goto_1
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-wide p2, p1, Lanet/channel/statist/SessionStatistic;->inceptCount:J

    const-wide/16 p4, 0x1

    add-long/2addr p2, p4

    iput-wide p2, p1, Lanet/channel/statist/SessionStatistic;->inceptCount:J

    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    if-eqz p1, :cond_3

    .line 605
    invoke-interface {p1}, Lanet/channel/heartbeat/IHeartbeat;->reSchedule()V

    :cond_3
    return-void
.end method

.method public spdyPingRecvCallback(Lorg/android/spdy/SpdySession;JLjava/lang/Object;)V
    .locals 3

    const/4 p1, 0x2

    .line 564
    invoke-static {p1}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result p1

    if-eqz p1, :cond_0

    .line 565
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    iget-object p4, p0, Lanet/channel/session/TnetSpdySession;->c:Ljava/lang/String;

    const-string v0, "id"

    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "Host"

    filled-new-array {v2, p4, v0, v1}, [Ljava/lang/Object;

    move-result-object p4

    const-string v0, "awcn.TnetSpdySession"

    const-string v1, "ping receive"

    invoke-static {v0, v1, p1, p4}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    const-wide/16 v0, 0x0

    cmp-long p1, p2, v0

    if-gez p1, :cond_1

    return-void

    :cond_1
    const/4 p1, 0x0

    iput-boolean p1, p0, Lanet/channel/session/TnetSpdySession;->y:Z

    iput p1, p0, Lanet/channel/session/TnetSpdySession;->H:I

    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    if-eqz p1, :cond_2

    .line 573
    invoke-interface {p1}, Lanet/channel/heartbeat/IHeartbeat;->reSchedule()V

    :cond_2
    const/16 p1, 0x80

    const/4 p2, 0x0

    .line 575
    invoke-virtual {p0, p1, p2}, Lanet/channel/session/TnetSpdySession;->handleCallbacks(ILanet/channel/entity/b;)V

    return-void
.end method

.method public spdySessionCloseCallback(Lorg/android/spdy/SpdySession;Ljava/lang/Object;Lorg/android/spdy/SuperviseConnectInfo;I)V
    .locals 5

    .line 639
    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    const-string v0, " errorCode:"

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "awcn.TnetSpdySession"

    const-string v2, "spdySessionCloseCallback"

    invoke-static {v1, v2, p2, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    const/4 v0, 0x0

    if-eqz p2, :cond_0

    .line 641
    invoke-interface {p2}, Lanet/channel/heartbeat/IHeartbeat;->stop()V

    iput-object v0, p0, Lanet/channel/session/TnetSpdySession;->D:Lanet/channel/heartbeat/IHeartbeat;

    :cond_0
    const/4 p2, 0x0

    if-eqz p1, :cond_1

    .line 647
    :try_start_0
    invoke-virtual {p1}, Lorg/android/spdy/SpdySession;->cleanUp()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v2

    const-string v3, "session clean up failed!"

    new-array v4, p2, [Ljava/lang/Object;

    .line 650
    invoke-static {v1, v3, v0, v2, v4}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_1
    :goto_0
    const/16 v0, -0xdbc

    if-ne p4, v0, :cond_2

    .line 655
    new-instance v0, Lanet/channel/strategy/ConnEvent;

    invoke-direct {v0}, Lanet/channel/strategy/ConnEvent;-><init>()V

    .line 656
    iput-boolean p2, v0, Lanet/channel/strategy/ConnEvent;->isSuccess:Z

    .line 657
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object v2

    iget-object v3, p0, Lanet/channel/session/TnetSpdySession;->d:Ljava/lang/String;

    iget-object v4, p0, Lanet/channel/session/TnetSpdySession;->k:Lanet/channel/strategy/IConnStrategy;

    invoke-interface {v2, v3, v4, v0}, Lanet/channel/strategy/IStrategyInstance;->notifyConnEvent(Ljava/lang/String;Lanet/channel/strategy/IConnStrategy;Lanet/channel/strategy/ConnEvent;)V

    .line 660
    :cond_2
    new-instance v0, Lanet/channel/entity/b;

    const/4 v2, 0x2

    invoke-direct {v0, v2}, Lanet/channel/entity/b;-><init>(I)V

    const/4 v3, 0x6

    invoke-virtual {p0, v3, v0}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    if-eqz p3, :cond_4

    .line 663
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget v3, p3, Lorg/android/spdy/SuperviseConnectInfo;->reused_counter:I

    int-to-long v3, v3

    iput-wide v3, v0, Lanet/channel/statist/SessionStatistic;->requestCount:J

    .line 664
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget v3, p3, Lorg/android/spdy/SuperviseConnectInfo;->keepalive_period_second:I

    int-to-long v3, v3

    iput-wide v3, v0, Lanet/channel/statist/SessionStatistic;->liveTime:J

    .line 667
    :try_start_1
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v0}, Lanet/channel/entity/ConnType;->isHTTP3()Z

    move-result v0

    if-eqz v0, :cond_4

    if-eqz p1, :cond_3

    const-string v0, "[HTTP3 spdySessionCloseCallback]"

    .line 669
    iget-object v3, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, "connectInfo"

    aput-object v4, v2, p2

    .line 670
    invoke-virtual {p1}, Lorg/android/spdy/SpdySession;->getConnectInfoOnDisConnected()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x1

    aput-object p1, v2, p2

    .line 669
    invoke-static {v1, v0, v3, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 672
    :cond_3
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget p2, p3, Lorg/android/spdy/SuperviseConnectInfo;->xqc0RttStatus:I

    iput p2, p1, Lanet/channel/statist/SessionStatistic;->xqc0RttStatus:I

    .line 673
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-wide v0, p3, Lorg/android/spdy/SuperviseConnectInfo;->retransmissionRate:D

    iput-wide v0, p1, Lanet/channel/statist/SessionStatistic;->retransmissionRate:D

    .line 674
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-wide v0, p3, Lorg/android/spdy/SuperviseConnectInfo;->lossRate:D

    iput-wide v0, p1, Lanet/channel/statist/SessionStatistic;->lossRate:D

    .line 675
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget p2, p3, Lorg/android/spdy/SuperviseConnectInfo;->tlpCount:I

    iput p2, p1, Lanet/channel/statist/SessionStatistic;->tlpCount:I

    .line 676
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget p2, p3, Lorg/android/spdy/SuperviseConnectInfo;->rtoCount:I

    iput p2, p1, Lanet/channel/statist/SessionStatistic;->rtoCount:I

    .line 677
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-wide p2, p3, Lorg/android/spdy/SuperviseConnectInfo;->srtt:J

    iput-wide p2, p1, Lanet/channel/statist/SessionStatistic;->srtt:J
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 684
    :catch_1
    :cond_4
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-wide p1, p1, Lanet/channel/statist/SessionStatistic;->errorCode:J

    const-wide/16 v0, 0x0

    cmp-long p1, p1, v0

    if-nez p1, :cond_5

    .line 685
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    int-to-long p2, p4

    iput-wide p2, p1, Lanet/channel/statist/SessionStatistic;->errorCode:J

    .line 688
    :cond_5
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p2

    iget-wide v0, p0, Lanet/channel/session/TnetSpdySession;->z:J

    sub-long/2addr p2, v0

    long-to-int p2, p2

    iput p2, p1, Lanet/channel/statist/SessionStatistic;->lastPingInterval:I

    .line 689
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    invoke-interface {p1, p2}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    .line 692
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-object p1, p1, Lanet/channel/statist/SessionStatistic;->ip:Ljava/lang/String;

    invoke-static {p1}, Lanet/channel/strategy/utils/c;->b(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_6

    .line 693
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    new-instance p2, Lanet/channel/statist/SessionMonitor;

    iget-object p3, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    invoke-direct {p2, p3}, Lanet/channel/statist/SessionMonitor;-><init>(Lanet/channel/statist/SessionStatistic;)V

    invoke-interface {p1, p2}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    .line 695
    :cond_6
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    invoke-virtual {p2}, Lanet/channel/statist/SessionStatistic;->getAlarmObject()Lanet/channel/statist/AlarmObject;

    move-result-object p2

    invoke-interface {p1, p2}, Lanet/channel/appmonitor/IAppMonitor;->commitAlarm(Lanet/channel/statist/AlarmObject;)V

    return-void
.end method

.method public spdySessionConnectCB(Lorg/android/spdy/SpdySession;Lorg/android/spdy/SuperviseConnectInfo;)V
    .locals 5

    .line 545
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget v1, p2, Lorg/android/spdy/SuperviseConnectInfo;->connectTime:I

    int-to-long v1, v1

    iput-wide v1, v0, Lanet/channel/statist/SessionStatistic;->connectionTime:J

    .line 546
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget v1, p2, Lorg/android/spdy/SuperviseConnectInfo;->handshakeTime:I

    int-to-long v1, v1

    iput-wide v1, v0, Lanet/channel/statist/SessionStatistic;->sslTime:J

    .line 547
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget v1, p2, Lorg/android/spdy/SuperviseConnectInfo;->doHandshakeTime:I

    int-to-long v1, v1

    iput-wide v1, v0, Lanet/channel/statist/SessionStatistic;->sslCalTime:J

    .line 548
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getNetworkSubType()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lanet/channel/statist/SessionStatistic;->netType:Ljava/lang/String;

    .line 549
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lanet/channel/session/TnetSpdySession;->A:J

    .line 550
    new-instance v0, Lanet/channel/entity/b;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Lanet/channel/entity/b;-><init>(I)V

    const/4 v1, 0x0

    invoke-virtual {p0, v1, v0}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    .line 551
    invoke-virtual {p0}, Lanet/channel/session/TnetSpdySession;->b()V

    .line 552
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    iget v1, p2, Lorg/android/spdy/SuperviseConnectInfo;->connectTime:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    iget v2, p2, Lorg/android/spdy/SuperviseConnectInfo;->handshakeTime:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "connectTime"

    const-string v4, "sslTime"

    filled-new-array {v3, v1, v4, v2}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "awcn.TnetSpdySession"

    const-string v3, "spdySessionConnectCB connect"

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 554
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->j:Lanet/channel/entity/ConnType;

    invoke-virtual {v0}, Lanet/channel/entity/ConnType;->isHTTP3()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 555
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-object v1, p2, Lorg/android/spdy/SuperviseConnectInfo;->scid:Ljava/lang/String;

    iput-object v1, v0, Lanet/channel/statist/SessionStatistic;->scid:Ljava/lang/String;

    .line 556
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-object v1, p2, Lorg/android/spdy/SuperviseConnectInfo;->dcid:Ljava/lang/String;

    iput-object v1, v0, Lanet/channel/statist/SessionStatistic;->dcid:Ljava/lang/String;

    .line 557
    iget-object v0, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget p2, p2, Lorg/android/spdy/SuperviseConnectInfo;->congControlKind:I

    iput p2, v0, Lanet/channel/statist/SessionStatistic;->congControlKind:I

    .line 558
    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    const-string v0, "connectInfo"

    invoke-virtual {p1}, Lorg/android/spdy/SpdySession;->getConnectInfoOnConnected()Ljava/lang/String;

    move-result-object p1

    filled-new-array {v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v0, "[HTTP3 spdySessionConnectCB]"

    invoke-static {v2, v0, p2, p1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    return-void
.end method

.method public spdySessionFailedError(Lorg/android/spdy/SpdySession;ILjava/lang/Object;)V
    .locals 4

    const/4 p3, 0x0

    const/4 v0, 0x0

    const-string v1, "awcn.TnetSpdySession"

    if-eqz p1, :cond_0

    .line 615
    :try_start_0
    invoke-virtual {p1}, Lorg/android/spdy/SpdySession;->cleanUp()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    const-string v2, "[spdySessionFailedError]session clean up failed!"

    new-array v3, p3, [Ljava/lang/Object;

    .line 618
    invoke-static {v1, v2, v0, p1, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 621
    :cond_0
    :goto_0
    new-instance p1, Lanet/channel/entity/b;

    const/16 v2, 0x100

    const-string v3, "tnet connect fail"

    invoke-direct {p1, v2, p2, v3}, Lanet/channel/entity/b;-><init>(IILjava/lang/String;)V

    const/4 v2, 0x2

    invoke-virtual {p0, v2, p1}, Lanet/channel/session/TnetSpdySession;->notifyStatus(ILanet/channel/entity/b;)V

    .line 622
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->p:Ljava/lang/String;

    const-string v2, " errorId:"

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v0, p1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 623
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    int-to-long v0, p2

    iput-wide v0, p1, Lanet/channel/statist/SessionStatistic;->errorCode:J

    .line 624
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iput p3, p1, Lanet/channel/statist/SessionStatistic;->ret:I

    .line 625
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getNetworkSubType()Ljava/lang/String;

    move-result-object p2

    iput-object p2, p1, Lanet/channel/statist/SessionStatistic;->netType:Ljava/lang/String;

    .line 626
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    invoke-interface {p1, p2}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    .line 629
    iget-object p1, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    iget-object p1, p1, Lanet/channel/statist/SessionStatistic;->ip:Ljava/lang/String;

    invoke-static {p1}, Lanet/channel/strategy/utils/c;->b(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    .line 630
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    new-instance p2, Lanet/channel/statist/SessionMonitor;

    iget-object p3, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    invoke-direct {p2, p3}, Lanet/channel/statist/SessionMonitor;-><init>(Lanet/channel/statist/SessionStatistic;)V

    invoke-interface {p1, p2}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    .line 632
    :cond_1
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    iget-object p2, p0, Lanet/channel/session/TnetSpdySession;->q:Lanet/channel/statist/SessionStatistic;

    invoke-virtual {p2}, Lanet/channel/statist/SessionStatistic;->getAlarmObject()Lanet/channel/statist/AlarmObject;

    move-result-object p2

    invoke-interface {p1, p2}, Lanet/channel/appmonitor/IAppMonitor;->commitAlarm(Lanet/channel/statist/AlarmObject;)V

    return-void
.end method
