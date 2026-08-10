.class public Lanetwork/channel/monitor/Monitor;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field private static final TAG:Ljava/lang/String; = "anet.Monitor"

.field static isInit:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 22
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lanetwork/channel/monitor/Monitor;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addListener(Lanet/channel/monitor/INetworkQualityChangeListener;)V
    .locals 1

    const/4 v0, 0x0

    .line 93
    invoke-static {p0, v0}, Lanetwork/channel/monitor/Monitor;->addListener(Lanet/channel/monitor/INetworkQualityChangeListener;Lanet/channel/monitor/f;)V

    return-void
.end method

.method public static addListener(Lanet/channel/monitor/INetworkQualityChangeListener;Lanet/channel/monitor/f;)V
    .locals 1

    .line 101
    invoke-static {}, Lanet/channel/monitor/a;->a()Lanet/channel/monitor/a;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lanet/channel/monitor/a;->a(Lanet/channel/monitor/INetworkQualityChangeListener;Lanet/channel/monitor/f;)V

    return-void
.end method

.method public static getNetSpeed()Lanet/channel/monitor/NetworkSpeed;
    .locals 6

    .line 79
    sget-object v0, Lanet/channel/monitor/NetworkSpeed;->Fast:Lanet/channel/monitor/NetworkSpeed;

    .line 81
    :try_start_0
    invoke-static {}, Lanet/channel/monitor/b;->a()Lanet/channel/monitor/b;

    move-result-object v1

    invoke-virtual {v1}, Lanet/channel/monitor/b;->b()I

    move-result v1

    .line 82
    invoke-static {v1}, Lanet/channel/monitor/NetworkSpeed;->valueOfCode(I)Lanet/channel/monitor/NetworkSpeed;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v0

    :catchall_0
    move-exception v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "anet.Monitor"

    const-string v4, "getNetworkSpeed failed"

    const/4 v5, 0x0

    .line 84
    invoke-static {v3, v4, v5, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    return-object v0
.end method

.method public static getNetSpeedValue()D
    .locals 2

    .line 112
    invoke-static {}, Lanet/channel/monitor/b;->a()Lanet/channel/monitor/b;

    move-result-object v0

    invoke-virtual {v0}, Lanet/channel/monitor/b;->c()D

    move-result-wide v0

    return-wide v0
.end method

.method public static getNetworkSpeed()Lanetwork/channel/monitor/speed/NetworkSpeed;
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 68
    invoke-static {}, Lanetwork/channel/monitor/Monitor;->getNetSpeed()Lanet/channel/monitor/NetworkSpeed;

    move-result-object v0

    .line 69
    invoke-virtual {v0}, Lanet/channel/monitor/NetworkSpeed;->getCode()I

    move-result v0

    invoke-static {v0}, Lanetwork/channel/monitor/speed/NetworkSpeed;->valueOfCode(I)Lanetwork/channel/monitor/speed/NetworkSpeed;

    move-result-object v0

    return-object v0
.end method

.method public static declared-synchronized init()V
    .locals 4

    const-class v0, Lanetwork/channel/monitor/Monitor;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lanetwork/channel/monitor/Monitor;->isInit:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x0

    const/4 v3, 0x1

    .line 27
    invoke-virtual {v1, v2, v3}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 28
    invoke-static {}, Lanet/channel/monitor/b;->a()Lanet/channel/monitor/b;

    move-result-object v1

    invoke-virtual {v1}, Lanet/channel/monitor/b;->d()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 30
    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized init(Landroid/content/Context;)V
    .locals 1
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const-class p0, Lanetwork/channel/monitor/Monitor;

    monitor-enter p0

    .line 34
    :try_start_0
    invoke-static {}, Lanetwork/channel/monitor/Monitor;->init()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 35
    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public static removeListener(Lanet/channel/monitor/INetworkQualityChangeListener;)V
    .locals 1

    .line 105
    invoke-static {}, Lanet/channel/monitor/a;->a()Lanet/channel/monitor/a;

    move-result-object v0

    invoke-virtual {v0, p0}, Lanet/channel/monitor/a;->a(Lanet/channel/monitor/INetworkQualityChangeListener;)V

    return-void
.end method

.method public static start()V
    .locals 5

    .line 45
    :try_start_0
    invoke-static {}, Lanet/channel/monitor/b;->a()Lanet/channel/monitor/b;

    move-result-object v0

    invoke-virtual {v0}, Lanet/channel/monitor/b;->d()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "anet.Monitor"

    const-string v3, "start failed"

    const/4 v4, 0x0

    .line 47
    invoke-static {v2, v3, v4, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method

.method public static stop()V
    .locals 5

    .line 56
    :try_start_0
    invoke-static {}, Lanet/channel/monitor/b;->a()Lanet/channel/monitor/b;

    move-result-object v0

    invoke-virtual {v0}, Lanet/channel/monitor/b;->e()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "anet.Monitor"

    const-string v3, "stop failed"

    const/4 v4, 0x0

    .line 58
    invoke-static {v2, v3, v4, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :goto_0
    return-void
.end method
