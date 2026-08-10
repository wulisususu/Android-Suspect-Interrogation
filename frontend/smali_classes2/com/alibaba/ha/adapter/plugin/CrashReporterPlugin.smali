.class public Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;
.super Ljava/lang/Object;
.source "CrashReporterPlugin.java"

# interfaces
.implements Lcom/alibaba/ha/protocol/AliHaPlugin;


# instance fields
.field public enabling:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method


# virtual methods
.method public getName()Ljava/lang/String;
    .locals 1

    .line 34
    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->crashreporter:Lcom/alibaba/ha/adapter/Plugin;

    invoke-virtual {v0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public start(Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 11

    .line 43
    iget-object v4, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appId:Ljava/lang/String;

    .line 44
    iget-object v5, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    .line 45
    iget-object v6, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appSecret:Ljava/lang/String;

    .line 46
    iget-object v7, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appVersion:Ljava/lang/String;

    .line 47
    iget-object v3, p1, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;

    .line 48
    iget-boolean v2, p1, Lcom/alibaba/ha/protocol/AliHaParam;->enableInterceptNotMainThreadException:Z

    const-string v0, "AliHaAdapter"

    if-eqz v3, :cond_3

    if-eqz v4, :cond_3

    if-eqz v5, :cond_3

    if-nez v7, :cond_0

    goto :goto_1

    .line 55
    :cond_0
    iget-object v8, p1, Lcom/alibaba/ha/protocol/AliHaParam;->channel:Ljava/lang/String;

    .line 56
    iget-object v9, p1, Lcom/alibaba/ha/protocol/AliHaParam;->userNick:Ljava/lang/String;

    .line 57
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v10, "init crashreporter, appId is "

    invoke-direct {v1, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v10, " appKey is "

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v10, " appVersion is "

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v10, " channel is "

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v10, " userNick is "

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v10, 0x1

    .line 60
    invoke-virtual {v0, v1, v10}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 61
    new-instance v10, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;

    move-object v0, v10

    move-object v1, p0

    invoke-direct/range {v0 .. v9}, Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin$1;-><init>(Lcom/alibaba/ha/adapter/plugin/CrashReporterPlugin;ZLandroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 90
    iget-boolean p1, p1, Lcom/alibaba/ha/protocol/AliHaParam;->initAsync:Z

    if-eqz p1, :cond_1

    .line 91
    new-instance p1, Ljava/lang/Thread;

    invoke-direct {p1, v10}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {p1}, Ljava/lang/Thread;->start()V

    goto :goto_0

    .line 93
    :cond_1
    invoke-interface {v10}, Ljava/lang/Runnable;->run()V

    :cond_2
    :goto_0
    return-void

    :cond_3
    :goto_1
    const-string p1, "param is unlegal, crashreporter plugin start failure "

    .line 51
    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
