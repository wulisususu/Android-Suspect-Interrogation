.class public Lcom/alibaba/ha/adapter/plugin/UtPlugin;
.super Ljava/lang/Object;
.source "UtPlugin.java"

# interfaces
.implements Lcom/alibaba/ha/protocol/AliHaPlugin;


# instance fields
.field public enabling:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 29
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method


# virtual methods
.method public getName()Ljava/lang/String;
    .locals 1

    .line 37
    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->ut:Lcom/alibaba/ha/adapter/Plugin;

    invoke-virtual {v0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public start(Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 11

    .line 42
    iget-object v6, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appId:Ljava/lang/String;

    .line 43
    iget-object v5, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    .line 44
    iget-object v4, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appSecret:Ljava/lang/String;

    .line 45
    iget-object v2, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appVersion:Ljava/lang/String;

    .line 46
    iget-object v7, p1, Lcom/alibaba/ha/protocol/AliHaParam;->application:Landroid/app/Application;

    const-string v0, "AliHaAdapter"

    if-eqz v7, :cond_2

    if-eqz v6, :cond_2

    if-eqz v5, :cond_2

    if-nez v2, :cond_0

    goto :goto_0

    .line 53
    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v3, "init ut, appId is "

    invoke-direct {v1, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " appKey is "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " appVersion is "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, " channel is "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v3, p1, Lcom/alibaba/ha/protocol/AliHaParam;->channel:Ljava/lang/String;

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    const/4 v8, 0x0

    .line 56
    invoke-virtual {v0, v8, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 57
    invoke-static {}, Lcom/ut/mini/UTAnalytics;->getInstance()Lcom/ut/mini/UTAnalytics;

    move-result-object v9

    new-instance v10, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;

    move-object v0, v10

    move-object v1, p0

    move-object v3, p1

    invoke-direct/range {v0 .. v6}, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;-><init>(Lcom/alibaba/ha/adapter/plugin/UtPlugin;Ljava/lang/String;Lcom/alibaba/ha/protocol/AliHaParam;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v9, v7, v10}, Lcom/ut/mini/UTAnalytics;->setAppApplicationInstance(Landroid/app/Application;Lcom/ut/mini/IUTApplication;)V

    .line 111
    :try_start_0
    invoke-static {v7}, Lcom/alibaba/mtl/appmonitor/AppMonitor;->init(Landroid/app/Application;)V

    .line 112
    iget-object v0, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    iget-object v1, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appSecret:Ljava/lang/String;

    invoke-static {v8, v0, v1}, Lcom/alibaba/mtl/appmonitor/AppMonitor;->setRequestAuthInfo(ZLjava/lang/String;Ljava/lang/String;)V

    .line 113
    iget-object p1, p1, Lcom/alibaba/ha/protocol/AliHaParam;->channel:Ljava/lang/String;

    invoke-static {p1}, Lcom/alibaba/mtl/appmonitor/AppMonitor;->setChannel(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void

    :cond_2
    :goto_0
    const-string p1, "param is unlegal, ut plugin start failure "

    .line 48
    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
