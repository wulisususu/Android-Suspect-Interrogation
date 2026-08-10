.class Lanet/channel/detect/d;
.super Ljava/lang/Object;
.source "Taobao"


# instance fields
.field a:Ljava/util/TreeMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/TreeMap<",
            "Ljava/lang/String;",
            "Lanet/channel/strategy/l$c;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/util/concurrent/atomic/AtomicInteger;


# direct methods
.method constructor <init>()V
    .locals 2

    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 55
    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    iput-object v0, p0, Lanet/channel/detect/d;->a:Ljava/util/TreeMap;

    .line 56
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    iput-object v0, p0, Lanet/channel/detect/d;->b:Ljava/util/concurrent/atomic/AtomicInteger;

    return-void
.end method

.method private static a(Lanet/channel/strategy/ConnProtocol;Lanet/channel/strategy/l$e;)Lanet/channel/strategy/IConnStrategy;
    .locals 1

    .line 289
    new-instance v0, Lanet/channel/detect/j;

    invoke-direct {v0, p1, p0}, Lanet/channel/detect/j;-><init>(Lanet/channel/strategy/l$e;Lanet/channel/strategy/ConnProtocol;)V

    return-object v0
.end method

.method private a(Lanet/channel/strategy/l$c;)V
    .locals 5

    .line 133
    iget-object v0, p1, Lanet/channel/strategy/l$c;->b:[Lanet/channel/strategy/l$e;

    if-eqz v0, :cond_6

    iget-object v0, p1, Lanet/channel/strategy/l$c;->b:[Lanet/channel/strategy/l$e;

    array-length v0, v0

    if-nez v0, :cond_0

    goto :goto_4

    .line 137
    :cond_0
    iget-object v0, p1, Lanet/channel/strategy/l$c;->a:Ljava/lang/String;

    const/4 v1, 0x0

    .line 138
    :goto_0
    iget-object v2, p1, Lanet/channel/strategy/l$c;->b:[Lanet/channel/strategy/l$e;

    array-length v2, v2

    if-ge v1, v2, :cond_6

    .line 139
    iget-object v2, p1, Lanet/channel/strategy/l$c;->b:[Lanet/channel/strategy/l$e;

    aget-object v2, v2, v1

    .line 140
    iget-object v3, v2, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget-object v3, v3, Lanet/channel/strategy/l$a;->b:Ljava/lang/String;

    const-string v4, "http"

    .line 142
    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_4

    const-string v4, "https"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    goto :goto_2

    :cond_1
    const-string v4, "http2"

    .line 144
    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_3

    const-string v4, "spdy"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_3

    const-string v4, "quic"

    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    goto :goto_1

    :cond_2
    const-string v4, "tcp"

    .line 146
    invoke-virtual {v3, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 147
    invoke-direct {p0, v0, v2}, Lanet/channel/detect/d;->c(Ljava/lang/String;Lanet/channel/strategy/l$e;)V

    goto :goto_3

    .line 145
    :cond_3
    :goto_1
    invoke-direct {p0, v0, v2}, Lanet/channel/detect/d;->b(Ljava/lang/String;Lanet/channel/strategy/l$e;)V

    goto :goto_3

    .line 143
    :cond_4
    :goto_2
    invoke-direct {p0, v0, v2}, Lanet/channel/detect/d;->a(Ljava/lang/String;Lanet/channel/strategy/l$e;)V

    :cond_5
    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_6
    :goto_4
    return-void
.end method

.method private a(Ljava/lang/String;Lanet/channel/statist/HorseRaceStat;)V
    .locals 8

    .line 363
    invoke-static {}, Lanet/channel/AwcnConfig;->isPing6Enable()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {p1}, Lanet/channel/strategy/utils/c;->b(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x3

    .line 368
    :try_start_0
    new-instance v7, Lorg/android/netutil/PingTask;

    const/16 v3, 0x3e8

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, v7

    move-object v2, p1

    move v4, v0

    invoke-direct/range {v1 .. v6}, Lorg/android/netutil/PingTask;-><init>(Ljava/lang/String;IIII)V

    .line 369
    invoke-virtual {v7}, Lorg/android/netutil/PingTask;->launch()Ljava/util/concurrent/Future;

    move-result-object p1

    .line 370
    invoke-interface {p1}, Ljava/util/concurrent/Future;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/android/netutil/PingResponse;

    if-nez p1, :cond_1

    return-void

    .line 374
    :cond_1
    invoke-virtual {p1}, Lorg/android/netutil/PingResponse;->getSuccessCnt()I

    move-result v1

    iput v1, p2, Lanet/channel/statist/HorseRaceStat;->pingSuccessCount:I

    .line 375
    iget v1, p2, Lanet/channel/statist/HorseRaceStat;->pingSuccessCount:I

    sub-int/2addr v0, v1

    iput v0, p2, Lanet/channel/statist/HorseRaceStat;->pingTimeoutCount:I

    .line 376
    invoke-virtual {p1}, Lorg/android/netutil/PingResponse;->getLocalIPStr()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p2, Lanet/channel/statist/HorseRaceStat;->localIP:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    const-string v0, "anet.HorseRaceDetector"

    const-string v1, "ping6 task fail."

    const/4 v2, 0x0

    .line 378
    invoke-static {v0, v1, v2, p1, p2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_2
    :goto_0
    return-void
.end method

.method private a(Ljava/lang/String;Lanet/channel/strategy/l$e;)V
    .locals 6

    .line 153
    new-instance v0, Ljava/lang/StringBuilder;

    iget-object v1, p2, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget-object v1, v1, Lanet/channel/strategy/l$a;->b:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const-string v1, "://"

    .line 154
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 155
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p2, Lanet/channel/strategy/l$e;->c:Ljava/lang/String;

    .line 156
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 157
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 159
    invoke-static {v0}, Lanet/channel/util/HttpUrl;->parse(Ljava/lang/String;)Lanet/channel/util/HttpUrl;

    move-result-object v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const-string v1, "url"

    .line 164
    filled-new-array {v1, v0}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "anet.HorseRaceDetector"

    const-string v3, "startShortLinkTask"

    const/4 v4, 0x0

    invoke-static {v2, v3, v4, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 166
    new-instance v1, Lanet/channel/request/Request$Builder;

    invoke-direct {v1}, Lanet/channel/request/Request$Builder;-><init>()V

    invoke-virtual {v1, v0}, Lanet/channel/request/Request$Builder;->setUrl(Lanet/channel/util/HttpUrl;)Lanet/channel/request/Request$Builder;

    move-result-object v0

    const-string v1, "Connection"

    const-string v2, "close"

    .line 167
    invoke-virtual {v0, v1, v2}, Lanet/channel/request/Request$Builder;->addHeader(Ljava/lang/String;Ljava/lang/String;)Lanet/channel/request/Request$Builder;

    move-result-object v0

    iget-object v1, p2, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v1, v1, Lanet/channel/strategy/l$a;->c:I

    .line 168
    invoke-virtual {v0, v1}, Lanet/channel/request/Request$Builder;->setConnectTimeout(I)Lanet/channel/request/Request$Builder;

    move-result-object v0

    iget-object v1, p2, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v1, v1, Lanet/channel/strategy/l$a;->d:I

    .line 169
    invoke-virtual {v0, v1}, Lanet/channel/request/Request$Builder;->setReadTimeout(I)Lanet/channel/request/Request$Builder;

    move-result-object v0

    const/4 v1, 0x0

    .line 170
    invoke-virtual {v0, v1}, Lanet/channel/request/Request$Builder;->setRedirectEnable(Z)Lanet/channel/request/Request$Builder;

    move-result-object v0

    new-instance v2, Lanet/channel/util/j;

    invoke-direct {v2, p1}, Lanet/channel/util/j;-><init>(Ljava/lang/String;)V

    .line 171
    invoke-virtual {v0, v2}, Lanet/channel/request/Request$Builder;->setSslSocketFactory(Ljavax/net/ssl/SSLSocketFactory;)Lanet/channel/request/Request$Builder;

    move-result-object v0

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "HR"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lanet/channel/detect/d;->b:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 172
    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndIncrement()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lanet/channel/request/Request$Builder;->setSeq(Ljava/lang/String;)Lanet/channel/request/Request$Builder;

    move-result-object v0

    .line 173
    invoke-virtual {v0}, Lanet/channel/request/Request$Builder;->build()Lanet/channel/request/Request;

    move-result-object v0

    .line 174
    iget-object v2, p2, Lanet/channel/strategy/l$e;->a:Ljava/lang/String;

    iget-object v3, p2, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v3, v3, Lanet/channel/strategy/l$a;->a:I

    invoke-virtual {v0, v2, v3}, Lanet/channel/request/Request;->setDnsOptimize(Ljava/lang/String;I)V

    .line 176
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    .line 1069
    invoke-static {v0, v4}, Lanet/channel/session/b;->a(Lanet/channel/request/Request;Lanet/channel/RequestCb;)Lanet/channel/session/b$a;

    move-result-object v0

    .line 178
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    sub-long/2addr v4, v2

    .line 180
    new-instance v2, Lanet/channel/statist/HorseRaceStat;

    invoke-direct {v2, p1, p2}, Lanet/channel/statist/HorseRaceStat;-><init>(Ljava/lang/String;Lanet/channel/strategy/l$e;)V

    .line 181
    iput-wide v4, v2, Lanet/channel/statist/HorseRaceStat;->connTime:J

    .line 182
    iget p1, v0, Lanet/channel/session/b$a;->a:I

    if-gtz p1, :cond_1

    .line 183
    iget p1, v0, Lanet/channel/session/b$a;->a:I

    iput p1, v2, Lanet/channel/statist/HorseRaceStat;->connErrorCode:I

    goto :goto_0

    :cond_1
    const/4 p1, 0x1

    .line 185
    iput p1, v2, Lanet/channel/statist/HorseRaceStat;->connRet:I

    .line 186
    iget v3, v0, Lanet/channel/session/b$a;->a:I

    const/16 v4, 0xc8

    if-ne v3, v4, :cond_2

    move v1, p1

    :cond_2
    iput v1, v2, Lanet/channel/statist/HorseRaceStat;->reqRet:I

    .line 187
    iget p1, v0, Lanet/channel/session/b$a;->a:I

    iput p1, v2, Lanet/channel/statist/HorseRaceStat;->reqErrorCode:I

    .line 188
    iget-wide v0, v2, Lanet/channel/statist/HorseRaceStat;->connTime:J

    iput-wide v0, v2, Lanet/channel/statist/HorseRaceStat;->reqTime:J

    .line 191
    :goto_0
    iget-object p1, p2, Lanet/channel/strategy/l$e;->a:Ljava/lang/String;

    invoke-direct {p0, p1, v2}, Lanet/channel/detect/d;->a(Ljava/lang/String;Lanet/channel/statist/HorseRaceStat;)V

    .line 192
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    invoke-interface {p1, v2}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    return-void
.end method

.method private b(Ljava/lang/String;Lanet/channel/strategy/l$e;)V
    .locals 16

    move-object/from16 v9, p0

    move-object/from16 v0, p1

    move-object/from16 v10, p2

    .line 196
    iget-object v1, v10, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    invoke-static {v1}, Lanet/channel/strategy/ConnProtocol;->valueOf(Lanet/channel/strategy/l$a;)Lanet/channel/strategy/ConnProtocol;

    move-result-object v11

    .line 197
    invoke-static {v11}, Lanet/channel/entity/ConnType;->valueOf(Lanet/channel/strategy/ConnProtocol;)Lanet/channel/entity/ConnType;

    move-result-object v12

    if-nez v12, :cond_0

    return-void

    :cond_0
    const-string v13, "anet.HorseRaceDetector"

    const-string v14, "startLongLinkTask"

    const-string v1, "host"

    const-string v3, "ip"

    .line 202
    iget-object v4, v10, Lanet/channel/strategy/l$e;->a:Ljava/lang/String;

    const-string v5, "port"

    iget-object v2, v10, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v2, v2, Lanet/channel/strategy/l$a;->a:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const-string v7, "protocol"

    move-object/from16 v2, p1

    move-object v8, v11

    filled-new-array/range {v1 .. v8}, [Ljava/lang/Object;

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v13, v14, v2, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 204
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "HR"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, v9, Lanet/channel/detect/d;->b:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndIncrement()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 205
    new-instance v13, Lanet/channel/session/TnetSpdySession;

    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getContext()Landroid/content/Context;

    move-result-object v1

    new-instance v2, Lanet/channel/entity/a;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 206
    invoke-virtual {v12}, Lanet/channel/entity/ConnType;->isSSL()Z

    move-result v4

    if-eqz v4, :cond_1

    const-string v4, "https://"

    goto :goto_0

    :cond_1
    const-string v4, "http://"

    :goto_0
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v11, v10}, Lanet/channel/detect/d;->a(Lanet/channel/strategy/ConnProtocol;Lanet/channel/strategy/l$e;)Lanet/channel/strategy/IConnStrategy;

    move-result-object v4

    invoke-direct {v2, v3, v6, v4}, Lanet/channel/entity/a;-><init>(Ljava/lang/String;Ljava/lang/String;Lanet/channel/strategy/IConnStrategy;)V

    invoke-direct {v13, v1, v2}, Lanet/channel/session/TnetSpdySession;-><init>(Landroid/content/Context;Lanet/channel/entity/a;)V

    .line 208
    new-instance v11, Lanet/channel/statist/HorseRaceStat;

    invoke-direct {v11, v0, v10}, Lanet/channel/statist/HorseRaceStat;-><init>(Ljava/lang/String;Lanet/channel/strategy/l$e;)V

    .line 209
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v14

    .line 210
    new-instance v0, Lanet/channel/detect/h;

    move-object v1, v0

    move-object/from16 v2, p0

    move-object v3, v11

    move-wide v4, v14

    move-object/from16 v7, p2

    move-object v8, v13

    invoke-direct/range {v1 .. v8}, Lanet/channel/detect/h;-><init>(Lanet/channel/detect/d;Lanet/channel/statist/HorseRaceStat;JLjava/lang/String;Lanet/channel/strategy/l$e;Lanet/channel/session/TnetSpdySession;)V

    const/16 v1, 0x101

    invoke-virtual {v13, v1, v0}, Lanet/channel/session/TnetSpdySession;->registerEventcb(ILanet/channel/entity/EventCb;)V

    .line 271
    invoke-virtual {v13}, Lanet/channel/session/TnetSpdySession;->connect()V

    .line 272
    monitor-enter v11

    .line 274
    :try_start_0
    iget-object v0, v10, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v0, v0, Lanet/channel/strategy/l$a;->c:I

    if-nez v0, :cond_2

    const/16 v0, 0x2710

    goto :goto_1

    :cond_2
    iget-object v0, v10, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v0, v0, Lanet/channel/strategy/l$a;->c:I

    :goto_1
    int-to-long v0, v0

    .line 275
    invoke-virtual {v11, v0, v1}, Ljava/lang/Object;->wait(J)V

    .line 276
    iget-wide v0, v11, Lanet/channel/statist/HorseRaceStat;->connTime:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-nez v0, :cond_3

    .line 277
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sub-long/2addr v0, v14

    iput-wide v0, v11, Lanet/channel/statist/HorseRaceStat;->connTime:J

    .line 280
    :cond_3
    iget-object v0, v10, Lanet/channel/strategy/l$e;->a:Ljava/lang/String;

    invoke-direct {v9, v0, v11}, Lanet/channel/detect/d;->a(Ljava/lang/String;Lanet/channel/statist/HorseRaceStat;)V

    .line 281
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v0

    invoke-interface {v0, v11}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception v0

    goto :goto_3

    .line 284
    :catch_0
    :goto_2
    :try_start_1
    monitor-exit v11
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    const/4 v0, 0x0

    .line 285
    invoke-virtual {v13, v0}, Lanet/channel/session/TnetSpdySession;->close(Z)V

    return-void

    .line 284
    :goto_3
    :try_start_2
    monitor-exit v11
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method private c(Ljava/lang/String;Lanet/channel/strategy/l$e;)V
    .locals 7

    .line 338
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "HR"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lanet/channel/detect/d;->b:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicInteger;->getAndIncrement()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 339
    iget-object v1, p2, Lanet/channel/strategy/l$e;->a:Ljava/lang/String;

    iget-object v2, p2, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v2, v2, Lanet/channel/strategy/l$a;->a:I

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "ip"

    const-string v4, "port"

    filled-new-array {v3, v1, v4, v2}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "anet.HorseRaceDetector"

    const-string v3, "startTcpTask"

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 341
    new-instance v1, Lanet/channel/statist/HorseRaceStat;

    invoke-direct {v1, p1, p2}, Lanet/channel/statist/HorseRaceStat;-><init>(Ljava/lang/String;Lanet/channel/strategy/l$e;)V

    .line 342
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    .line 344
    :try_start_0
    new-instance p1, Ljava/net/Socket;

    iget-object v5, p2, Lanet/channel/strategy/l$e;->a:Ljava/lang/String;

    iget-object v6, p2, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v6, v6, Lanet/channel/strategy/l$a;->a:I

    invoke-direct {p1, v5, v6}, Ljava/net/Socket;-><init>(Ljava/lang/String;I)V

    .line 345
    iget-object v5, p2, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget v5, v5, Lanet/channel/strategy/l$a;->c:I

    if-nez v5, :cond_0

    const/16 p2, 0x2710

    goto :goto_0

    :cond_0
    iget-object p2, p2, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    iget p2, p2, Lanet/channel/strategy/l$a;->c:I

    :goto_0
    invoke-virtual {p1, p2}, Ljava/net/Socket;->setSoTimeout(I)V

    const-string p2, "socket connect success"

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Object;

    .line 346
    invoke-static {v2, p2, v0, v5}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 p2, 0x1

    .line 347
    iput p2, v1, Lanet/channel/statist/HorseRaceStat;->connRet:I

    .line 348
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    sub-long/2addr v5, v3

    iput-wide v5, v1, Lanet/channel/statist/HorseRaceStat;->connTime:J

    .line 349
    invoke-virtual {p1}, Ljava/net/Socket;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 351
    :catch_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    sub-long/2addr p1, v3

    iput-wide p1, v1, Lanet/channel/statist/HorseRaceStat;->connTime:J

    const/16 p1, -0x194

    .line 352
    iput p1, v1, Lanet/channel/statist/HorseRaceStat;->connErrorCode:I

    .line 354
    :goto_1
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object p1

    invoke-interface {p1, v1}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    return-void
.end method


# virtual methods
.method a()V
    .locals 6

    const-string v0, "anet.HorseRaceDetector"

    const-string v1, "network detect thread start"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    const/4 v4, 0x0

    .line 59
    invoke-static {v0, v1, v4, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :goto_0
    iget-object v0, p0, Lanet/channel/detect/d;->a:Ljava/util/TreeMap;

    .line 62
    monitor-enter v0

    .line 63
    :try_start_0
    invoke-static {}, Lanet/channel/AwcnConfig;->isHorseRaceEnable()Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lanet/channel/detect/d;->a:Ljava/util/TreeMap;

    .line 64
    invoke-virtual {v1}, Ljava/util/TreeMap;->clear()V

    .line 65
    monitor-exit v0

    goto :goto_1

    :cond_0
    iget-object v1, p0, Lanet/channel/detect/d;->a:Ljava/util/TreeMap;

    .line 67
    invoke-virtual {v1}, Ljava/util/TreeMap;->pollFirstEntry()Ljava/util/Map$Entry;

    move-result-object v1

    .line 68
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_1

    :goto_1
    return-void

    .line 74
    :cond_1
    :try_start_1
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lanet/channel/strategy/l$c;

    .line 75
    invoke-direct {p0, v0}, Lanet/channel/detect/d;->a(Lanet/channel/strategy/l$c;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "anet.HorseRaceDetector"

    const-string v3, "start hr task failed"

    new-array v5, v2, [Ljava/lang/Object;

    .line 77
    invoke-static {v1, v3, v4, v0, v5}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto :goto_0

    :catchall_0
    move-exception v1

    .line 68
    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method

.method public b()V
    .locals 2

    .line 86
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object v0

    new-instance v1, Lanet/channel/detect/e;

    invoke-direct {v1, p0}, Lanet/channel/detect/e;-><init>(Lanet/channel/detect/d;)V

    invoke-interface {v0, v1}, Lanet/channel/strategy/IStrategyInstance;->registerListener(Lanet/channel/strategy/IStrategyListener;)V

    .line 105
    new-instance v0, Lanet/channel/detect/f;

    invoke-direct {v0, p0}, Lanet/channel/detect/f;-><init>(Lanet/channel/detect/d;)V

    invoke-static {v0}, Lanet/channel/util/AppLifecycle;->registerLifecycleListener(Lanet/channel/util/AppLifecycle$AppLifecycleListener;)V

    return-void
.end method
