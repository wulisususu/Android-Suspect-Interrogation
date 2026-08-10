.class public Lcom/taobao/tao/log/task/o;
.super Ljava/lang/Object;
.source "MethodTraceRequestTask.java"

# interfaces
.implements Lcom/taobao/tao/log/task/i;


# instance fields
.field private TAG:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.MethodTraceRequestTask"

    iput-object v0, p0, Lcom/taobao/tao/log/task/o;->TAG:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/android/tlog/protocol/model/CommandInfo;)Lcom/taobao/tao/log/task/i;
    .locals 4

    .line 27
    :try_start_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v0

    sget-object v1, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/tao/log/task/o;->TAG:Ljava/lang/String;

    const-string v3, "\u6d88\u606f\u5904\u7406\uff1amethod trace \u8bf7\u6c42\u6d88\u606f"

    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 30
    new-instance v0, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;

    invoke-direct {v0}, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;-><init>()V

    .line 31
    iget-object v1, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->data:Lcom/alibaba/fastjson/JSON;

    invoke-virtual {v0, v1, p1}, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;->parse(Lcom/alibaba/fastjson/JSON;Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V

    .line 34
    new-instance v1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;

    invoke-direct {v1}, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;-><init>()V

    .line 35
    iput-object p1, v1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->commandInfo:Lcom/taobao/android/tlog/protocol/model/CommandInfo;

    .line 36
    iget-object p1, v0, Lcom/taobao/android/tlog/protocol/model/request/MethodTraceRequest;->uploadId:Ljava/lang/String;

    iput-object p1, v1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->uploadId:Ljava/lang/String;

    .line 38
    invoke-static {}, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->getInstance()Lcom/taobao/tao/log/godeye/GodeyeInitializer;

    move-result-object p1

    invoke-virtual {p1, v1}, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->handleRemoteCommand(Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/tao/log/task/o;->TAG:Ljava/lang/String;

    const-string v1, "execute error"

    .line 40
    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 41
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v0

    sget-object v1, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/tao/log/task/o;->TAG:Ljava/lang/String;

    invoke-interface {v0, v1, v2, p1}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_0
    return-object p0
.end method
