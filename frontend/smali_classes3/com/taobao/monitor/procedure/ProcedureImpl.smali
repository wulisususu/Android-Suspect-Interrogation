.class public Lcom/taobao/monitor/procedure/ProcedureImpl;
.super Ljava/lang/Object;
.source "ProcedureImpl.java"

# interfaces
.implements Lcom/taobao/monitor/procedure/IProcedureGroup;
.implements Lcom/taobao/monitor/procedure/IValueCallback;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;,
        Lcom/taobao/monitor/procedure/ProcedureImpl$Status;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "ProcedureImpl"

.field private static volatile count:J


# instance fields
.field private final independent:Z

.field private lifeCycle:Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;

.field private needUpload:Z

.field private final parent:Lcom/taobao/monitor/procedure/IProcedure;

.field private final session:Ljava/lang/String;

.field private status:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

.field private subProcedures:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/taobao/monitor/procedure/IProcedure;",
            ">;"
        }
    .end annotation
.end field

.field private topic:Ljava/lang/String;

.field private final value:Lcom/taobao/monitor/procedure/Value;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 22
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lcom/taobao/monitor/procedure/ProcedureImpl;->count:J

    return-void
.end method

.method constructor <init>(Ljava/lang/String;Lcom/taobao/monitor/procedure/IProcedure;ZZ)V
    .locals 4
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0,
            0x0,
            0x0
        }
        names = {
            "topic",
            "parent",
            "independent",
            "parentNeedStats"
        }
    .end annotation

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-wide v0, Lcom/taobao/monitor/procedure/ProcedureImpl;->count:J

    const-wide/16 v2, 0x1

    add-long/2addr v2, v0

    sput-wide v2, Lcom/taobao/monitor/procedure/ProcedureImpl;->count:J

    .line 25
    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->session:Ljava/lang/String;

    .line 34
    sget-object v1, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->INIT:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    iput-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->status:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->topic:Ljava/lang/String;

    iput-object p2, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    iput-boolean p3, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->independent:Z

    .line 51
    new-instance v1, Lcom/taobao/monitor/procedure/Value;

    invoke-direct {v1, p1, p3, p4}, Lcom/taobao/monitor/procedure/Value;-><init>(Ljava/lang/String;ZZ)V

    iput-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    if-eqz p2, :cond_0

    const-string p1, "parentSession"

    .line 53
    invoke-interface {p2}, Lcom/taobao/monitor/procedure/IProcedure;->topicSession()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v1, p1, p2}, Lcom/taobao/monitor/procedure/Value;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/Value;

    :cond_0
    const-string p1, "session"

    .line 55
    invoke-virtual {v1, p1, v0}, Lcom/taobao/monitor/procedure/Value;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/Value;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->needUpload:Z

    return-void
.end method

.method static synthetic access$000(Lcom/taobao/monitor/procedure/ProcedureImpl;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 0

    .line 16
    iget-object p0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    return-object p0
.end method


# virtual methods
.method public addBiz(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "bizID",
            "properties"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Lcom/taobao/monitor/procedure/IProcedure;"
        }
    .end annotation

    if-eqz p1, :cond_0

    .line 118
    invoke-virtual {p0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 119
    invoke-virtual {v0, p1, p2}, Lcom/taobao/monitor/procedure/Value;->addBiz(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/Value;

    iget-object p2, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->topic:Ljava/lang/String;

    .line 120
    filled-new-array {p2, v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "ProcedureImpl"

    invoke-static {p2, p1}, Lcom/taobao/monitor/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    return-object p0
.end method

.method public addBizAbTest(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "bizID",
            "abTest"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Lcom/taobao/monitor/procedure/IProcedure;"
        }
    .end annotation

    if-eqz p1, :cond_0

    .line 127
    invoke-virtual {p0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 128
    invoke-virtual {v0, p1, p2}, Lcom/taobao/monitor/procedure/Value;->addBizAbTest(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/Value;

    iget-object p2, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->topic:Ljava/lang/String;

    .line 129
    filled-new-array {p2, v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "ProcedureImpl"

    invoke-static {p2, p1}, Lcom/taobao/monitor/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    return-object p0
.end method

.method public addBizStage(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "bizID",
            "stage"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Lcom/taobao/monitor/procedure/IProcedure;"
        }
    .end annotation

    if-eqz p1, :cond_0

    .line 136
    invoke-virtual {p0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 137
    invoke-virtual {v0, p1, p2}, Lcom/taobao/monitor/procedure/Value;->addBizStage(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/Value;

    iget-object p2, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->topic:Ljava/lang/String;

    .line 138
    filled-new-array {p2, v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "ProcedureImpl"

    invoke-static {p2, p1}, Lcom/taobao/monitor/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    return-object p0
.end method

.method public addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "key",
            "object"
        }
    .end annotation

    .line 146
    invoke-virtual {p0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 147
    invoke-virtual {v0, p1, p2}, Lcom/taobao/monitor/procedure/Value;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/Value;

    :cond_0
    return-object p0
.end method

.method public addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "key",
            "object"
        }
    .end annotation

    .line 154
    invoke-virtual {p0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 155
    invoke-virtual {v0, p1, p2}, Lcom/taobao/monitor/procedure/Value;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/Value;

    :cond_0
    return-object p0
.end method

.method public addSubProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "subProcedure"
        }
    .end annotation

    if-eqz p1, :cond_0

    .line 228
    invoke-virtual {p0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->subProcedures:Ljava/util/List;

    .line 230
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->subProcedures:Ljava/util/List;

    .line 231
    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 232
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_0
    :goto_0
    return-void
.end method

.method public begin()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->status:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    .line 72
    sget-object v1, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->INIT:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    if-ne v0, v1, :cond_1

    .line 73
    sget-object v0, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->RUNNING:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    iput-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->status:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    .line 74
    instance-of v1, v0, Lcom/taobao/monitor/procedure/IProcedureGroup;

    if-eqz v1, :cond_0

    .line 75
    check-cast v0, Lcom/taobao/monitor/procedure/IProcedureGroup;

    invoke-interface {v0, p0}, Lcom/taobao/monitor/procedure/IProcedureGroup;->addSubProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    .line 78
    :cond_0
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->subProcedures:Ljava/util/List;

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->topic:Ljava/lang/String;

    const-string v2, "begin()"

    .line 79
    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ProcedureImpl"

    invoke-static {v1, v0}, Lcom/taobao/monitor/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->lifeCycle:Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 81
    invoke-interface {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;->begin(Lcom/taobao/monitor/procedure/Value;)V

    :cond_1
    return-object p0
.end method

.method public callback(Lcom/taobao/monitor/procedure/Value;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "subValue"
        }
    .end annotation

    .line 285
    invoke-virtual {p0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 286
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/procedure/Value;->addSubValue(Lcom/taobao/monitor/procedure/Value;)Lcom/taobao/monitor/procedure/Value;

    :cond_0
    return-void
.end method

.method public end()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    const/4 v0, 0x0

    .line 167
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->end(Z)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    return-object v0
.end method

.method public end(Z)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 6
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10
        }
        names = {
            "force"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->status:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    .line 172
    sget-object v1, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->RUNNING:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    if-ne v0, v1, :cond_9

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->subProcedures:Ljava/util/List;

    .line 174
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->subProcedures:Ljava/util/List;

    .line 175
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/taobao/monitor/procedure/IProcedure;

    .line 176
    instance-of v3, v2, Lcom/taobao/monitor/procedure/ProcedureProxy;

    if-eqz v3, :cond_4

    .line 177
    check-cast v2, Lcom/taobao/monitor/procedure/ProcedureProxy;

    invoke-virtual {v2}, Lcom/taobao/monitor/procedure/ProcedureProxy;->base()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v2

    .line 178
    instance-of v3, v2, Lcom/taobao/monitor/procedure/ProcedureImpl;

    if-eqz v3, :cond_3

    .line 179
    move-object v3, v2

    check-cast v3, Lcom/taobao/monitor/procedure/ProcedureImpl;

    .line 181
    invoke-virtual {v3}, Lcom/taobao/monitor/procedure/ProcedureImpl;->isAlive()Z

    move-result v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 182
    invoke-virtual {v3}, Lcom/taobao/monitor/procedure/ProcedureImpl;->value4Parent()Lcom/taobao/monitor/procedure/Value;

    move-result-object v5

    invoke-virtual {v4, v5}, Lcom/taobao/monitor/procedure/Value;->addSubValue(Lcom/taobao/monitor/procedure/Value;)Lcom/taobao/monitor/procedure/Value;

    .line 185
    :cond_1
    iget-boolean v3, v3, Lcom/taobao/monitor/procedure/ProcedureImpl;->independent:Z

    if-eqz v3, :cond_2

    if-eqz p1, :cond_0

    .line 186
    :cond_2
    invoke-interface {v2, p1}, Lcom/taobao/monitor/procedure/IProcedure;->end(Z)Lcom/taobao/monitor/procedure/IProcedure;

    goto :goto_0

    .line 189
    :cond_3
    invoke-interface {v2, p1}, Lcom/taobao/monitor/procedure/IProcedure;->end(Z)Lcom/taobao/monitor/procedure/IProcedure;

    goto :goto_0

    .line 192
    :cond_4
    invoke-interface {v2, p1}, Lcom/taobao/monitor/procedure/IProcedure;->end(Z)Lcom/taobao/monitor/procedure/IProcedure;

    goto :goto_0

    .line 195
    :cond_5
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    .line 197
    instance-of p1, p1, Lcom/taobao/monitor/procedure/IProcedureGroup;

    if-eqz p1, :cond_6

    .line 199
    invoke-static {}, Lcom/taobao/monitor/ProcedureGlobal;->instance()Lcom/taobao/monitor/ProcedureGlobal;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/monitor/ProcedureGlobal;->handler()Landroid/os/Handler;

    move-result-object p1

    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureImpl$1;

    invoke-direct {v0, p0}, Lcom/taobao/monitor/procedure/ProcedureImpl$1;-><init>(Lcom/taobao/monitor/procedure/ProcedureImpl;)V

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :cond_6
    iget-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    .line 208
    instance-of v0, p1, Lcom/taobao/monitor/procedure/IValueCallback;

    if-eqz v0, :cond_7

    .line 209
    check-cast p1, Lcom/taobao/monitor/procedure/IValueCallback;

    invoke-virtual {p0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->value4Parent()Lcom/taobao/monitor/procedure/Value;

    move-result-object v0

    invoke-interface {p1, v0}, Lcom/taobao/monitor/procedure/IValueCallback;->callback(Lcom/taobao/monitor/procedure/Value;)V

    :cond_7
    iget-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->lifeCycle:Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;

    if-eqz p1, :cond_8

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    iget-boolean v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->needUpload:Z

    .line 213
    invoke-interface {p1, v0, v1}, Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;->end(Lcom/taobao/monitor/procedure/Value;Z)V

    .line 216
    :cond_8
    sget-object p1, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->STOPPED:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->status:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    const-string p1, "ProcedureImpl"

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->topic:Ljava/lang/String;

    const-string v2, "end()"

    .line 217
    filled-new-array {v0, v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/taobao/monitor/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    goto :goto_1

    :catchall_0
    move-exception p1

    .line 195
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1

    :cond_9
    :goto_1
    return-object p0
.end method

.method public event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "name",
            "properties"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Lcom/taobao/monitor/procedure/IProcedure;"
        }
    .end annotation

    if-eqz p1, :cond_1

    .line 90
    invoke-virtual {p0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 91
    new-instance v0, Lcom/taobao/monitor/procedure/model/Event;

    invoke-direct {v0, p1, p2}, Lcom/taobao/monitor/procedure/model/Event;-><init>(Ljava/lang/String;Ljava/util/Map;)V

    iget-object p2, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 92
    invoke-virtual {p2, v0}, Lcom/taobao/monitor/procedure/Value;->event(Lcom/taobao/monitor/procedure/model/Event;)Lcom/taobao/monitor/procedure/Value;

    iget-object p2, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->lifeCycle:Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;

    if-eqz p2, :cond_0

    iget-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 94
    invoke-interface {p2, v1, v0}, Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;->event(Lcom/taobao/monitor/procedure/Value;Lcom/taobao/monitor/procedure/model/Event;)V

    :cond_0
    iget-object p2, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->topic:Ljava/lang/String;

    .line 96
    filled-new-array {p2, v0, p1}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "ProcedureImpl"

    invoke-static {p2, p1}, Lcom/taobao/monitor/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    return-object p0
.end method

.method protected finalize()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 262
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->status:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    .line 264
    sget-object v1, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->RUNNING:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    if-ne v0, v1, :cond_0

    .line 265
    new-instance v0, Lcom/taobao/monitor/exception/ProcedureException;

    const-string v1, "Please call end function first!"

    invoke-direct {v0, v1}, Lcom/taobao/monitor/exception/ProcedureException;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lcom/taobao/monitor/logger/Logger;->throwException(Ljava/lang/Throwable;)V

    :cond_0
    return-void
.end method

.method public isAlive()Z
    .locals 2

    .line 162
    sget-object v0, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->STOPPED:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    iget-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->status:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public needUpload()Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->needUpload:Z

    return v0
.end method

.method public parent()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method

.method public removeSubProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "subProcedure"
        }
    .end annotation

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->subProcedures:Ljava/util/List;

    .line 254
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->subProcedures:Ljava/util/List;

    .line 255
    invoke-interface {v1, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 256
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_0
    :goto_0
    return-void
.end method

.method public setLifeCycle(Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;)Lcom/taobao/monitor/procedure/ProcedureImpl;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "lifeCycle"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->lifeCycle:Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;

    return-object p0
.end method

.method public setNeedUpload(Z)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "needUpload"
        }
    .end annotation

    iput-boolean p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->needUpload:Z

    return-object p0
.end method

.method public stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "name",
            "timestamp"
        }
    .end annotation

    if-eqz p1, :cond_1

    .line 104
    invoke-virtual {p0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 105
    new-instance v0, Lcom/taobao/monitor/procedure/model/Stage;

    invoke-direct {v0, p1, p2, p3}, Lcom/taobao/monitor/procedure/model/Stage;-><init>(Ljava/lang/String;J)V

    iget-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 106
    invoke-virtual {p1, v0}, Lcom/taobao/monitor/procedure/Value;->stage(Lcom/taobao/monitor/procedure/model/Stage;)Lcom/taobao/monitor/procedure/Value;

    iget-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->lifeCycle:Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;

    if-eqz p1, :cond_0

    iget-object p2, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 108
    invoke-interface {p1, p2, v0}, Lcom/taobao/monitor/procedure/ProcedureImpl$IProcedureLifeCycle;->stage(Lcom/taobao/monitor/procedure/Value;Lcom/taobao/monitor/procedure/model/Stage;)V

    :cond_0
    iget-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->topic:Ljava/lang/String;

    .line 110
    filled-new-array {p1, p2, v0}, [Ljava/lang/Object;

    move-result-object p1

    const-string p2, "ProcedureImpl"

    invoke-static {p2, p1}, Lcom/taobao/monitor/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_1
    return-object p0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->topic:Ljava/lang/String;

    return-object v0
.end method

.method public topic()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->topic:Ljava/lang/String;

    return-object v0
.end method

.method public topicSession()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->session:Ljava/lang/String;

    return-object v0
.end method

.method public value()Lcom/taobao/monitor/procedure/Value;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    return-object v0
.end method

.method protected value4Parent()Lcom/taobao/monitor/procedure/Value;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl;->value:Lcom/taobao/monitor/procedure/Value;

    .line 223
    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/Value;->summary()Lcom/taobao/monitor/procedure/Value;

    move-result-object v0

    return-object v0
.end method
