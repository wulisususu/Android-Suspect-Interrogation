.class Lanetwork/channel/unified/i;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/RequestCb;


# instance fields
.field final synthetic a:Lanet/channel/request/Request;

.field final synthetic b:Lanet/channel/statist/RequestStatistic;

.field final synthetic c:Lanetwork/channel/unified/e;


# direct methods
.method constructor <init>(Lanetwork/channel/unified/e;Lanet/channel/request/Request;Lanet/channel/statist/RequestStatistic;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iput-object p2, p0, Lanetwork/channel/unified/i;->a:Lanet/channel/request/Request;

    iput-object p3, p0, Lanetwork/channel/unified/i;->b:Lanet/channel/statist/RequestStatistic;

    .line 373
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onDataReceive(Lanet/channel/bytes/ByteArray;Z)V
    .locals 9

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 458
    iget-object v0, v0, Lanetwork/channel/unified/e;->h:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 462
    iget v0, v0, Lanetwork/channel/unified/e;->j:I

    const-string v1, "anet.NetworkTask"

    const/4 v2, 0x0

    if-nez v0, :cond_1

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 463
    iget-object v0, v0, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v0, v0, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    new-array v3, v2, [Ljava/lang/Object;

    const-string v4, "[onDataReceive] receive first data chunk!"

    invoke-static {v1, v4, v0, v3}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    if-eqz p2, :cond_2

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 467
    iget-object v0, v0, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v0, v0, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    new-array v3, v2, [Ljava/lang/Object;

    const-string v4, "[onDataReceive] receive last data chunk!"

    invoke-static {v1, v4, v0, v3}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_2
    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 470
    iget v3, v0, Lanetwork/channel/unified/e;->j:I

    const/4 v4, 0x1

    add-int/2addr v3, v4

    iput v3, v0, Lanetwork/channel/unified/e;->j:I

    :try_start_0
    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 473
    iget-object v0, v0, Lanetwork/channel/unified/e;->m:Lanetwork/channel/unified/e$a;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 474
    iget-object v0, v0, Lanetwork/channel/unified/e;->m:Lanetwork/channel/unified/e$a;

    iget-object v0, v0, Lanetwork/channel/unified/e$a;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lanetwork/channel/unified/i;->b:Lanet/channel/statist/RequestStatistic;

    .line 475
    iget-wide v5, v0, Lanet/channel/statist/RequestStatistic;->recDataSize:J

    const-wide/32 v7, 0x20000

    cmp-long v0, v5, v7

    if-gtz v0, :cond_3

    if-eqz p2, :cond_6

    :cond_3
    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 476
    iget-object v3, v0, Lanetwork/channel/unified/e;->m:Lanetwork/channel/unified/e$a;

    iget-object v5, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v5, v5, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v5, v5, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    iget-object v6, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget v6, v6, Lanetwork/channel/unified/e;->i:I

    invoke-virtual {v3, v5, v6}, Lanetwork/channel/unified/e$a;->a(Lanetwork/channel/interceptor/Callback;I)I

    move-result v3

    iput v3, v0, Lanetwork/channel/unified/e;->j:I

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 477
    iput-boolean v4, v0, Lanetwork/channel/unified/e;->k:Z

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 478
    iget v3, v0, Lanetwork/channel/unified/e;->j:I

    if-le v3, v4, :cond_4

    move v3, v4

    goto :goto_0

    :cond_4
    move v3, v2

    :goto_0
    iput-boolean v3, v0, Lanetwork/channel/unified/e;->l:Z

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    const/4 v3, 0x0

    .line 479
    iput-object v3, v0, Lanetwork/channel/unified/e;->m:Lanetwork/channel/unified/e$a;

    goto :goto_1

    :cond_5
    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 482
    iget-object v0, v0, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v0, v0, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    iget-object v3, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget v3, v3, Lanetwork/channel/unified/e;->j:I

    iget-object v5, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget v5, v5, Lanetwork/channel/unified/e;->i:I

    invoke-interface {v0, v3, v5, p1}, Lanetwork/channel/interceptor/Callback;->onDataReceiveSize(IILanet/channel/bytes/ByteArray;)V

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 483
    iput-boolean v4, v0, Lanetwork/channel/unified/e;->l:Z

    :cond_6
    :goto_1
    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 486
    iget-object v0, v0, Lanetwork/channel/unified/e;->d:Ljava/io/ByteArrayOutputStream;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 487
    iget-object v0, v0, Lanetwork/channel/unified/e;->d:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {p1}, Lanet/channel/bytes/ByteArray;->getBuffer()[B

    move-result-object v3

    invoke-virtual {p1}, Lanet/channel/bytes/ByteArray;->getDataLength()I

    move-result p1

    invoke-virtual {v0, v3, v2, p1}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    if-eqz p2, :cond_7

    iget-object p1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 489
    iget-object p1, p1, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object p1, p1, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {p1}, Lanetwork/channel/entity/g;->g()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 490
    iget-object p2, p2, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v0, v0, Lanetwork/channel/unified/e;->d:Ljava/io/ByteArrayOutputStream;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v0

    iput-object v0, p2, Lanetwork/channel/cache/Cache$Entry;->data:[B

    .line 491
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 492
    iget-object p2, p2, Lanetwork/channel/unified/e;->b:Lanetwork/channel/cache/Cache;

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v0, v0, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    invoke-interface {p2, p1, v0}, Lanetwork/channel/cache/Cache;->put(Ljava/lang/String;Lanetwork/channel/cache/Cache$Entry;)V

    const-string p2, "write cache"

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 493
    iget-object v0, v0, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v0, v0, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    const/4 v3, 0x6

    new-array v3, v3, [Ljava/lang/Object;

    const-string v7, "cost"

    aput-object v7, v3, v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v7

    sub-long/2addr v7, v5

    invoke-static {v7, v8}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    aput-object v5, v3, v4

    const-string v4, "size"

    const/4 v5, 0x2

    aput-object v4, v3, v5

    iget-object v4, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v4, v4, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    iget-object v4, v4, Lanetwork/channel/cache/Cache$Entry;->data:[B

    array-length v4, v4

    .line 494
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/4 v5, 0x3

    aput-object v4, v3, v5

    const-string v4, "key"

    const/4 v5, 0x4

    aput-object v4, v3, v5

    const/4 v4, 0x5

    aput-object p1, v3, v4

    .line 493
    invoke-static {v1, p2, v0, v3}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 498
    iget-object p2, p2, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object p2, p2, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    new-array v0, v2, [Ljava/lang/Object;

    const-string v2, "[onDataReceive] error."

    invoke-static {v1, v2, p2, p1, v0}, Lanet/channel/util/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_7
    :goto_2
    return-void
.end method

.method public onFinish(ILjava/lang/String;Lanet/channel/statist/RequestStatistic;)V
    .locals 11

    const-string/jumbo v0, "|"

    iget-object v1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 504
    iget-object v1, v1, Lanetwork/channel/unified/e;->h:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->getAndSet(Z)Z

    move-result v1

    if-eqz v1, :cond_0

    return-void

    :cond_0
    const/4 v1, 0x2

    .line 508
    invoke-static {v1}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v3

    const-string v4, "anet.NetworkTask"

    if-eqz v3, :cond_1

    iget-object v3, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 509
    iget-object v3, v3, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v3, v3, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    const-string v6, "msg"

    const-string v7, "code"

    filled-new-array {v7, v5, v6, p2}, [Ljava/lang/Object;

    move-result-object v5

    const-string v6, "[onFinish]"

    invoke-static {v4, v6, v3, v5}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    const/4 v3, 0x3

    const/4 v5, 0x4

    const/4 v6, 0x0

    if-gez p1, :cond_a

    :try_start_0
    iget-object v7, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 513
    iget-object v7, v7, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v7, v7, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v7}, Lanetwork/channel/entity/g;->d()Z

    move-result v7

    if-eqz v7, :cond_a

    iget-object v7, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 514
    iget-boolean v7, v7, Lanetwork/channel/unified/e;->k:Z

    if-nez v7, :cond_7

    iget-object v7, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-boolean v7, v7, Lanetwork/channel/unified/e;->l:Z

    if-nez v7, :cond_7

    const-string p2, "clear response buffer and retry"

    iget-object v1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 515
    iget-object v1, v1, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v1, v1, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    new-array v2, v6, [Ljava/lang/Object;

    invoke-static {v4, p2, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 517
    iget-object p2, p2, Lanetwork/channel/unified/e;->m:Lanetwork/channel/unified/e$a;

    if-eqz p2, :cond_3

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 519
    iget-object p2, p2, Lanetwork/channel/unified/e;->m:Lanetwork/channel/unified/e$a;

    iget-object p2, p2, Lanetwork/channel/unified/e$a;->c:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result p2

    if-eqz p2, :cond_2

    goto :goto_0

    :cond_2
    move v3, v5

    :goto_0
    iput v3, p3, Lanet/channel/statist/RequestStatistic;->roaming:I

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 520
    iget-object p2, p2, Lanetwork/channel/unified/e;->m:Lanetwork/channel/unified/e$a;

    invoke-virtual {p2}, Lanetwork/channel/unified/e$a;->a()V

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    const/4 v1, 0x0

    .line 521
    iput-object v1, p2, Lanetwork/channel/unified/e;->m:Lanetwork/channel/unified/e$a;

    :cond_3
    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 524
    iget-object p2, p2, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object p2, p2, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    iget p2, p2, Lanetwork/channel/entity/g;->a:I

    if-nez p2, :cond_5

    .line 525
    iget-object p2, p3, Lanet/channel/statist/RequestStatistic;->protocolType:Ljava/lang/String;

    iput-object p2, p3, Lanet/channel/statist/RequestStatistic;->firstProtocol:Ljava/lang/String;

    .line 526
    iget p2, p3, Lanet/channel/statist/RequestStatistic;->tnetErrorCode:I

    if-eqz p2, :cond_4

    iget p2, p3, Lanet/channel/statist/RequestStatistic;->tnetErrorCode:I

    goto :goto_1

    :cond_4
    move p2, p1

    :goto_1
    iput p2, p3, Lanet/channel/statist/RequestStatistic;->firstErrorCode:I

    :cond_5
    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 529
    iget-object p2, p2, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object p2, p2, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {p2}, Lanetwork/channel/entity/g;->k()V

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 530
    iget-object p2, p2, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    new-instance v1, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>()V

    iput-object v1, p2, Lanetwork/channel/unified/j;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 531
    iget-object p2, p2, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    new-instance v1, Lanetwork/channel/unified/e;

    iget-object v2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v2, v2, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v3, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v3, v3, Lanetwork/channel/unified/e;->b:Lanetwork/channel/cache/Cache;

    iget-object v4, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v4, v4, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    invoke-direct {v1, v2, v3, v4}, Lanetwork/channel/unified/e;-><init>(Lanetwork/channel/unified/j;Lanetwork/channel/cache/Cache;Lanetwork/channel/cache/Cache$Entry;)V

    iput-object v1, p2, Lanetwork/channel/unified/j;->e:Lanetwork/channel/unified/IUnifiedTask;

    .line 534
    iget p2, p3, Lanet/channel/statist/RequestStatistic;->tnetErrorCode:I

    if-eqz p2, :cond_6

    .line 535
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget-object p2, p3, Lanet/channel/statist/RequestStatistic;->protocolType:Ljava/lang/String;

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    iget p2, p3, Lanet/channel/statist/RequestStatistic;->tnetErrorCode:I

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 536
    iput v6, p3, Lanet/channel/statist/RequestStatistic;->tnetErrorCode:I

    goto :goto_2

    .line 538
    :cond_6
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p1

    .line 540
    :goto_2
    invoke-virtual {p3, p1}, Lanet/channel/statist/RequestStatistic;->appendErrorTrace(Ljava/lang/String;)V

    .line 542
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    .line 543
    iget-wide v0, p3, Lanet/channel/statist/RequestStatistic;->retryCostTime:J

    iget-wide v2, p3, Lanet/channel/statist/RequestStatistic;->start:J

    sub-long v2, p1, v2

    add-long/2addr v0, v2

    iput-wide v0, p3, Lanet/channel/statist/RequestStatistic;->retryCostTime:J

    .line 544
    iput-wide p1, p3, Lanet/channel/statist/RequestStatistic;->start:J

    iget-object p1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 545
    iget-object p1, p1, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object p1, p1, Lanetwork/channel/unified/j;->e:Lanetwork/channel/unified/IUnifiedTask;

    sget p2, Lanet/channel/thread/ThreadPoolExecutorFactory$Priority;->HIGH:I

    invoke-static {p1, p2}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitPriorityTask(Ljava/lang/Runnable;I)Ljava/util/concurrent/Future;

    return-void

    .line 548
    :cond_7
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v7, p3, Lanet/channel/statist/RequestStatistic;->msg:Ljava/lang/String;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v7, ":\u56de\u8c03\u540e\u89e6\u53d1\u91cd\u8bd5"

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p3, Lanet/channel/statist/RequestStatistic;->msg:Ljava/lang/String;

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 550
    iget-boolean v0, v0, Lanetwork/channel/unified/e;->l:Z

    if-eqz v0, :cond_8

    .line 551
    iput v1, p3, Lanet/channel/statist/RequestStatistic;->roaming:I

    goto :goto_3

    :cond_8
    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 552
    iget-boolean v0, v0, Lanetwork/channel/unified/e;->k:Z

    if-eqz v0, :cond_9

    .line 553
    iput v2, p3, Lanet/channel/statist/RequestStatistic;->roaming:I

    :cond_9
    :goto_3
    const-string v0, "Cannot retry request after onHeader/onDataReceived callback!"

    iget-object v7, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 555
    iget-object v7, v7, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v7, v7, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    new-array v8, v6, [Ljava/lang/Object;

    invoke-static {v4, v0, v7, v8}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_a
    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 560
    iget-object v0, v0, Lanetwork/channel/unified/e;->m:Lanetwork/channel/unified/e$a;

    if-eqz v0, :cond_b

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 561
    iget-object v0, v0, Lanetwork/channel/unified/e;->m:Lanetwork/channel/unified/e$a;

    iget-object v7, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v7, v7, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v7, v7, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    iget-object v8, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget v8, v8, Lanetwork/channel/unified/e;->i:I

    invoke-virtual {v0, v7, v8}, Lanetwork/channel/unified/e$a;->a(Lanetwork/channel/interceptor/Callback;I)I

    :cond_b
    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 564
    iget-object v0, v0, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    invoke-virtual {v0}, Lanetwork/channel/unified/j;->a()V

    .line 565
    iget-object v0, p3, Lanet/channel/statist/RequestStatistic;->isDone:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v0, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 567
    iget-object v0, v0, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v0, v0, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v0}, Lanetwork/channel/entity/g;->j()Z

    move-result v0

    if-eqz v0, :cond_c

    .line 568
    iget-wide v7, p3, Lanet/channel/statist/RequestStatistic;->contentLength:J

    const-wide/16 v9, 0x0

    cmp-long v0, v7, v9

    if-eqz v0, :cond_c

    iget-wide v7, p3, Lanet/channel/statist/RequestStatistic;->contentLength:J

    iget-wide v9, p3, Lanet/channel/statist/RequestStatistic;->rspBodyDeflateSize:J

    cmp-long v0, v7, v9

    if-eqz v0, :cond_c

    .line 569
    iput v6, p3, Lanet/channel/statist/RequestStatistic;->ret:I

    const/16 p1, -0xce

    .line 570
    iput p1, p3, Lanet/channel/statist/RequestStatistic;->statusCode:I

    .line 571
    invoke-static {p1}, Lanet/channel/util/ErrorConstant;->getErrMsg(I)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p3, Lanet/channel/statist/RequestStatistic;->msg:Ljava/lang/String;

    const-string v0, "received data length not match with content-length"

    iget-object v7, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 572
    iget-object v7, v7, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v7, v7, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    new-array v5, v5, [Ljava/lang/Object;

    const-string v8, "content-length"

    aput-object v8, v5, v6

    iget-object v6, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget v6, v6, Lanetwork/channel/unified/e;->i:I

    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v5, v2

    const-string v2, "recDataLength"

    aput-object v2, v5, v1

    iget-wide v1, p3, Lanet/channel/statist/RequestStatistic;->rspBodyDeflateSize:J

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    aput-object v1, v5, v3

    invoke-static {v4, v0, v7, v5}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 573
    new-instance v0, Lanet/channel/statist/ExceptionStatistic;

    const-string v1, "rt"

    invoke-direct {v0, p1, p2, v1}, Lanet/channel/statist/ExceptionStatistic;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    iget-object v1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 574
    iget-object v1, v1, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v1, v1, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v1}, Lanetwork/channel/entity/g;->g()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lanet/channel/statist/ExceptionStatistic;->url:Ljava/lang/String;

    .line 575
    invoke-static {}, Lanet/channel/appmonitor/AppMonitor;->getInstance()Lanet/channel/appmonitor/IAppMonitor;

    move-result-object v1

    invoke-interface {v1, v0}, Lanet/channel/appmonitor/IAppMonitor;->commitStat(Lanet/channel/statist/StatObject;)V

    :cond_c
    const/16 v0, 0x130

    if-ne p1, v0, :cond_d

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 580
    iget-object v0, v0, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    if-eqz v0, :cond_d

    const-string v0, "cache"

    .line 581
    iput-object v0, p3, Lanet/channel/statist/RequestStatistic;->protocolType:Ljava/lang/String;

    .line 582
    new-instance v0, Lanetwork/channel/aidl/DefaultFinishEvent;

    iget-object v1, p0, Lanetwork/channel/unified/i;->a:Lanet/channel/request/Request;

    const/16 v2, 0xc8

    invoke-direct {v0, v2, p2, v1}, Lanetwork/channel/aidl/DefaultFinishEvent;-><init>(ILjava/lang/String;Lanet/channel/request/Request;)V

    goto :goto_4

    .line 584
    :cond_d
    new-instance v0, Lanetwork/channel/aidl/DefaultFinishEvent;

    iget-object v1, p0, Lanetwork/channel/unified/i;->a:Lanet/channel/request/Request;

    invoke-direct {v0, p1, p2, v1}, Lanetwork/channel/aidl/DefaultFinishEvent;-><init>(ILjava/lang/String;Lanet/channel/request/Request;)V

    :goto_4
    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 587
    iget-object p2, p2, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object p2, p2, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    invoke-interface {p2, v0}, Lanetwork/channel/interceptor/Callback;->onFinish(Lanetwork/channel/aidl/DefaultFinishEvent;)V

    if-ltz p1, :cond_e

    .line 590
    invoke-static {}, Lanet/channel/monitor/b;->a()Lanet/channel/monitor/b;

    move-result-object v1

    iget-wide v2, p3, Lanet/channel/statist/RequestStatistic;->sendStart:J

    iget-wide v4, p3, Lanet/channel/statist/RequestStatistic;->rspEnd:J

    iget-wide p1, p3, Lanet/channel/statist/RequestStatistic;->rspBodyDeflateSize:J

    iget-wide v6, p3, Lanet/channel/statist/RequestStatistic;->rspHeadDeflateSize:J

    add-long/2addr v6, p1

    invoke-virtual/range {v1 .. v7}, Lanet/channel/monitor/b;->a(JJJ)V

    goto :goto_5

    .line 592
    :cond_e
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getNetworkSubType()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p3, Lanet/channel/statist/RequestStatistic;->netType:Ljava/lang/String;

    .line 594
    :goto_5
    invoke-static {}, Lanet/channel/flow/NetworkAnalysis;->getInstance()Lanet/channel/flow/INetworkAnalysis;

    move-result-object p1

    new-instance p2, Lanet/channel/flow/FlowStat;

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v0, v0, Lanetwork/channel/unified/e;->e:Ljava/lang/String;

    invoke-direct {p2, v0, p3}, Lanet/channel/flow/FlowStat;-><init>(Ljava/lang/String;Lanet/channel/statist/RequestStatistic;)V

    invoke-interface {p1, p2}, Lanet/channel/flow/INetworkAnalysis;->commitFlow(Lanet/channel/flow/FlowStat;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onResponseCode(ILjava/util/Map;)V
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;>;)V"
        }
    .end annotation

    const-string v0, "no-store"

    const-string v1, "Cache-Control"

    iget-object v2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 376
    iget-object v2, v2, Lanetwork/channel/unified/e;->h:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v2

    if-eqz v2, :cond_0

    return-void

    :cond_0
    const/4 v2, 0x2

    .line 380
    invoke-static {v2}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v3

    const-string v4, "anet.NetworkTask"

    if-eqz v3, :cond_1

    iget-object v3, p0, Lanetwork/channel/unified/i;->a:Lanet/channel/request/Request;

    .line 381
    invoke-virtual {v3}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const-string v5, "code"

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    filled-new-array {v5, v6}, [Ljava/lang/Object;

    move-result-object v5

    const-string v6, "onResponseCode"

    invoke-static {v4, v6, v3, v5}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v3, p0, Lanetwork/channel/unified/i;->a:Lanet/channel/request/Request;

    .line 382
    invoke-virtual {v3}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v3

    const-string v5, "headers"

    filled-new-array {v5, p2}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v6, v3, v5}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    iget-object v3, p0, Lanetwork/channel/unified/i;->a:Lanet/channel/request/Request;

    .line 386
    invoke-static {v3, p1}, Lanet/channel/util/HttpHelper;->checkRedirect(Lanet/channel/request/Request;I)Z

    move-result v3

    const/4 v5, 0x0

    const/4 v6, 0x1

    if-eqz v3, :cond_4

    const-string v3, "Location"

    .line 387
    invoke-static {p2, v3}, Lanet/channel/util/HttpHelper;->getSingleHeaderFieldByKey(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_4

    .line 389
    invoke-static {v3}, Lanet/channel/util/HttpUrl;->parse(Ljava/lang/String;)Lanet/channel/util/HttpUrl;

    move-result-object v7

    if-eqz v7, :cond_3

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 391
    iget-object p2, p2, Lanetwork/channel/unified/e;->h:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {p2, v5, v6}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result p2

    if-eqz p2, :cond_2

    .line 392
    invoke-virtual {v7}, Lanet/channel/util/HttpUrl;->lockScheme()V

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 393
    iget-object p2, p2, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object p2, p2, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {p2, v7}, Lanetwork/channel/entity/g;->a(Lanet/channel/util/HttpUrl;)V

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 394
    iget-object p2, p2, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>()V

    iput-object v0, p2, Lanetwork/channel/unified/j;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 395
    iget-object p2, p2, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    new-instance v0, Lanetwork/channel/unified/e;

    iget-object v1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v1, v1, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lanetwork/channel/unified/e;-><init>(Lanetwork/channel/unified/j;Lanetwork/channel/cache/Cache;Lanetwork/channel/cache/Cache$Entry;)V

    iput-object v0, p2, Lanetwork/channel/unified/j;->e:Lanetwork/channel/unified/IUnifiedTask;

    iget-object p2, p0, Lanetwork/channel/unified/i;->b:Lanet/channel/statist/RequestStatistic;

    .line 397
    invoke-virtual {v7}, Lanet/channel/util/HttpUrl;->simpleUrlString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, p1, v0}, Lanet/channel/statist/RequestStatistic;->recordRedirect(ILjava/lang/String;)V

    iget-object p1, p0, Lanetwork/channel/unified/i;->b:Lanet/channel/statist/RequestStatistic;

    .line 398
    iput-object v3, p1, Lanet/channel/statist/RequestStatistic;->locationUrl:Ljava/lang/String;

    iget-object p1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 399
    iget-object p1, p1, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object p1, p1, Lanetwork/channel/unified/j;->e:Lanetwork/channel/unified/IUnifiedTask;

    sget p2, Lanet/channel/thread/ThreadPoolExecutorFactory$Priority;->HIGH:I

    invoke-static {p1, p2}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitPriorityTask(Ljava/lang/Runnable;I)Ljava/util/concurrent/Future;

    :cond_2
    return-void

    :cond_3
    iget-object v7, p0, Lanetwork/channel/unified/i;->a:Lanet/channel/request/Request;

    .line 403
    invoke-virtual {v7}, Lanet/channel/request/Request;->getSeq()Ljava/lang/String;

    move-result-object v7

    const-string v8, "redirect url"

    filled-new-array {v8, v3}, [Ljava/lang/Object;

    move-result-object v3

    const-string v8, "redirect url is invalid!"

    invoke-static {v4, v8, v7, v3}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_4
    :try_start_0
    iget-object v3, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 409
    iget-object v3, v3, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    invoke-virtual {v3}, Lanetwork/channel/unified/j;->a()V

    iget-object v3, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 410
    iget-object v3, v3, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v3, v3, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v3}, Lanetwork/channel/entity/g;->g()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, p2}, Lanetwork/channel/cookie/CookieManager;->setCookie(Ljava/lang/String;Ljava/util/Map;)V

    iget-object v3, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 411
    invoke-static {p2}, Lanet/channel/util/HttpHelper;->parseContentLength(Ljava/util/Map;)I

    move-result v7

    iput v7, v3, Lanetwork/channel/unified/e;->i:I

    iget-object v3, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 412
    iget-object v3, v3, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v3, v3, Lanetwork/channel/unified/j;->a:Lanetwork/channel/entity/g;

    invoke-virtual {v3}, Lanetwork/channel/entity/g;->g()Ljava/lang/String;

    move-result-object v3

    iget-object v7, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 414
    iget-object v7, v7, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    if-eqz v7, :cond_6

    const/16 v7, 0x130

    if-ne p1, v7, :cond_6

    iget-object p1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 415
    iget-object p1, p1, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    iget-object p1, p1, Lanetwork/channel/cache/Cache$Entry;->responseHeaders:Ljava/util/Map;

    invoke-interface {p1, p2}, Ljava/util/Map;->putAll(Ljava/util/Map;)V

    .line 416
    invoke-static {p2}, Lanetwork/channel/cache/a;->a(Ljava/util/Map;)Lanetwork/channel/cache/Cache$Entry;

    move-result-object p1

    if-eqz p1, :cond_5

    .line 417
    iget-wide v0, p1, Lanetwork/channel/cache/Cache$Entry;->ttl:J

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object p2, p2, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    iget-wide v7, p2, Lanetwork/channel/cache/Cache$Entry;->ttl:J

    cmp-long p2, v0, v7

    if-lez p2, :cond_5

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 418
    iget-object p2, p2, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    iget-wide v0, p1, Lanetwork/channel/cache/Cache$Entry;->ttl:J

    iput-wide v0, p2, Lanetwork/channel/cache/Cache$Entry;->ttl:J

    :cond_5
    iget-object p1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 420
    iget-object p1, p1, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object p1, p1, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object p2, p2, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    iget-object p2, p2, Lanetwork/channel/cache/Cache$Entry;->responseHeaders:Ljava/util/Map;

    const/16 v0, 0xc8

    invoke-interface {p1, v0, p2}, Lanetwork/channel/interceptor/Callback;->onResponseCode(ILjava/util/Map;)V

    iget-object p1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 421
    iget-object p1, p1, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object p1, p1, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object p2, p2, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    iget-object p2, p2, Lanetwork/channel/cache/Cache$Entry;->data:[B

    array-length p2, p2

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v0, v0, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    iget-object v0, v0, Lanetwork/channel/cache/Cache$Entry;->data:[B

    invoke-static {v0}, Lanet/channel/bytes/ByteArray;->wrap([B)Lanet/channel/bytes/ByteArray;

    move-result-object v0

    invoke-interface {p1, v6, p2, v0}, Lanetwork/channel/interceptor/Callback;->onDataReceiveSize(IILanet/channel/bytes/ByteArray;)V

    .line 424
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 425
    iget-object v0, v0, Lanetwork/channel/unified/e;->b:Lanetwork/channel/cache/Cache;

    iget-object v1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget-object v1, v1, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    invoke-interface {v0, v3, v1}, Lanetwork/channel/cache/Cache;->put(Ljava/lang/String;Lanetwork/channel/cache/Cache$Entry;)V

    const-string v0, "update cache"

    iget-object v1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 426
    iget-object v1, v1, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v1, v1, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    const/4 v7, 0x4

    new-array v7, v7, [Ljava/lang/Object;

    const-string v8, "cost"

    aput-object v8, v7, v5

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    sub-long/2addr v8, p1

    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    aput-object p1, v7, v6

    const-string p1, "key"

    aput-object p1, v7, v2

    const/4 p1, 0x3

    aput-object v3, v7, p1

    invoke-static {v4, v0, v1, v7}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    :cond_6
    iget-object v2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 431
    iget-object v2, v2, Lanetwork/channel/unified/e;->b:Lanetwork/channel/cache/Cache;

    if-eqz v2, :cond_9

    .line 432
    invoke-static {p2, v1}, Lanet/channel/util/HttpHelper;->getSingleHeaderFieldByKey(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_7

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 433
    iget-object v0, v0, Lanetwork/channel/unified/e;->b:Lanetwork/channel/cache/Cache;

    invoke-interface {v0, v3}, Lanetwork/channel/cache/Cache;->remove(Ljava/lang/String;)V

    goto :goto_1

    :cond_7
    iget-object v2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 434
    invoke-static {p2}, Lanetwork/channel/cache/a;->a(Ljava/util/Map;)Lanetwork/channel/cache/Cache$Entry;

    move-result-object v3

    iput-object v3, v2, Lanetwork/channel/unified/e;->c:Lanetwork/channel/cache/Cache$Entry;

    if-eqz v3, :cond_9

    .line 435
    invoke-static {p2, v1}, Lanet/channel/util/HttpHelper;->removeHeaderFiledByKey(Ljava/util/Map;Ljava/lang/String;)V

    new-array v2, v6, [Ljava/lang/String;

    aput-object v0, v2, v5

    .line 436
    invoke-static {v2}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    invoke-interface {p2, v1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 437
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    iget-object v2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget v2, v2, Lanetwork/channel/unified/e;->i:I

    if-eqz v2, :cond_8

    iget-object v2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget v2, v2, Lanetwork/channel/unified/e;->i:I

    goto :goto_0

    :cond_8
    const/16 v2, 0x1400

    :goto_0
    invoke-direct {v1, v2}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    iput-object v1, v0, Lanetwork/channel/unified/e;->d:Ljava/io/ByteArrayOutputStream;

    :cond_9
    :goto_1
    const-string/jumbo v0, "x-protocol"

    new-array v1, v6, [Ljava/lang/String;

    iget-object v2, p0, Lanetwork/channel/unified/i;->b:Lanet/channel/statist/RequestStatistic;

    .line 441
    iget-object v2, v2, Lanet/channel/statist/RequestStatistic;->protocolType:Ljava/lang/String;

    aput-object v2, v1, v5

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-interface {p2, v0, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "open"

    const-string v1, "streaming-parser"

    .line 443
    invoke-static {p2, v1}, Lanet/channel/util/HttpHelper;->getSingleHeaderFieldByKey(Ljava/util/Map;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_a

    .line 444
    invoke-static {}, Lanetwork/channel/config/NetworkConfigCenter;->isResponseBufferEnable()Z

    move-result v0

    if-eqz v0, :cond_a

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    iget v0, v0, Lanetwork/channel/unified/e;->i:I

    const/high16 v1, 0x20000

    if-gt v0, v1, :cond_a

    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 445
    new-instance v1, Lanetwork/channel/unified/e$a;

    invoke-direct {v1, p1, p2}, Lanetwork/channel/unified/e$a;-><init>(ILjava/util/Map;)V

    iput-object v1, v0, Lanetwork/channel/unified/e;->m:Lanetwork/channel/unified/e$a;

    return-void

    :cond_a
    iget-object v0, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 448
    iget-object v0, v0, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object v0, v0, Lanetwork/channel/unified/j;->b:Lanetwork/channel/interceptor/Callback;

    invoke-interface {v0, p1, p2}, Lanetwork/channel/interceptor/Callback;->onResponseCode(ILjava/util/Map;)V

    iget-object p1, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 449
    iput-boolean v6, p1, Lanetwork/channel/unified/e;->k:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    iget-object p2, p0, Lanetwork/channel/unified/i;->c:Lanetwork/channel/unified/e;

    .line 452
    iget-object p2, p2, Lanetwork/channel/unified/e;->a:Lanetwork/channel/unified/j;

    iget-object p2, p2, Lanetwork/channel/unified/j;->c:Ljava/lang/String;

    new-array v0, v5, [Ljava/lang/Object;

    const-string v1, "[onResponseCode] error."

    invoke-static {v4, v1, p2, p1, v0}, Lanet/channel/util/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_2
    return-void
.end method
