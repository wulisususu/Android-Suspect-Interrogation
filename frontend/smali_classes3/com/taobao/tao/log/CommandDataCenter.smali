.class public Lcom/taobao/tao/log/CommandDataCenter;
.super Ljava/lang/Object;
.source "CommandDataCenter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/tao/log/CommandDataCenter$a;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "TLOG.CommandDataCenter"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/tao/log/CommandDataCenter$1;)V
    .locals 0

    .line 14
    invoke-direct {p0}, Lcom/taobao/tao/log/CommandDataCenter;-><init>()V

    return-void
.end method

.method public static declared-synchronized getInstance()Lcom/taobao/tao/log/CommandDataCenter;
    .locals 2

    const-class v0, Lcom/taobao/tao/log/CommandDataCenter;

    monitor-enter v0

    .line 25
    :try_start_0
    invoke-static {}, Lcom/taobao/tao/log/CommandDataCenter$a;->a()Lcom/taobao/tao/log/CommandDataCenter;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public onData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 5

    .line 36
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v0

    sget-object v1, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_REVEIVE_COUNT:Ljava/lang/String;

    const-string v2, "RECEIVE MESSAGE COUNT"

    const-string v3, "\u6210\u529f\u63a5\u6536\u5230\u6d88\u606f\uff0c\u8fd8\u672a\u5f00\u59cb\u5904\u7406"

    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "TLOG.CommandDataCenter"

    if-nez p4, :cond_0

    const-string p1, "msg is null"

    .line 39
    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 41
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p1

    sget-object p2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_REVEIVE:Ljava/lang/String;

    const-string p3, "NULL MESSAGE"

    const-string p4, "\u63a5\u6536\u5230\u7684\u670d\u52a1\u7aef\u6d88\u606f\u4e3a\u7a7a"

    invoke-interface {p1, p2, p3, p4}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    .line 47
    :cond_0
    :try_start_0
    invoke-static {}, Lcom/taobao/android/tlog/protocol/TLogReply;->getInstance()Lcom/taobao/android/tlog/protocol/TLogReply;

    move-result-object v1

    invoke-virtual {v1, p1, p2, p3, p4}, Lcom/taobao/android/tlog/protocol/TLogReply;->parseContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)Ljava/lang/String;

    move-result-object p3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p3

    .line 51
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v1

    sget-object v2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_REVEIVE:Ljava/lang/String;

    const-string v3, "PARSE MESSAGE ERROR"

    invoke-interface {v1, v2, v3, p3}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    const/4 p3, 0x0

    .line 54
    :goto_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v1

    sget-object v2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_REVEIVE:Ljava/lang/String;

    const-string v3, "RECEIVE MESSAGE"

    const-string v4, "\u6210\u529f\u63a5\u6536\u5230\u6d88\u606f"

    invoke-interface {v1, v2, v3, v4}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 57
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "CommandDataCenter.onData : "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 58
    invoke-static {}, Lcom/taobao/tao/log/task/f;->a()Lcom/taobao/tao/log/task/f;

    move-result-object v0

    invoke-virtual {v0, p4, p3, p2, p1}, Lcom/taobao/tao/log/task/f;->a([BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
