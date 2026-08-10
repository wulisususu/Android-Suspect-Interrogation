.class Lanet/channel/detect/ExceptionDetector;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lanet/channel/detect/ExceptionDetector$a;,
        Lanet/channel/detect/ExceptionDetector$LimitedQueue;
    }
.end annotation


# instance fields
.field a:J

.field b:Ljava/lang/String;

.field c:Ljava/lang/String;

.field d:Ljava/lang/String;

.field e:Lanet/channel/detect/ExceptionDetector$LimitedQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lanet/channel/detect/ExceptionDetector$LimitedQueue<",
            "Landroid/util/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>()V
    .locals 2

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 51
    new-instance v0, Lanet/channel/detect/ExceptionDetector$LimitedQueue;

    const/16 v1, 0xa

    invoke-direct {v0, p0, v1}, Lanet/channel/detect/ExceptionDetector$LimitedQueue;-><init>(Lanet/channel/detect/ExceptionDetector;I)V

    iput-object v0, p0, Lanet/channel/detect/ExceptionDetector;->e:Lanet/channel/detect/ExceptionDetector$LimitedQueue;

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;)Lanet/channel/detect/ExceptionDetector$a;
    .locals 7

    .line 245
    new-instance v0, Lanet/channel/detect/ExceptionDetector$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lanet/channel/detect/ExceptionDetector$a;-><init>(Lanet/channel/detect/ExceptionDetector;Lanet/channel/detect/a;)V

    .line 246
    iput-object p1, v0, Lanet/channel/detect/ExceptionDetector$a;->a:Ljava/lang/String;

    .line 248
    :try_start_0
    invoke-static {p1}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v1

    .line 249
    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lanet/channel/detect/ExceptionDetector$a;->b:Ljava/lang/String;
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    .line 252
    :catch_0
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 253
    iput-object p2, v0, Lanet/channel/detect/ExceptionDetector$a;->c:Ljava/lang/String;

    goto :goto_0

    .line 255
    :cond_0
    invoke-static {}, Lanet/channel/strategy/StrategyCenter;->getInstance()Lanet/channel/strategy/IStrategyInstance;

    move-result-object p2

    invoke-interface {p2, p1}, Lanet/channel/strategy/IStrategyInstance;->getConnStrategyListByHost(Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_1

    .line 256
    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result p2

    if-nez p2, :cond_1

    const/4 p2, 0x0

    .line 257
    invoke-interface {p1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lanet/channel/strategy/IConnStrategy;

    invoke-interface {p1}, Lanet/channel/strategy/IConnStrategy;->getIp()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lanet/channel/detect/ExceptionDetector$a;->c:Ljava/lang/String;

    .line 260
    :cond_1
    :goto_0
    iget-object p1, v0, Lanet/channel/detect/ExceptionDetector$a;->c:Ljava/lang/String;

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, v0, Lanet/channel/detect/ExceptionDetector$a;->c:Ljava/lang/String;

    goto :goto_1

    :cond_2
    iget-object p1, v0, Lanet/channel/detect/ExceptionDetector$a;->b:Ljava/lang/String;

    .line 261
    :goto_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p2

    if-nez p2, :cond_3

    .line 262
    new-instance p2, Lorg/android/netutil/PingTask;

    const/16 v3, 0x3e8

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, p2

    move-object v2, p1

    invoke-direct/range {v1 .. v6}, Lorg/android/netutil/PingTask;-><init>(Ljava/lang/String;IIII)V

    invoke-virtual {p2}, Lorg/android/netutil/PingTask;->launch()Ljava/util/concurrent/Future;

    move-result-object p2

    iput-object p2, v0, Lanet/channel/detect/ExceptionDetector$a;->d:Ljava/util/concurrent/Future;

    .line 263
    new-instance p2, Lorg/android/netutil/PingTask;

    const/16 v5, 0x494

    move-object v1, p2

    invoke-direct/range {v1 .. v6}, Lorg/android/netutil/PingTask;-><init>(Ljava/lang/String;IIII)V

    invoke-virtual {p2}, Lorg/android/netutil/PingTask;->launch()Ljava/util/concurrent/Future;

    move-result-object p2

    iput-object p2, v0, Lanet/channel/detect/ExceptionDetector$a;->e:Ljava/util/concurrent/Future;

    .line 264
    new-instance p2, Lorg/android/netutil/PingTask;

    const/16 v5, 0x598

    move-object v1, p2

    invoke-direct/range {v1 .. v6}, Lorg/android/netutil/PingTask;-><init>(Ljava/lang/String;IIII)V

    invoke-virtual {p2}, Lorg/android/netutil/PingTask;->launch()Ljava/util/concurrent/Future;

    move-result-object p1

    iput-object p1, v0, Lanet/channel/detect/ExceptionDetector$a;->f:Ljava/util/concurrent/Future;

    :cond_3
    return-object v0
.end method

.method private a(Ljava/lang/String;I)Ljava/util/ArrayList;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "I)",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 217
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 218
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-object v0

    :cond_0
    const/4 v1, 0x0

    move v2, v1

    :goto_0
    if-ge v2, p2, :cond_3

    .line 222
    new-instance v9, Lorg/android/netutil/PingTask;

    const/4 v5, 0x0

    const/4 v6, 0x1

    const/4 v7, 0x0

    add-int/lit8 v2, v2, 0x1

    move-object v3, v9

    move-object v4, p1

    move v8, v2

    invoke-direct/range {v3 .. v8}, Lorg/android/netutil/PingTask;-><init>(Ljava/lang/String;IIII)V

    .line 223
    invoke-virtual {v9}, Lorg/android/netutil/PingTask;->launch()Ljava/util/concurrent/Future;

    move-result-object v3

    .line 226
    :try_start_0
    invoke-interface {v3}, Ljava/util/concurrent/Future;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/android/netutil/PingResponse;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    const/4 v3, 0x0

    .line 229
    :goto_1
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    if-eqz v3, :cond_2

    .line 231
    invoke-virtual {v3}, Lorg/android/netutil/PingResponse;->getLastHopIPStr()Ljava/lang/String;

    move-result-object v5

    .line 232
    invoke-virtual {v3}, Lorg/android/netutil/PingResponse;->getResults()[Lorg/android/netutil/PingEntry;

    move-result-object v6

    aget-object v6, v6, v1

    iget-wide v6, v6, Lorg/android/netutil/PingEntry;->rtt:D

    .line 233
    invoke-virtual {v3}, Lorg/android/netutil/PingResponse;->getErrcode()I

    move-result v3

    .line 234
    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v8

    if-eqz v8, :cond_1

    const-string v5, "*"

    :cond_1
    const-string v8, "hop="

    .line 237
    invoke-virtual {v4, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v8, ",rtt="

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v6, v7}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, ",errCode="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 239
    :cond_2
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    return-object v0
.end method

.method private a(Lanet/channel/detect/ExceptionDetector$a;)Lorg/json/JSONObject;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 270
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    if-eqz p1, :cond_3

    .line 271
    iget-object v1, p1, Lanet/channel/detect/ExceptionDetector$a;->d:Ljava/util/concurrent/Future;

    if-nez v1, :cond_0

    goto/16 :goto_2

    :cond_0
    const-string v1, "host"

    .line 276
    iget-object v2, p1, Lanet/channel/detect/ExceptionDetector$a;->a:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "currentIp"

    .line 277
    iget-object v2, p1, Lanet/channel/detect/ExceptionDetector$a;->c:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "localIp"

    .line 278
    iget-object v2, p1, Lanet/channel/detect/ExceptionDetector$a;->b:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 280
    iget-object v1, p1, Lanet/channel/detect/ExceptionDetector$a;->d:Ljava/util/concurrent/Future;

    invoke-direct {p0, v1}, Lanet/channel/detect/ExceptionDetector;->a(Ljava/util/concurrent/Future;)Lorg/json/JSONObject;

    move-result-object v1

    const-string v2, "ping"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 283
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 285
    iget-object v2, p1, Lanet/channel/detect/ExceptionDetector$a;->e:Ljava/util/concurrent/Future;

    invoke-direct {p0, v2}, Lanet/channel/detect/ExceptionDetector;->a(Ljava/util/concurrent/Future;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "1200"

    invoke-virtual {v1, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 287
    iget-object v2, p1, Lanet/channel/detect/ExceptionDetector$a;->f:Ljava/util/concurrent/Future;

    invoke-direct {p0, v2}, Lanet/channel/detect/ExceptionDetector;->a(Ljava/util/concurrent/Future;)Lorg/json/JSONObject;

    move-result-object v2

    const-string v3, "1460"

    invoke-virtual {v1, v3, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v2, "MTU"

    .line 288
    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "guide-acs.m.taobao.com"

    .line 291
    iget-object v2, p1, Lanet/channel/detect/ExceptionDetector$a;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 292
    iget-object v1, p1, Lanet/channel/detect/ExceptionDetector$a;->c:Ljava/lang/String;

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object p1, p1, Lanet/channel/detect/ExceptionDetector$a;->c:Ljava/lang/String;

    goto :goto_0

    :cond_1
    iget-object p1, p1, Lanet/channel/detect/ExceptionDetector$a;->b:Ljava/lang/String;

    :goto_0
    const/4 v1, 0x5

    .line 293
    invoke-direct {p0, p1, v1}, Lanet/channel/detect/ExceptionDetector;->a(Ljava/lang/String;I)Ljava/util/ArrayList;

    move-result-object p1

    .line 294
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    const/4 v2, 0x0

    .line 295
    :goto_1
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_2

    add-int/lit8 v3, v2, 0x1

    .line 296
    invoke-static {v3}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    move v2, v3

    goto :goto_1

    :cond_2
    const-string p1, "traceRoute"

    .line 298
    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_3
    :goto_2
    return-object v0
.end method

.method private a(Ljava/util/concurrent/Future;)Lorg/json/JSONObject;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/concurrent/Future<",
            "Lorg/android/netutil/PingResponse;",
            ">;)",
            "Lorg/json/JSONObject;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 305
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    if-nez p1, :cond_0

    return-object v0

    .line 311
    :cond_0
    :try_start_0
    invoke-interface {p1}, Ljava/util/concurrent/Future;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/android/netutil/PingResponse;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 p1, 0x0

    :goto_0
    if-nez p1, :cond_1

    return-object v0

    :cond_1
    const-string v1, "errCode"

    .line 318
    invoke-virtual {p1}, Lorg/android/netutil/PingResponse;->getErrcode()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 319
    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    .line 320
    invoke-virtual {p1}, Lorg/android/netutil/PingResponse;->getResults()[Lorg/android/netutil/PingEntry;

    move-result-object p1

    .line 321
    array-length v2, p1

    const/4 v3, 0x0

    :goto_1
    if-ge v3, v2, :cond_2

    aget-object v4, p1, v3

    .line 322
    new-instance v5, Ljava/lang/StringBuilder;

    const-string v6, "seq="

    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 323
    iget v6, v4, Lorg/android/netutil/PingEntry;->seq:I

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ",hop="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget v7, v4, Lorg/android/netutil/PingEntry;->hop:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ",rtt="

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-wide v7, v4, Lorg/android/netutil/PingEntry;->rtt:D

    invoke-virtual {v6, v7, v8}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    .line 324
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_2
    const-string p1, "response"

    .line 326
    invoke-virtual {v0, p1, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    return-object v0
.end method


# virtual methods
.method public a()V
    .locals 1

    .line 57
    new-instance v0, Lanet/channel/detect/a;

    invoke-direct {v0, p0}, Lanet/channel/detect/a;-><init>(Lanet/channel/detect/ExceptionDetector;)V

    invoke-static {v0}, Lanet/channel/status/NetworkStatusHelper;->addStatusChangeListener(Lanet/channel/status/NetworkStatusHelper$INetworkStatusChangeListener;)V

    return-void
.end method

.method public a(Lanet/channel/statist/RequestStatistic;)V
    .locals 3

    .line 76
    invoke-static {}, Lanet/channel/AwcnConfig;->isNetworkDetectEnable()Z

    move-result v0

    if-nez v0, :cond_0

    const/4 p1, 0x0

    new-array p1, p1, [Ljava/lang/Object;

    const-string v0, "anet.ExceptionDetector"

    const-string v1, "network detect closed."

    const/4 v2, 0x0

    .line 77
    invoke-static {v0, v1, v2, p1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 81
    :cond_0
    new-instance v0, Lanet/channel/detect/c;

    invoke-direct {v0, p0, p1}, Lanet/channel/detect/c;-><init>(Lanet/channel/detect/ExceptionDetector;Lanet/channel/statist/RequestStatistic;)V

    invoke-static {v0}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitDetectTask(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method

.method b()V
    .locals 12
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    const/4 v0, 0x0

    new-array v1, v0, [Ljava/lang/Object;

    const-string v2, "anet.ExceptionDetector"

    const-string v3, "network detect start."

    const/4 v4, 0x0

    .line 113
    invoke-static {v2, v3, v4, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 114
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->getContext()Landroid/content/Context;

    move-result-object v1

    sget-object v3, Lorg/android/spdy/SpdyVersion;->SPDY3:Lorg/android/spdy/SpdyVersion;

    sget-object v5, Lorg/android/spdy/SpdySessionKind;->NONE_SESSION:Lorg/android/spdy/SpdySessionKind;

    invoke-static {v1, v3, v5}, Lorg/android/spdy/SpdyAgent;->getInstance(Landroid/content/Context;Lorg/android/spdy/SpdyVersion;Lorg/android/spdy/SpdySessionKind;)Lorg/android/spdy/SpdyAgent;

    .line 115
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 118
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 119
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getStatus()Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    move-result-object v5

    const-string v6, "status"

    .line 120
    invoke-virtual {v5}, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->getType()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v6, "subType"

    .line 121
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getNetworkSubType()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 122
    sget-object v6, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->NO:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    if-eq v5, v6, :cond_1

    .line 123
    invoke-virtual {v5}, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->isMobile()Z

    move-result v6

    if-eqz v6, :cond_0

    const-string v6, "apn"

    .line 124
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getApn()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v6, "carrier"

    .line 125
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getCarrier()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    :cond_0
    const-string v6, "bssid"

    .line 127
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getWifiBSSID()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v6, "ssid"

    .line 128
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getWifiSSID()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :goto_0
    const-string v6, "proxy"

    .line 130
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getProxyType()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v3, v6, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_1
    const-string v6, "NetworkInfo"

    .line 132
    invoke-virtual {v1, v6, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 136
    invoke-virtual {v5}, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->isWifi()Z

    move-result v3

    const-string v5, "114.114.114.114"

    if-eqz v3, :cond_2

    invoke-static {v5}, Lorg/android/netutil/NetUtils;->getDefaultGateway(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_2
    const/4 v3, 0x2

    invoke-static {v5, v3}, Lorg/android/netutil/NetUtils;->getPreferNextHop(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v3

    .line 138
    :goto_1
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    if-nez v5, :cond_3

    .line 139
    new-instance v11, Lorg/android/netutil/PingTask;

    const/16 v7, 0x3e8

    const/4 v8, 0x3

    const/4 v9, 0x0

    const/4 v10, 0x0

    move-object v5, v11

    move-object v6, v3

    invoke-direct/range {v5 .. v10}, Lorg/android/netutil/PingTask;-><init>(Ljava/lang/String;IIII)V

    invoke-virtual {v11}, Lorg/android/netutil/PingTask;->launch()Ljava/util/concurrent/Future;

    move-result-object v5

    goto :goto_2

    :cond_3
    move-object v5, v4

    :goto_2
    const-string v6, "guide-acs.m.taobao.com"

    iget-object v7, p0, Lanet/channel/detect/ExceptionDetector;->b:Ljava/lang/String;

    .line 143
    invoke-direct {p0, v6, v7}, Lanet/channel/detect/ExceptionDetector;->a(Ljava/lang/String;Ljava/lang/String;)Lanet/channel/detect/ExceptionDetector$a;

    move-result-object v6

    const-string v7, "gw.alicdn.com"

    iget-object v8, p0, Lanet/channel/detect/ExceptionDetector;->d:Ljava/lang/String;

    .line 144
    invoke-direct {p0, v7, v8}, Lanet/channel/detect/ExceptionDetector;->a(Ljava/lang/String;Ljava/lang/String;)Lanet/channel/detect/ExceptionDetector$a;

    move-result-object v7

    const-string v8, "msgacs.m.taobao.com"

    iget-object v9, p0, Lanet/channel/detect/ExceptionDetector;->c:Ljava/lang/String;

    .line 145
    invoke-direct {p0, v8, v9}, Lanet/channel/detect/ExceptionDetector;->a(Ljava/lang/String;Ljava/lang/String;)Lanet/channel/detect/ExceptionDetector$a;

    move-result-object v8

    .line 148
    new-instance v9, Lorg/json/JSONObject;

    invoke-direct {v9}, Lorg/json/JSONObject;-><init>()V

    const-string v10, "nextHop"

    .line 149
    invoke-virtual {v9, v10, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v3, "ping"

    .line 150
    invoke-direct {p0, v5}, Lanet/channel/detect/ExceptionDetector;->a(Ljava/util/concurrent/Future;)Lorg/json/JSONObject;

    move-result-object v5

    invoke-virtual {v9, v3, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v3, "LocalDetect"

    .line 151
    invoke-virtual {v1, v3, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 154
    new-instance v3, Lorg/json/JSONArray;

    invoke-direct {v3}, Lorg/json/JSONArray;-><init>()V

    .line 155
    invoke-direct {p0, v6}, Lanet/channel/detect/ExceptionDetector;->a(Lanet/channel/detect/ExceptionDetector$a;)Lorg/json/JSONObject;

    move-result-object v5

    invoke-virtual {v3, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 156
    invoke-direct {p0, v7}, Lanet/channel/detect/ExceptionDetector;->a(Lanet/channel/detect/ExceptionDetector$a;)Lorg/json/JSONObject;

    move-result-object v5

    invoke-virtual {v3, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    .line 157
    invoke-direct {p0, v8}, Lanet/channel/detect/ExceptionDetector;->a(Lanet/channel/detect/ExceptionDetector$a;)Lorg/json/JSONObject;

    move-result-object v5

    invoke-virtual {v3, v5}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    const-string v5, "InternetDetect"

    .line 158
    invoke-virtual {v1, v5, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 161
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    iget-object v5, p0, Lanet/channel/detect/ExceptionDetector;->e:Lanet/channel/detect/ExceptionDetector$LimitedQueue;

    .line 162
    invoke-virtual {v5}, Lanet/channel/detect/ExceptionDetector$LimitedQueue;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_3
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_4

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/util/Pair;

    .line 163
    iget-object v7, v6, Landroid/util/Pair;->first:Ljava/lang/Object;

    check-cast v7, Ljava/lang/String;

    iget-object v6, v6, Landroid/util/Pair;->second:Ljava/lang/Object;

    invoke-virtual {v3, v7, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_3

    :cond_4
    const-string v5, "BizDetect"

    .line 165
    invoke-virtual {v1, v5, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    iget-object v3, p0, Lanet/channel/detect/ExceptionDetector;->e:Lanet/channel/detect/ExceptionDetector$LimitedQueue;

    .line 166
    invoke-virtual {v3}, Lanet/channel/detect/ExceptionDetector$LimitedQueue;->clear()V

    .line 169
    new-instance v3, Ljava/lang/StringBuilder;

    const-string v5, "network detect result: "

    invoke-direct {v3, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-array v0, v0, [Ljava/lang/Object;

    invoke-static {v2, v1, v4, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method c()Z
    .locals 8

    iget-object v0, p0, Lanet/channel/detect/ExceptionDetector;->e:Lanet/channel/detect/ExceptionDetector$LimitedQueue;

    .line 177
    invoke-virtual {v0}, Lanet/channel/detect/ExceptionDetector$LimitedQueue;->size()I

    move-result v0

    const/4 v1, 0x0

    const/16 v2, 0xa

    if-eq v0, v2, :cond_0

    return v1

    .line 181
    :cond_0
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getStatus()Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    move-result-object v0

    sget-object v3, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->NO:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    if-ne v0, v3, :cond_1

    const/4 v0, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    const-string v3, "anet.ExceptionDetector"

    const-string v4, "no network"

    .line 182
    invoke-static {v3, v4, v0, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return v1

    .line 186
    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iget-wide v5, p0, Lanet/channel/detect/ExceptionDetector;->a:J

    cmp-long v0, v3, v5

    if-gez v0, :cond_2

    return v1

    :cond_2
    iget-object v0, p0, Lanet/channel/detect/ExceptionDetector;->e:Lanet/channel/detect/ExceptionDetector$LimitedQueue;

    .line 192
    invoke-virtual {v0}, Lanet/channel/detect/ExceptionDetector$LimitedQueue;->iterator()Ljava/util/Iterator;

    move-result-object v0

    move v5, v1

    :cond_3
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/util/Pair;

    .line 193
    iget-object v6, v6, Landroid/util/Pair;->second:Ljava/lang/Object;

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    const/16 v7, -0xca

    if-eq v6, v7, :cond_4

    const/16 v7, -0x190

    if-eq v6, v7, :cond_4

    const/16 v7, -0x191

    if-eq v6, v7, :cond_4

    const/16 v7, -0x195

    if-eq v6, v7, :cond_4

    const/16 v7, -0x196

    if-ne v6, v7, :cond_3

    :cond_4
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :cond_5
    mul-int/lit8 v5, v5, 0x2

    if-le v5, v2, :cond_6

    const/4 v1, 0x1

    :cond_6
    if-eqz v1, :cond_7

    const-wide/32 v5, 0x1b7740

    add-long/2addr v3, v5

    iput-wide v3, p0, Lanet/channel/detect/ExceptionDetector;->a:J

    :cond_7
    return v1
.end method
