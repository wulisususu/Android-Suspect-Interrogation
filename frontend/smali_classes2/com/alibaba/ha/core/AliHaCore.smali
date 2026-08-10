.class public Lcom/alibaba/ha/core/AliHaCore;
.super Ljava/lang/Object;
.source "AliHaCore.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/ha/core/AliHaCore$b;
    }
.end annotation


# instance fields
.field private final TAG:Ljava/lang/String;

.field private plugins:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/alibaba/ha/protocol/AliHaPlugin;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 23
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/core/AliHaCore;->plugins:Ljava/util/List;

    const-string v0, "AliHaCore"

    iput-object v0, p0, Lcom/alibaba/ha/core/AliHaCore;->TAG:Ljava/lang/String;

    return-void
.end method

.method public synthetic constructor <init>(Lcom/alibaba/ha/core/AliHaCore$a;)V
    .locals 0

    .line 18
    invoke-direct {p0}, Lcom/alibaba/ha/core/AliHaCore;-><init>()V

    return-void
.end method

.method public static getInstance()Lcom/alibaba/ha/core/AliHaCore;
    .locals 1

    .line 42
    invoke-static {}, Lcom/alibaba/ha/core/AliHaCore$b;->a()Lcom/alibaba/ha/core/AliHaCore;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public registPlugin(Lcom/alibaba/ha/protocol/AliHaPlugin;)V
    .locals 1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/alibaba/ha/core/AliHaCore;->plugins:Ljava/util/List;

    .line 51
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public start(Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/ha/core/AliHaCore;->plugins:Ljava/util/List;

    .line 59
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/AliHaPlugin;

    .line 60
    invoke-virtual {p0, p1, v1}, Lcom/alibaba/ha/core/AliHaCore;->startWithPlugin(Lcom/alibaba/ha/protocol/AliHaParam;Lcom/alibaba/ha/protocol/AliHaPlugin;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public startWithPlugin(Lcom/alibaba/ha/protocol/AliHaParam;Lcom/alibaba/ha/protocol/AliHaPlugin;)V
    .locals 6

    if-eqz p1, :cond_1

    if-eqz p2, :cond_1

    .line 71
    invoke-interface {p2}, Lcom/alibaba/ha/protocol/AliHaPlugin;->getName()Ljava/lang/String;

    move-result-object v0

    .line 73
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    if-nez v0, :cond_0

    const-string v0, "Unknown"

    .line 77
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "start init plugin "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "AliHaCore"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 80
    invoke-interface {p2, p1}, Lcom/alibaba/ha/protocol/AliHaPlugin;->start(Lcom/alibaba/ha/protocol/AliHaParam;)V

    .line 82
    new-instance p1, Ljava/lang/StringBuilder;

    const-string p2, "end init plugin "

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " "

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    sub-long/2addr v4, v0

    invoke-virtual {p1, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "ms"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v3, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    return-void
.end method
