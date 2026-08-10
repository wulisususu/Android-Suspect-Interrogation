.class Lanet/channel/SessionRequest$a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/SessionRequest$IConnCb;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanet/channel/SessionRequest;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "a"
.end annotation


# instance fields
.field a:Z

.field final synthetic b:Lanet/channel/SessionRequest;

.field private c:Landroid/content/Context;

.field private d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lanet/channel/entity/a;",
            ">;"
        }
    .end annotation
.end field

.field private e:Lanet/channel/entity/a;


# direct methods
.method constructor <init>(Lanet/channel/SessionRequest;Landroid/content/Context;Ljava/util/List;Lanet/channel/entity/a;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lanet/channel/entity/a;",
            ">;",
            "Lanet/channel/entity/a;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 287
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lanet/channel/SessionRequest$a;->a:Z

    iput-object p2, p0, Lanet/channel/SessionRequest$a;->c:Landroid/content/Context;

    iput-object p3, p0, Lanet/channel/SessionRequest$a;->d:Ljava/util/List;

    iput-object p4, p0, Lanet/channel/SessionRequest$a;->e:Lanet/channel/entity/a;

    return-void
.end method

.method static synthetic a(Lanet/channel/SessionRequest$a;)Landroid/content/Context;
    .locals 0

    .line 281
    iget-object p0, p0, Lanet/channel/SessionRequest$a;->c:Landroid/content/Context;

    return-object p0
.end method


# virtual methods
.method public onDisConnect(Lanet/channel/Session;JI)V
    .locals 8

    .line 410
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result p2

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->e:Lanet/channel/entity/a;

    .line 411
    invoke-virtual {p3}, Lanet/channel/entity/a;->h()Ljava/lang/String;

    move-result-object p3

    const-string v0, "session"

    const-string v2, "host"

    iget-object p4, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    invoke-virtual {p4}, Lanet/channel/SessionRequest;->a()Ljava/lang/String;

    move-result-object v3

    const-string v4, "appIsBg"

    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    const-string v6, "isHandleFinish"

    iget-boolean p4, p0, Lanet/channel/SessionRequest$a;->a:Z

    invoke-static {p4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    move-object v1, p1

    filled-new-array/range {v0 .. v7}, [Ljava/lang/Object;

    move-result-object p4

    const-string v0, "awcn.SessionRequest"

    const-string v1, "Connect Disconnect"

    invoke-static {v0, v1, p3, p4}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 21060
    iget-object p3, p3, Lanet/channel/SessionRequest;->b:Lanet/channel/e;

    iget-object p4, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 412
    invoke-virtual {p3, p4, p1}, Lanet/channel/e;->b(Lanet/channel/SessionRequest;Lanet/channel/Session;)V

    iget-boolean p3, p0, Lanet/channel/SessionRequest$a;->a:Z

    if-eqz p3, :cond_0

    return-void

    :cond_0
    const/4 p3, 0x1

    iput-boolean p3, p0, Lanet/channel/SessionRequest$a;->a:Z

    .line 419
    iget-boolean p3, p1, Lanet/channel/Session;->t:Z

    if-nez p3, :cond_1

    return-void

    :cond_1
    const-string p3, "session"

    if-eqz p2, :cond_3

    iget-object p2, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 22060
    iget-object p2, p2, Lanet/channel/SessionRequest;->c:Lanet/channel/SessionInfo;

    if-eqz p2, :cond_2

    iget-object p2, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 23060
    iget-object p2, p2, Lanet/channel/SessionRequest;->c:Lanet/channel/SessionInfo;

    .line 422
    iget-boolean p2, p2, Lanet/channel/SessionInfo;->isAccs:Z

    if-eqz p2, :cond_2

    invoke-static {}, Lanet/channel/AwcnConfig;->isAccsSessionCreateForbiddenInBg()Z

    move-result p2

    if-eqz p2, :cond_3

    :cond_2
    iget-object p2, p0, Lanet/channel/SessionRequest$a;->e:Lanet/channel/entity/a;

    .line 423
    invoke-virtual {p2}, Lanet/channel/entity/a;->h()Ljava/lang/String;

    move-result-object p2

    filled-new-array {p3, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p3, "[onDisConnect]app background, don\'t Recreate"

    invoke-static {v0, p3, p2, p1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 426
    :cond_3
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->isConnected()Z

    move-result p2

    if-nez p2, :cond_4

    iget-object p2, p0, Lanet/channel/SessionRequest$a;->e:Lanet/channel/entity/a;

    .line 427
    invoke-virtual {p2}, Lanet/channel/entity/a;->h()Ljava/lang/String;

    move-result-object p2

    filled-new-array {p3, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p3, "[onDisConnect]no network, don\'t Recreate"

    invoke-static {v0, p3, p2, p1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    :cond_4
    :try_start_0
    const-string p2, "session disconnected, try to recreate session"

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->e:Lanet/channel/entity/a;

    .line 431
    invoke-virtual {p3}, Lanet/channel/entity/a;->h()Ljava/lang/String;

    move-result-object p3

    const/4 p4, 0x0

    new-array p4, p4, [Ljava/lang/Object;

    invoke-static {v0, p2, p3, p4}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p2, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 24060
    iget-object p2, p2, Lanet/channel/SessionRequest;->c:Lanet/channel/SessionInfo;

    if-eqz p2, :cond_5

    iget-object p2, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 25060
    iget-object p2, p2, Lanet/channel/SessionRequest;->c:Lanet/channel/SessionInfo;

    .line 433
    iget-boolean p2, p2, Lanet/channel/SessionInfo;->isAccs:Z

    if-eqz p2, :cond_5

    .line 434
    invoke-static {}, Lanet/channel/AwcnConfig;->getAccsReconnectionDelayPeriod()I

    move-result p2

    goto :goto_0

    :cond_5
    const/16 p2, 0x2710

    .line 436
    :goto_0
    new-instance p3, Lanet/channel/i;

    invoke-direct {p3, p0, p1}, Lanet/channel/i;-><init>(Lanet/channel/SessionRequest$a;Lanet/channel/Session;)V

    .line 444
    invoke-static {}, Ljava/lang/Math;->random()D

    move-result-wide v0

    int-to-double p1, p2

    mul-double/2addr v0, p1

    double-to-long p1, v0

    sget-object p4, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    .line 436
    invoke-static {p3, p1, p2, p4}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onFailed(Lanet/channel/Session;JII)V
    .locals 8

    const/4 p2, 0x1

    .line 297
    invoke-static {p2}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result p3

    if-eqz p3, :cond_0

    const-string p3, "awcn.SessionRequest"

    const-string v0, "Connect failed"

    iget-object v1, p0, Lanet/channel/SessionRequest$a;->e:Lanet/channel/entity/a;

    .line 298
    invoke-virtual {v1}, Lanet/channel/entity/a;->h()Ljava/lang/String;

    move-result-object v1

    const-string v2, "session"

    const-string v4, "host"

    iget-object v3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    invoke-virtual {v3}, Lanet/channel/SessionRequest;->a()Ljava/lang/String;

    move-result-object v5

    const-string v6, "isHandleFinish"

    iget-boolean v3, p0, Lanet/channel/SessionRequest$a;->a:Z

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v7

    move-object v3, p1

    filled-new-array/range {v2 .. v7}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {p3, v0, v1, v2}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 301
    iget-boolean p3, p3, Lanet/channel/SessionRequest;->f:Z

    const/4 v0, 0x0

    if-eqz p3, :cond_1

    iget-object p1, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 302
    iput-boolean v0, p1, Lanet/channel/SessionRequest;->f:Z

    return-void

    :cond_1
    iget-boolean p3, p0, Lanet/channel/SessionRequest$a;->a:Z

    if-eqz p3, :cond_2

    return-void

    :cond_2
    iput-boolean p2, p0, Lanet/channel/SessionRequest$a;->a:Z

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 1060
    iget-object p3, p3, Lanet/channel/SessionRequest;->b:Lanet/channel/e;

    iget-object v1, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 311
    invoke-virtual {p3, v1, p1}, Lanet/channel/e;->b(Lanet/channel/SessionRequest;Lanet/channel/Session;)V

    .line 313
    iget-boolean p3, p1, Lanet/channel/Session;->u:Z

    if-eqz p3, :cond_d

    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->isConnected()Z

    move-result p3

    if-eqz p3, :cond_d

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->d:Ljava/util/List;

    invoke-interface {p3}, Ljava/util/List;->isEmpty()Z

    move-result p3

    if-eqz p3, :cond_3

    goto/16 :goto_3

    .line 331
    :cond_3
    invoke-static {p2}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result p3

    if-eqz p3, :cond_4

    const-string p3, "awcn.SessionRequest"

    const-string v1, "use next connInfo to create session"

    iget-object v2, p0, Lanet/channel/SessionRequest$a;->e:Lanet/channel/entity/a;

    .line 332
    invoke-virtual {v2}, Lanet/channel/entity/a;->h()Ljava/lang/String;

    move-result-object v2

    const-string v3, "host"

    iget-object v4, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    invoke-virtual {v4}, Lanet/channel/SessionRequest;->a()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v3, v4}, [Ljava/lang/Object;

    move-result-object v3

    invoke-static {p3, v1, v2, v3}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_4
    iget-object p3, p0, Lanet/channel/SessionRequest$a;->e:Lanet/channel/entity/a;

    .line 337
    iget p3, p3, Lanet/channel/entity/a;->b:I

    iget-object v1, p0, Lanet/channel/SessionRequest$a;->e:Lanet/channel/entity/a;

    iget v1, v1, Lanet/channel/entity/a;->c:I

    if-ne p3, v1, :cond_7

    const/16 p3, -0x7d3

    if-eq p5, p3, :cond_5

    const/16 p3, -0x96a

    if-ne p5, p3, :cond_7

    :cond_5
    iget-object p3, p0, Lanet/channel/SessionRequest$a;->d:Ljava/util/List;

    .line 338
    invoke-interface {p3}, Ljava/util/List;->listIterator()Ljava/util/ListIterator;

    move-result-object p3

    .line 339
    :cond_6
    :goto_0
    invoke-interface {p3}, Ljava/util/ListIterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 340
    invoke-interface {p3}, Ljava/util/ListIterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/entity/a;

    .line 341
    invoke-virtual {p1}, Lanet/channel/Session;->getIp()Ljava/lang/String;

    move-result-object v2

    iget-object v1, v1, Lanet/channel/entity/a;->a:Lanet/channel/strategy/IConnStrategy;

    invoke-interface {v1}, Lanet/channel/strategy/IConnStrategy;->getIp()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 342
    invoke-interface {p3}, Ljava/util/ListIterator;->remove()V

    goto :goto_0

    .line 348
    :cond_7
    invoke-virtual {p1}, Lanet/channel/Session;->getIp()Ljava/lang/String;

    move-result-object p3

    invoke-static {p3}, Lanet/channel/strategy/utils/c;->b(Ljava/lang/String;)Z

    move-result p3

    if-eqz p3, :cond_9

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->d:Ljava/util/List;

    .line 349
    invoke-interface {p3}, Ljava/util/List;->listIterator()Ljava/util/ListIterator;

    move-result-object p3

    .line 350
    :cond_8
    :goto_1
    invoke-interface {p3}, Ljava/util/ListIterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_9

    .line 351
    invoke-interface {p3}, Ljava/util/ListIterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/entity/a;

    .line 352
    iget-object v1, v1, Lanet/channel/entity/a;->a:Lanet/channel/strategy/IConnStrategy;

    invoke-interface {v1}, Lanet/channel/strategy/IConnStrategy;->getIp()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lanet/channel/strategy/utils/c;->b(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 353
    invoke-interface {p3}, Ljava/util/ListIterator;->remove()V

    goto :goto_1

    :cond_9
    iget-object p3, p0, Lanet/channel/SessionRequest$a;->d:Ljava/util/List;

    .line 359
    invoke-interface {p3}, Ljava/util/List;->isEmpty()Z

    move-result p3

    if-eqz p3, :cond_c

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 7060
    invoke-virtual {p3}, Lanet/channel/SessionRequest;->c()V

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 8060
    invoke-virtual {p3, p1, p4, p5}, Lanet/channel/SessionRequest;->a(Lanet/channel/Session;II)V

    iget-object p1, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 9060
    iget-object p1, p1, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 362
    monitor-enter p1

    :try_start_0
    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 10060
    iget-object p3, p3, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 363
    invoke-virtual {p3}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object p3

    invoke-interface {p3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :cond_a
    :goto_2
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result p4

    if-eqz p4, :cond_b

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Ljava/util/Map$Entry;

    .line 364
    invoke-interface {p4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object p5

    check-cast p5, Lanet/channel/SessionRequest$c;

    .line 365
    iget-object v1, p5, Lanet/channel/SessionRequest$c;->b:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1, v0, p2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v1

    if-eqz v1, :cond_a

    .line 366
    invoke-static {p5}, Lanet/channel/thread/ThreadPoolExecutorFactory;->removeScheduleTask(Ljava/lang/Runnable;)V

    .line 367
    invoke-interface {p4}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Lanet/channel/SessionGetCallback;

    invoke-interface {p4}, Lanet/channel/SessionGetCallback;->onSessionGetFail()V

    goto :goto_2

    :cond_b
    iget-object p2, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 11060
    iget-object p2, p2, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 370
    invoke-virtual {p2}, Ljava/util/HashMap;->clear()V

    .line 371
    monitor-exit p1

    return-void

    :catchall_0
    move-exception p2

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p2

    :cond_c
    iget-object p1, p0, Lanet/channel/SessionRequest$a;->d:Ljava/util/List;

    .line 375
    invoke-interface {p1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lanet/channel/entity/a;

    iget-object p2, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->c:Landroid/content/Context;

    .line 376
    new-instance p4, Lanet/channel/SessionRequest$a;

    iget-object p5, p0, Lanet/channel/SessionRequest$a;->d:Ljava/util/List;

    invoke-direct {p4, p2, p3, p5, p1}, Lanet/channel/SessionRequest$a;-><init>(Lanet/channel/SessionRequest;Landroid/content/Context;Ljava/util/List;Lanet/channel/entity/a;)V

    invoke-virtual {p1}, Lanet/channel/entity/a;->h()Ljava/lang/String;

    move-result-object p5

    invoke-static {p2, p3, p1, p4, p5}, Lanet/channel/SessionRequest;->a(Lanet/channel/SessionRequest;Landroid/content/Context;Lanet/channel/entity/a;Lanet/channel/SessionRequest$IConnCb;Ljava/lang/String;)V

    return-void

    :cond_d
    :goto_3
    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 2060
    invoke-virtual {p3}, Lanet/channel/SessionRequest;->c()V

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 3060
    invoke-virtual {p3, p1, p4, p5}, Lanet/channel/SessionRequest;->a(Lanet/channel/Session;II)V

    iget-object p1, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 4060
    iget-object p1, p1, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 318
    monitor-enter p1

    :try_start_1
    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 5060
    iget-object p3, p3, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 319
    invoke-virtual {p3}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object p3

    invoke-interface {p3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :cond_e
    :goto_4
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result p4

    if-eqz p4, :cond_f

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Ljava/util/Map$Entry;

    .line 320
    invoke-interface {p4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object p5

    check-cast p5, Lanet/channel/SessionRequest$c;

    .line 321
    iget-object v1, p5, Lanet/channel/SessionRequest$c;->b:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1, v0, p2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v1

    if-eqz v1, :cond_e

    .line 322
    invoke-static {p5}, Lanet/channel/thread/ThreadPoolExecutorFactory;->removeScheduleTask(Ljava/lang/Runnable;)V

    .line 323
    invoke-interface {p4}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Lanet/channel/SessionGetCallback;

    invoke-interface {p4}, Lanet/channel/SessionGetCallback;->onSessionGetFail()V

    goto :goto_4

    :cond_f
    iget-object p2, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 6060
    iget-object p2, p2, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 326
    invoke-virtual {p2}, Ljava/util/HashMap;->clear()V

    .line 327
    monitor-exit p1

    return-void

    :catchall_1
    move-exception p2

    monitor-exit p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    throw p2
.end method

.method public onSuccess(Lanet/channel/Session;J)V
    .locals 5

    const-string p2, "awcn.SessionRequest"

    const-string p3, "Connect Success"

    iget-object v0, p0, Lanet/channel/SessionRequest$a;->e:Lanet/channel/entity/a;

    .line 381
    invoke-virtual {v0}, Lanet/channel/entity/a;->h()Ljava/lang/String;

    move-result-object v0

    const-string v1, "session"

    const-string v2, "host"

    iget-object v3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    invoke-virtual {v3}, Lanet/channel/SessionRequest;->a()Ljava/lang/String;

    move-result-object v3

    filled-new-array {v1, p1, v2, v3}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {p2, p3, v0, v1}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 p2, 0x0

    :try_start_0
    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 383
    iget-boolean p3, p3, Lanet/channel/SessionRequest;->f:Z

    if-eqz p3, :cond_0

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 384
    iput-boolean p2, p3, Lanet/channel/SessionRequest;->f:Z

    .line 385
    invoke-virtual {p1, p2}, Lanet/channel/Session;->close(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    iget-object p1, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 12060
    invoke-virtual {p1}, Lanet/channel/SessionRequest;->c()V

    return-void

    :cond_0
    :try_start_1
    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 13060
    iget-object p3, p3, Lanet/channel/SessionRequest;->b:Lanet/channel/e;

    iget-object v0, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 389
    invoke-virtual {p3, v0, p1}, Lanet/channel/e;->a(Lanet/channel/SessionRequest;Lanet/channel/Session;)V

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 14060
    invoke-virtual {p3, p1}, Lanet/channel/SessionRequest;->a(Lanet/channel/Session;)V

    iget-object p3, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 15060
    iget-object p3, p3, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 391
    monitor-enter p3
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    :try_start_2
    iget-object v0, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 16060
    iget-object v0, v0, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 392
    invoke-virtual {v0}, Ljava/util/HashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 393
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lanet/channel/SessionRequest$c;

    .line 394
    iget-object v3, v2, Lanet/channel/SessionRequest$c;->b:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v4, 0x1

    invoke-virtual {v3, p2, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 395
    invoke-static {v2}, Lanet/channel/thread/ThreadPoolExecutorFactory;->removeScheduleTask(Ljava/lang/Runnable;)V

    .line 396
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/SessionGetCallback;

    invoke-interface {v1, p1}, Lanet/channel/SessionGetCallback;->onSessionGetSuccess(Lanet/channel/Session;)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 17060
    iget-object p1, p1, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 399
    invoke-virtual {p1}, Ljava/util/HashMap;->clear()V

    .line 400
    monitor-exit p3
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    iget-object p1, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 18060
    invoke-virtual {p1}, Lanet/channel/SessionRequest;->c()V

    goto :goto_1

    :catchall_0
    move-exception p1

    .line 400
    :try_start_3
    monitor-exit p3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    :try_start_4
    throw p1
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    :catchall_1
    move-exception p1

    goto :goto_2

    :catch_0
    move-exception p1

    :try_start_5
    const-string p3, "awcn.SessionRequest"

    const-string v0, "[onSuccess]:"

    iget-object v1, p0, Lanet/channel/SessionRequest$a;->e:Lanet/channel/entity/a;

    .line 402
    invoke-virtual {v1}, Lanet/channel/entity/a;->h()Ljava/lang/String;

    move-result-object v1

    new-array p2, p2, [Ljava/lang/Object;

    invoke-static {p3, v0, v1, p1, p2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    iget-object p1, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 19060
    invoke-virtual {p1}, Lanet/channel/SessionRequest;->c()V

    :goto_1
    return-void

    :goto_2
    iget-object p2, p0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 20060
    invoke-virtual {p2}, Lanet/channel/SessionRequest;->c()V

    .line 405
    throw p1
.end method
