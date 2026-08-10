.class public Lcom/alibaba/ha/adapter/plugin/TLogPlugin;
.super Ljava/lang/Object;
.source "TLogPlugin.java"

# interfaces
.implements Lcom/alibaba/ha/protocol/AliHaPlugin;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/ha/adapter/plugin/TLogPlugin$Service;
    }
.end annotation


# instance fields
.field public enabling:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method


# virtual methods
.method public getName()Ljava/lang/String;
    .locals 1

    .line 41
    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->tlog:Lcom/alibaba/ha/adapter/Plugin;

    invoke-virtual {v0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public start(Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 12

    .line 46
    iget-object v5, p1, Lcom/alibaba/ha/protocol/AliHaParam;->application:Landroid/app/Application;

    .line 47
    iget-object v2, p1, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;

    .line 48
    iget-object v3, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    .line 49
    iget-object v8, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appId:Ljava/lang/String;

    .line 50
    iget-object v6, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appSecret:Ljava/lang/String;

    .line 51
    iget-object v4, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appVersion:Ljava/lang/String;

    .line 52
    iget-object v7, p1, Lcom/alibaba/ha/protocol/AliHaParam;->userNick:Ljava/lang/String;

    if-eqz v2, :cond_2

    if-eqz v3, :cond_2

    if-eqz v4, :cond_2

    .line 53
    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/TLogPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    const/4 v9, 0x0

    .line 58
    invoke-virtual {v0, v9, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 59
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0, v9}, Lcom/taobao/tao/log/TLogInitializer;->setInitSync(Z)Lcom/taobao/tao/log/TLogInitializer;

    .line 61
    new-instance v10, Ljava/lang/Thread;

    new-instance v11, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;

    move-object v0, v11

    move-object v1, p0

    move-object v9, p1

    invoke-direct/range {v0 .. v9}, Lcom/alibaba/ha/adapter/plugin/TLogPlugin$1;-><init>(Lcom/alibaba/ha/adapter/plugin/TLogPlugin;Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Landroid/app/Application;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/ha/protocol/AliHaParam;)V

    invoke-direct {v10, v11}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 118
    invoke-virtual {v10}, Ljava/lang/Thread;->start()V

    :cond_1
    return-void

    :cond_2
    :goto_0
    const-string p1, "AliHaAdapter"

    const-string v0, "param is unlegal, tlog plugin start failure "

    .line 54
    invoke-static {p1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
