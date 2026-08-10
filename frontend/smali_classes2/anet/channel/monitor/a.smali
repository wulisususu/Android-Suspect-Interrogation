.class public Lanet/channel/monitor/a;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field private static volatile a:Lanet/channel/monitor/a;


# instance fields
.field private b:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lanet/channel/monitor/INetworkQualityChangeListener;",
            "Lanet/channel/monitor/f;",
            ">;"
        }
    .end annotation
.end field

.field private c:Lanet/channel/monitor/f;


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 15
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lanet/channel/monitor/a;->b:Ljava/util/Map;

    .line 16
    new-instance v0, Lanet/channel/monitor/f;

    invoke-direct {v0}, Lanet/channel/monitor/f;-><init>()V

    iput-object v0, p0, Lanet/channel/monitor/a;->c:Lanet/channel/monitor/f;

    return-void
.end method

.method public static a()Lanet/channel/monitor/a;
    .locals 2

    sget-object v0, Lanet/channel/monitor/a;->a:Lanet/channel/monitor/a;

    if-nez v0, :cond_1

    const-class v0, Lanet/channel/monitor/a;

    .line 23
    monitor-enter v0

    :try_start_0
    sget-object v1, Lanet/channel/monitor/a;->a:Lanet/channel/monitor/a;

    if-nez v1, :cond_0

    .line 25
    new-instance v1, Lanet/channel/monitor/a;

    invoke-direct {v1}, Lanet/channel/monitor/a;-><init>()V

    sput-object v1, Lanet/channel/monitor/a;->a:Lanet/channel/monitor/a;

    .line 27
    :cond_0
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    :cond_1
    :goto_0
    sget-object v0, Lanet/channel/monitor/a;->a:Lanet/channel/monitor/a;

    return-object v0
.end method


# virtual methods
.method public a(D)V
    .locals 5

    iget-object v0, p0, Lanet/channel/monitor/a;->b:Ljava/util/Map;

    .line 51
    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    .line 52
    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lanet/channel/monitor/INetworkQualityChangeListener;

    .line 53
    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/monitor/f;

    if-eqz v2, :cond_0

    if-nez v1, :cond_1

    goto :goto_0

    .line 58
    :cond_1
    invoke-virtual {v1}, Lanet/channel/monitor/f;->b()Z

    move-result v3

    if-eqz v3, :cond_2

    goto :goto_0

    .line 61
    :cond_2
    invoke-virtual {v1, p1, p2}, Lanet/channel/monitor/f;->a(D)Z

    move-result v3

    .line 1013
    iget-boolean v4, v1, Lanet/channel/monitor/f;->a:Z

    if-eq v4, v3, :cond_0

    .line 1017
    iput-boolean v3, v1, Lanet/channel/monitor/f;->a:Z

    if-eqz v3, :cond_3

    .line 64
    sget-object v1, Lanet/channel/monitor/NetworkSpeed;->Slow:Lanet/channel/monitor/NetworkSpeed;

    goto :goto_1

    :cond_3
    sget-object v1, Lanet/channel/monitor/NetworkSpeed;->Fast:Lanet/channel/monitor/NetworkSpeed;

    .line 65
    :goto_1
    invoke-interface {v2, v1}, Lanet/channel/monitor/INetworkQualityChangeListener;->onNetworkQualityChanged(Lanet/channel/monitor/NetworkSpeed;)V

    goto :goto_0

    :cond_4
    return-void
.end method

.method public a(Lanet/channel/monitor/INetworkQualityChangeListener;)V
    .locals 1

    iget-object v0, p0, Lanet/channel/monitor/a;->b:Ljava/util/Map;

    .line 47
    invoke-interface {v0, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public a(Lanet/channel/monitor/INetworkQualityChangeListener;Lanet/channel/monitor/f;)V
    .locals 2

    if-nez p1, :cond_0

    const/4 p1, 0x0

    new-array p1, p1, [Ljava/lang/Object;

    const-string p2, "BandWidthListenerHelp"

    const-string v0, "listener is null"

    const/4 v1, 0x0

    .line 34
    invoke-static {p2, v0, v1, p1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    :cond_0
    if-nez p2, :cond_1

    iget-object p2, p0, Lanet/channel/monitor/a;->c:Lanet/channel/monitor/f;

    .line 38
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p2, Lanet/channel/monitor/f;->b:J

    iget-object p2, p0, Lanet/channel/monitor/a;->b:Ljava/util/Map;

    iget-object v0, p0, Lanet/channel/monitor/a;->c:Lanet/channel/monitor/f;

    .line 39
    invoke-interface {p2, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 41
    :cond_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p2, Lanet/channel/monitor/f;->b:J

    iget-object v0, p0, Lanet/channel/monitor/a;->b:Ljava/util/Map;

    .line 42
    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    return-void
.end method
