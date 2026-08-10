.class public Lcom/alibaba/ha/adapter/plugin/APMPlugin;
.super Ljava/lang/Object;
.source "APMPlugin.java"

# interfaces
.implements Lcom/alibaba/ha/protocol/AliHaPlugin;


# instance fields
.field public enabling:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/plugin/APMPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method private initApplicationMonitor(Landroid/app/Application;Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 3

    .line 69
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 71
    iget-object v1, p2, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    const-string v2, "onlineAppKey"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 72
    iget-object v1, p2, Lcom/alibaba/ha/protocol/AliHaParam;->appVersion:Ljava/lang/String;

    const-string v2, "appVersion"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 73
    invoke-virtual {p1}, Landroid/app/Application;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget-object v1, v1, Landroid/content/pm/ApplicationInfo;->processName:Ljava/lang/String;

    const-string v2, "process"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 74
    iget-object p2, p2, Lcom/alibaba/ha/protocol/AliHaParam;->channel:Ljava/lang/String;

    const-string v1, "channel"

    invoke-virtual {v0, v1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 76
    new-instance p2, Lcom/taobao/monitor/adapter/SimpleApmInitiator;

    invoke-direct {p2}, Lcom/taobao/monitor/adapter/SimpleApmInitiator;-><init>()V

    invoke-virtual {p2, p1, v0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->init(Landroid/app/Application;Ljava/util/HashMap;)V

    return-void
.end method


# virtual methods
.method public getName()Ljava/lang/String;
    .locals 1

    .line 33
    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->apm:Lcom/alibaba/ha/adapter/Plugin;

    invoke-virtual {v0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public start(Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 7

    const-string v0, "init apm, appId is "

    .line 40
    :try_start_0
    iget-object v1, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appId:Ljava/lang/String;

    .line 41
    iget-object v2, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    .line 42
    iget-object v3, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appVersion:Ljava/lang/String;

    .line 43
    iget-object v4, p1, Lcom/alibaba/ha/protocol/AliHaParam;->application:Landroid/app/Application;

    .line 44
    iget-object v5, p1, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string v6, "AliHaAdapter"

    if-eqz p1, :cond_1

    if-eqz v5, :cond_1

    if-eqz v4, :cond_1

    if-eqz v1, :cond_1

    if-eqz v2, :cond_1

    if-nez v3, :cond_0

    goto :goto_0

    .line 51
    :cond_0
    :try_start_1
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " appKey is "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " appVersion is "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v6, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/APMPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    .line 54
    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 56
    invoke-direct {p0, v4, p1}, Lcom/alibaba/ha/adapter/plugin/APMPlugin;->initApplicationMonitor(Landroid/app/Application;Lcom/alibaba/ha/protocol/AliHaParam;)V

    goto :goto_1

    :cond_1
    :goto_0
    const-string p1, "param is unlegal, applicationmonitor plugin start failure "

    .line 46
    invoke-static {v6, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    return-void

    :catch_0
    move-exception p1

    .line 59
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_2
    :goto_1
    return-void
.end method
