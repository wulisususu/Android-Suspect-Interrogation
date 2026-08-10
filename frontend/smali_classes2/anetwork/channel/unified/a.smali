.class public Lanetwork/channel/unified/a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanetwork/channel/unified/IUnifiedTask;


# instance fields
.field private a:Lanetwork/channel/unified/j;

.field private b:Lanetwork/channel/cache/Cache;

.field private volatile c:Z


# direct methods
.method public constructor <init>(Lanetwork/channel/unified/j;Lanetwork/channel/cache/Cache;)V
    .locals 1

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    iput-object v0, p0, Lanetwork/channel/unified/a;->b:Lanetwork/channel/cache/Cache;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lanetwork/channel/unified/a;->c:Z

    iput-object p1, p0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    iput-object p2, p0, Lanetwork/channel/unified/a;->b:Lanetwork/channel/cache/Cache;

    return-void
.end method


# virtual methods
.method public cancel()V
    .locals 2

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanetwork/channel/unified/a;->c:Z

    iget-object v0, p0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 30
    iget-object v0, v0, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    iget-object v0, v0, Lanetwork/channel/entity/g;->b:Lanet/channel/statist/RequestStatistic;

    const/4 v1, 0x2

    iput v1, v0, Lanet/channel/statist/RequestStatistic;->ret:I

    return-void
.end method

.method public run()V
    .locals 17

    move-object/from16 v0, p0

    iget-boolean v1, v0, Lanetwork/channel/unified/a;->c:Z

    if-eqz v1, :cond_0

    return-void

    :cond_0
    iget-object v1, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 40
    iget-object v1, v1, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    iget-object v1, v1, Lanetwork/channel/entity/g;->b:Lanet/channel/statist/RequestStatistic;

    iget-object v2, v0, Lanetwork/channel/unified/a;->b:Lanetwork/channel/cache/Cache;

    if-eqz v2, :cond_a

    iget-object v2, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 43
    iget-object v2, v2, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v2}, Lanetwork/channel/entity/g;->g()Ljava/lang/String;

    move-result-object v2

    iget-object v3, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 44
    iget-object v3, v3, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v3}, Lanetwork/channel/entity/g;->a()Lanet/channel/request/Request;

    move-result-object v3

    .line 45
    invoke-virtual {v3}, Lanet/channel/request/Request;->getHeaders()Ljava/util/Map;

    move-result-object v4

    const-string v5, "Cache-Control"

    invoke-interface {v4, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    const-string v5, "no-store"

    .line 47
    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    .line 50
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v6

    const-string v8, "anet.CacheTask"

    const/4 v10, 0x2

    const/4 v11, 0x1

    const/4 v12, 0x0

    if-eqz v5, :cond_1

    iget-object v4, v0, Lanetwork/channel/unified/a;->b:Lanetwork/channel/cache/Cache;

    .line 53
    invoke-interface {v4, v2}, Lanetwork/channel/cache/Cache;->remove(Ljava/lang/String;)V

    move v4, v12

    const/4 v13, 0x0

    goto :goto_2

    :cond_1
    const-string v13, "no-cache"

    .line 55
    invoke-virtual {v13, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    iget-object v13, v0, Lanetwork/channel/unified/a;->b:Lanetwork/channel/cache/Cache;

    .line 56
    invoke-interface {v13, v2}, Lanetwork/channel/cache/Cache;->get(Ljava/lang/String;)Lanetwork/channel/cache/Cache$Entry;

    move-result-object v13

    .line 58
    invoke-static {v10}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v14

    if-eqz v14, :cond_4

    iget-object v14, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 59
    iget-object v14, v14, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    const/16 v15, 0x8

    new-array v15, v15, [Ljava/lang/Object;

    const-string v16, "hit"

    aput-object v16, v15, v12

    if-eqz v13, :cond_2

    move/from16 v16, v11

    goto :goto_0

    :cond_2
    move/from16 v16, v12

    :goto_0
    invoke-static/range {v16 .. v16}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v16

    aput-object v16, v15, v11

    const-string v16, "cost"

    aput-object v16, v15, v10

    iget-wide v9, v1, Lanet/channel/statist/RequestStatistic;->cacheTime:J

    invoke-static {v9, v10}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v9

    const/4 v10, 0x3

    aput-object v9, v15, v10

    const/4 v9, 0x4

    const-string v10, "length"

    aput-object v10, v15, v9

    if-eqz v13, :cond_3

    iget-object v9, v13, Lanetwork/channel/cache/Cache$Entry;->data:[B

    array-length v9, v9

    goto :goto_1

    :cond_3
    move v9, v12

    .line 60
    :goto_1
    invoke-static {v9}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    const/4 v10, 0x5

    aput-object v9, v15, v10

    const/4 v9, 0x6

    const-string v10, "key"

    aput-object v10, v15, v9

    const/4 v9, 0x7

    aput-object v2, v15, v9

    const-string v2, "read cache"

    .line 59
    invoke-static {v8, v2, v14, v15}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 64
    :cond_4
    :goto_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v9

    sub-long v6, v9, v6

    .line 65
    iput-wide v6, v1, Lanet/channel/statist/RequestStatistic;->cacheTime:J

    if-eqz v13, :cond_7

    if-nez v4, :cond_7

    .line 67
    invoke-virtual {v13}, Lanetwork/channel/cache/Cache$Entry;->isFresh()Z

    move-result v2

    if-eqz v2, :cond_7

    iget-object v2, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 68
    iget-object v2, v2, Lanetwork/channel/unified/j;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2, v12, v11}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v2

    if-eqz v2, :cond_6

    iget-object v2, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 69
    invoke-virtual {v2}, Lanetwork/channel/unified/j;->a()V

    .line 71
    iput v11, v1, Lanet/channel/statist/RequestStatistic;->ret:I

    const/16 v2, 0xc8

    .line 72
    iput v2, v1, Lanet/channel/statist/RequestStatistic;->statusCode:I

    const-string v4, "SUCCESS"

    .line 73
    iput-object v4, v1, Lanet/channel/statist/RequestStatistic;->msg:Ljava/lang/String;

    const-string v5, "cache"

    .line 74
    iput-object v5, v1, Lanet/channel/statist/RequestStatistic;->protocolType:Ljava/lang/String;

    .line 75
    iput-wide v9, v1, Lanet/channel/statist/RequestStatistic;->rspEnd:J

    .line 76
    iget-wide v5, v1, Lanet/channel/statist/RequestStatistic;->start:J

    sub-long/2addr v9, v5

    iput-wide v9, v1, Lanet/channel/statist/RequestStatistic;->processTime:J

    const/4 v1, 0x2

    .line 78
    invoke-static {v1}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v1

    if-eqz v1, :cond_5

    iget-object v1, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 79
    iget-object v1, v1, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    iget-object v5, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    iget-object v5, v5, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v5}, Lanetwork/channel/entity/g;->f()Lanet/channel/util/HttpUrl;

    move-result-object v5

    invoke-virtual {v5}, Lanet/channel/util/HttpUrl;->urlString()Ljava/lang/String;

    move-result-object v5

    const-string v6, "URL"

    filled-new-array {v6, v5}, [Ljava/lang/Object;

    move-result-object v5

    const-string v6, "hit fresh cache"

    invoke-static {v8, v6, v1, v5}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_5
    iget-object v1, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 84
    iget-object v1, v1, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    iget-object v5, v13, Lanetwork/channel/cache/Cache$Entry;->responseHeaders:Ljava/util/Map;

    invoke-interface {v1, v2, v5}, Lanetwork/channel/interceptor/Callback;->onResponseCode(ILjava/util/Map;)V

    iget-object v1, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 85
    iget-object v1, v1, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    iget-object v5, v13, Lanetwork/channel/cache/Cache$Entry;->data:[B

    array-length v5, v5

    iget-object v6, v13, Lanetwork/channel/cache/Cache$Entry;->data:[B

    invoke-static {v6}, Lanet/channel/bytes/ByteArray;->wrap([B)Lanet/channel/bytes/ByteArray;

    move-result-object v6

    invoke-interface {v1, v11, v5, v6}, Lanetwork/channel/interceptor/Callback;->onDataReceiveSize(IILanet/channel/bytes/ByteArray;)V

    .line 86
    new-instance v1, Lanetwork/channel/aidl/DefaultFinishEvent;

    invoke-direct {v1, v2, v4, v3}, Lanetwork/channel/aidl/DefaultFinishEvent;-><init>(ILjava/lang/String;Lanet/channel/request/Request;)V

    iget-object v2, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 87
    iget-object v2, v2, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    invoke-interface {v2, v1}, Lanetwork/channel/interceptor/Callback;->onFinish(Lanetwork/channel/aidl/DefaultFinishEvent;)V

    :cond_6
    return-void

    :cond_7
    iget-boolean v1, v0, Lanetwork/channel/unified/a;->c:Z

    if-eqz v1, :cond_8

    return-void

    .line 95
    :cond_8
    new-instance v1, Lanetwork/channel/unified/e;

    iget-object v2, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    if-eqz v5, :cond_9

    const/4 v9, 0x0

    goto :goto_3

    :cond_9
    iget-object v9, v0, Lanetwork/channel/unified/a;->b:Lanetwork/channel/cache/Cache;

    :goto_3
    invoke-direct {v1, v2, v9, v13}, Lanetwork/channel/unified/e;-><init>(Lanetwork/channel/unified/j;Lanetwork/channel/cache/Cache;Lanetwork/channel/cache/Cache$Entry;)V

    iget-object v2, v0, Lanetwork/channel/unified/a;->a:Lanetwork/channel/unified/j;

    .line 96
    iput-object v1, v2, Lanetwork/channel/unified/j;->e:Lanetwork/channel/unified/IUnifiedTask;

    .line 97
    invoke-virtual {v1}, Lanetwork/channel/unified/e;->run()V

    :cond_a
    return-void
.end method
