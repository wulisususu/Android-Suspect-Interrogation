.class Lanet/channel/heartbeat/b;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/heartbeat/IHeartbeat;
.implements Ljava/lang/Runnable;


# instance fields
.field private a:Lanet/channel/Session;

.field private volatile b:J

.field private volatile c:Z

.field private d:J


# direct methods
.method constructor <init>()V
    .locals 3

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lanet/channel/heartbeat/b;->b:J

    const/4 v2, 0x0

    iput-boolean v2, p0, Lanet/channel/heartbeat/b;->c:Z

    iput-wide v0, p0, Lanet/channel/heartbeat/b;->d:J

    return-void
.end method

.method private a(J)V
    .locals 3

    .line 77
    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    add-long/2addr v0, p1

    iput-wide v0, p0, Lanet/channel/heartbeat/b;->b:J

    const-wide/16 v0, 0x32

    add-long/2addr p1, v0

    .line 78
    sget-object v0, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {p0, p1, p2, v0}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object p2, p0, Lanet/channel/heartbeat/b;->a:Lanet/channel/Session;

    .line 80
    iget-object p2, p2, Lanet/channel/Session;->p:Ljava/lang/String;

    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "awcn.DefaultHeartbeatImpl"

    const-string v2, "Submit heartbeat task failed."

    invoke-static {v1, v2, p2, p1, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method


# virtual methods
.method public reSchedule()V
    .locals 4

    .line 46
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lanet/channel/heartbeat/b;->d:J

    add-long/2addr v0, v2

    iput-wide v0, p0, Lanet/channel/heartbeat/b;->b:J

    return-void
.end method

.method public run()V
    .locals 6

    iget-boolean v0, p0, Lanet/channel/heartbeat/b;->c:Z

    if-eqz v0, :cond_0

    return-void

    .line 55
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lanet/channel/heartbeat/b;->b:J

    const-wide/16 v4, 0x3e8

    sub-long/2addr v2, v4

    cmp-long v2, v0, v2

    if-gez v2, :cond_1

    iget-wide v2, p0, Lanet/channel/heartbeat/b;->b:J

    sub-long/2addr v2, v0

    .line 57
    invoke-direct {p0, v2, v3}, Lanet/channel/heartbeat/b;->a(J)V

    return-void

    .line 61
    :cond_1
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v0

    const-string v1, "session"

    const-string v2, "awcn.DefaultHeartbeatImpl"

    if-nez v0, :cond_3

    const/4 v0, 0x1

    .line 63
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v3

    if-eqz v3, :cond_2

    iget-object v3, p0, Lanet/channel/heartbeat/b;->a:Lanet/channel/Session;

    .line 64
    iget-object v3, v3, Lanet/channel/Session;->p:Ljava/lang/String;

    iget-object v4, p0, Lanet/channel/heartbeat/b;->a:Lanet/channel/Session;

    filled-new-array {v1, v4}, [Ljava/lang/Object;

    move-result-object v1

    const-string v4, "heartbeat"

    invoke-static {v2, v4, v3, v1}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_2
    iget-object v1, p0, Lanet/channel/heartbeat/b;->a:Lanet/channel/Session;

    .line 66
    invoke-virtual {v1, v0}, Lanet/channel/Session;->ping(Z)V

    iget-wide v0, p0, Lanet/channel/heartbeat/b;->d:J

    .line 67
    invoke-direct {p0, v0, v1}, Lanet/channel/heartbeat/b;->a(J)V

    return-void

    :cond_3
    iget-object v0, p0, Lanet/channel/heartbeat/b;->a:Lanet/channel/Session;

    .line 69
    iget-object v0, v0, Lanet/channel/Session;->p:Ljava/lang/String;

    iget-object v3, p0, Lanet/channel/heartbeat/b;->a:Lanet/channel/Session;

    filled-new-array {v1, v3}, [Ljava/lang/Object;

    move-result-object v1

    const-string v3, "close session in background"

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lanet/channel/heartbeat/b;->a:Lanet/channel/Session;

    const/4 v1, 0x0

    .line 70
    invoke-virtual {v0, v1}, Lanet/channel/Session;->close(Z)V

    return-void
.end method

.method public start(Lanet/channel/Session;)V
    .locals 4

    if-eqz p1, :cond_1

    iput-object p1, p0, Lanet/channel/heartbeat/b;->a:Lanet/channel/Session;

    .line 27
    invoke-virtual {p1}, Lanet/channel/Session;->getConnStrategy()Lanet/channel/strategy/IConnStrategy;

    move-result-object v0

    invoke-interface {v0}, Lanet/channel/strategy/IConnStrategy;->getHeartbeat()I

    move-result v0

    int-to-long v0, v0

    iput-wide v0, p0, Lanet/channel/heartbeat/b;->d:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-gtz v0, :cond_0

    const-wide/32 v0, 0xafc8

    iput-wide v0, p0, Lanet/channel/heartbeat/b;->d:J

    .line 31
    :cond_0
    iget-object v0, p1, Lanet/channel/Session;->p:Ljava/lang/String;

    iget-wide v1, p0, Lanet/channel/heartbeat/b;->d:J

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "session"

    const-string v3, "interval"

    filled-new-array {v2, p1, v3, v1}, [Ljava/lang/Object;

    move-result-object p1

    const-string v1, "awcn.DefaultHeartbeatImpl"

    const-string v2, "heartbeat start"

    invoke-static {v1, v2, v0, p1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-wide v0, p0, Lanet/channel/heartbeat/b;->d:J

    .line 32
    invoke-direct {p0, v0, v1}, Lanet/channel/heartbeat/b;->a(J)V

    return-void

    .line 24
    :cond_1
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "session is null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public stop()V
    .locals 4

    iget-object v0, p0, Lanet/channel/heartbeat/b;->a:Lanet/channel/Session;

    if-nez v0, :cond_0

    return-void

    .line 40
    :cond_0
    iget-object v0, v0, Lanet/channel/Session;->p:Ljava/lang/String;

    const-string v1, "session"

    iget-object v2, p0, Lanet/channel/heartbeat/b;->a:Lanet/channel/Session;

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "awcn.DefaultHeartbeatImpl"

    const-string v3, "heartbeat stop"

    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanet/channel/heartbeat/b;->c:Z

    return-void
.end method
