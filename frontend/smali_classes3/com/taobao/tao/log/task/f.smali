.class public Lcom/taobao/tao/log/task/f;
.super Ljava/lang/Object;
.source "CommandManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/tao/log/task/f$a;
    }
.end annotation


# instance fields
.field private TAG:Ljava/lang/String;

.field private c:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Lcom/taobao/tao/log/task/i;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.CommandManager"

    iput-object v0, p0, Lcom/taobao/tao/log/task/f;->TAG:Ljava/lang/String;

    .line 26
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/task/f;->c:Ljava/util/concurrent/ConcurrentHashMap;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/tao/log/task/f$1;)V
    .locals 0

    .line 22
    invoke-direct {p0}, Lcom/taobao/tao/log/task/f;-><init>()V

    return-void
.end method

.method public static final a()Lcom/taobao/tao/log/task/f;
    .locals 1

    .line 35
    invoke-static {}, Lcom/taobao/tao/log/task/f$a;->b()Lcom/taobao/tao/log/task/f;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public a(Ljava/lang/String;Lcom/taobao/tao/log/task/i;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/task/f;->c:Ljava/util/concurrent/ConcurrentHashMap;

    .line 98
    invoke-virtual {v0, p1, p2}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public a([BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    const-string v0, "RECEIVE MESSAGE"

    const-string v1, "\u5f00\u59cb\u5904\u7406\u4efb\u52a1\uff0copcode="

    const-string v2, "\u6ca1\u6709\u5bf9\u5e94\u7684\u4efb\u52a1\u5b58\u5728\uff0copcode="

    .line 61
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 63
    :try_start_0
    invoke-static {}, Lcom/taobao/android/tlog/protocol/TLogReply;->getInstance()Lcom/taobao/android/tlog/protocol/TLogReply;

    move-result-object v3

    invoke-virtual {v3, p1, p2, p3, p4}, Lcom/taobao/android/tlog/protocol/TLogReply;->parseCommandInfo([BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/android/tlog/protocol/model/CommandInfo;

    move-result-object p1

    if-eqz p1, :cond_2

    .line 65
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p2

    invoke-virtual {p2}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p2

    sget-object p3, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_REVEIVE:Ljava/lang/String;

    const-string p4, "\u63a5\u6536\u6d88\u606f\u540e\uff0c\u57fa\u7840\u4fe1\u606f\u89e3\u6790\u5b8c\u6210"

    invoke-interface {p2, p3, v0, p4}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 67
    iget-object p2, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->msgType:Ljava/lang/String;

    const-string p3, "NOTIFY"

    invoke-virtual {p2, p3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_0

    .line 68
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p2

    invoke-virtual {p2}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p2

    sget-object p3, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_REVEIVE:Ljava/lang/String;

    const-string p4, "\u63a5\u6536\u5230notify\u6d88\u606f\uff0c\u5f00\u59cb\u62c9\u4efb\u52a1"

    invoke-interface {p2, p3, v0, p4}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 70
    invoke-static {}, Lcom/taobao/tao/log/task/PullTask;->getInstance()Lcom/taobao/tao/log/task/PullTask;

    move-result-object p2

    invoke-virtual {p2}, Lcom/taobao/tao/log/task/PullTask;->pull()V

    :cond_0
    iget-object p2, p0, Lcom/taobao/tao/log/task/f;->c:Ljava/util/concurrent/ConcurrentHashMap;

    .line 73
    iget-object p3, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->opCode:Ljava/lang/String;

    invoke-virtual {p2, p3}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/taobao/tao/log/task/i;

    if-eqz p2, :cond_1

    .line 75
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p3

    invoke-virtual {p3}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p3

    sget-object p4, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_REVEIVE:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->opCode:Ljava/lang/String;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p3, p4, v0, v1}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 77
    invoke-interface {p2, p1}, Lcom/taobao/tao/log/task/i;->a(Lcom/taobao/android/tlog/protocol/model/CommandInfo;)Lcom/taobao/tao/log/task/i;

    goto :goto_0

    .line 79
    :cond_1
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p2

    invoke-virtual {p2}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p2

    sget-object p3, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_REVEIVE:Ljava/lang/String;

    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object p1, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->opCode:Ljava/lang/String;

    invoke-virtual {p4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, p3, v0, p1}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/tao/log/task/f;->TAG:Ljava/lang/String;

    const-string p3, "parse command info error"

    .line 84
    invoke-static {p2, p3, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 85
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p2

    invoke-virtual {p2}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p2

    sget-object p3, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    iget-object p4, p0, Lcom/taobao/tao/log/task/f;->TAG:Ljava/lang/String;

    invoke-interface {p2, p3, p4, p1}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_2
    :goto_0
    return-void
.end method

.method public d()V
    .locals 2

    .line 40
    new-instance v0, Lcom/taobao/tao/log/task/a;

    invoke-direct {v0}, Lcom/taobao/tao/log/task/a;-><init>()V

    const-string v1, "RDWP_APPLY_UPLOAD_TOKEN_REPLY"

    invoke-virtual {p0, v1, v0}, Lcom/taobao/tao/log/task/f;->a(Ljava/lang/String;Lcom/taobao/tao/log/task/i;)V

    .line 42
    new-instance v0, Lcom/taobao/tao/log/task/d;

    invoke-direct {v0}, Lcom/taobao/tao/log/task/d;-><init>()V

    const-string v1, "RDWP_APPLY_UPLOAD_REPLY"

    invoke-virtual {p0, v1, v0}, Lcom/taobao/tao/log/task/f;->a(Ljava/lang/String;Lcom/taobao/tao/log/task/i;)V

    .line 44
    new-instance v0, Lcom/taobao/tao/log/task/m;

    invoke-direct {v0}, Lcom/taobao/tao/log/task/m;-><init>()V

    const-string v1, "RDWP_LOG_UPLOAD"

    invoke-virtual {p0, v1, v0}, Lcom/taobao/tao/log/task/f;->a(Ljava/lang/String;Lcom/taobao/tao/log/task/i;)V

    .line 46
    new-instance v0, Lcom/taobao/tao/log/task/j;

    invoke-direct {v0}, Lcom/taobao/tao/log/task/j;-><init>()V

    const-string v1, "RDWP_LOG_CONFIGURE"

    invoke-virtual {p0, v1, v0}, Lcom/taobao/tao/log/task/f;->a(Ljava/lang/String;Lcom/taobao/tao/log/task/i;)V

    .line 48
    new-instance v0, Lcom/taobao/tao/log/task/o;

    invoke-direct {v0}, Lcom/taobao/tao/log/task/o;-><init>()V

    const-string v1, "RDWP_METHOD_TRACE_DUMP"

    invoke-virtual {p0, v1, v0}, Lcom/taobao/tao/log/task/f;->a(Ljava/lang/String;Lcom/taobao/tao/log/task/i;)V

    .line 50
    new-instance v0, Lcom/taobao/tao/log/task/h;

    invoke-direct {v0}, Lcom/taobao/tao/log/task/h;-><init>()V

    const-string v1, "RDWP_HEAP_DUMP"

    invoke-virtual {p0, v1, v0}, Lcom/taobao/tao/log/task/f;->a(Ljava/lang/String;Lcom/taobao/tao/log/task/i;)V

    return-void
.end method
