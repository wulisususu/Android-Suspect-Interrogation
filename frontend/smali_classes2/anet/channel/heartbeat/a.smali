.class public Lanet/channel/heartbeat/a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/heartbeat/IHeartbeat;
.implements Ljava/lang/Runnable;


# instance fields
.field a:Lanet/channel/Session;

.field volatile b:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lanet/channel/heartbeat/a;->a:Lanet/channel/Session;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lanet/channel/heartbeat/a;->b:Z

    return-void
.end method


# virtual methods
.method public reSchedule()V
    .locals 0

    return-void
.end method

.method public run()V
    .locals 3

    iget-boolean v0, p0, Lanet/channel/heartbeat/a;->b:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lanet/channel/heartbeat/a;->a:Lanet/channel/Session;

    const/4 v1, 0x1

    .line 42
    invoke-virtual {v0, v1}, Lanet/channel/Session;->ping(Z)V

    const-wide/32 v0, 0xafc8

    .line 43
    sget-object v2, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-static {p0, v0, v1, v2}, Lanet/channel/thread/ThreadPoolExecutorFactory;->submitScheduledTask(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/Future;

    return-void
.end method

.method public start(Lanet/channel/Session;)V
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lanet/channel/heartbeat/a;->a:Lanet/channel/Session;

    .line 23
    invoke-virtual {p0}, Lanet/channel/heartbeat/a;->run()V

    return-void

    .line 20
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "session is null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public stop()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lanet/channel/heartbeat/a;->b:Z

    return-void
.end method
