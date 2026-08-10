.class public Lcom/alibaba/ha/adapter/plugin/WatchPlugin;
.super Ljava/lang/Object;
.source "WatchPlugin.java"

# interfaces
.implements Lcom/alibaba/ha/protocol/AliHaPlugin;


# instance fields
.field public enabling:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 25
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/plugin/WatchPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method


# virtual methods
.method public getName()Ljava/lang/String;
    .locals 1

    .line 35
    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->watch:Lcom/alibaba/ha/adapter/Plugin;

    invoke-virtual {v0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public start(Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 6

    .line 44
    iget-object v0, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appVersion:Ljava/lang/String;

    .line 45
    iget-object p1, p1, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;

    const-string v1, "param is unlegal, watch plugin start failure "

    const-string v2, "AliHaAdapter"

    if-eqz p1, :cond_2

    if-nez v0, :cond_0

    goto :goto_1

    :cond_0
    iget-object v3, p0, Lcom/alibaba/ha/adapter/plugin/WatchPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v4, 0x1

    const/4 v5, 0x0

    .line 51
    invoke-virtual {v3, v5, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 54
    :try_start_0
    invoke-static {}, Lcom/alibaba/motu/watch/MotuWatch;->getInstance()Lcom/alibaba/motu/watch/MotuWatch;

    move-result-object v3

    invoke-static {v5}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-virtual {v3, p1, v0, v4}, Lcom/alibaba/motu/watch/MotuWatch;->enableWatch(Landroid/content/Context;Ljava/lang/String;Ljava/lang/Boolean;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 56
    invoke-static {v2, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 60
    :goto_0
    new-instance p1, Lcom/alibaba/ha/adapter/service/watch/WatchActivityPathCallBack;

    invoke-direct {p1}, Lcom/alibaba/ha/adapter/service/watch/WatchActivityPathCallBack;-><init>()V

    .line 61
    invoke-static {p1}, Lcom/alibaba/ha/adapter/service/watch/WatchService;->addWatchListener(Lcom/alibaba/ha/adapter/service/watch/WatchListener;)V

    :cond_1
    return-void

    .line 47
    :cond_2
    :goto_1
    invoke-static {v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
