.class public Lcom/taobao/tao/log/task/a;
.super Ljava/lang/Object;
.source "ApplyTokenReplyTask.java"

# interfaces
.implements Lcom/taobao/tao/log/task/i;


# instance fields
.field private TAG:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.ApplyTokenReplyTask"

    iput-object v0, p0, Lcom/taobao/tao/log/task/a;->TAG:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/android/tlog/protocol/model/CommandInfo;)Lcom/taobao/tao/log/task/i;
    .locals 4

    .line 26
    :try_start_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v0

    sget-object v1, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/tao/log/task/a;->TAG:Ljava/lang/String;

    const-string v3, "\u6d88\u606f\u5904\u7406\uff1a\u7533\u8bf7token\u56de\u590d\u6d88\u606f"

    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 29
    new-instance v0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;

    invoke-direct {v0}, Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;-><init>()V

    .line 30
    iget-object v1, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->data:Lcom/alibaba/fastjson/JSON;

    invoke-virtual {v0, v1, p1}, Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;->parse(Lcom/alibaba/fastjson/JSON;Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V

    .line 32
    iget-object v1, v0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;->uploadId:Ljava/lang/String;

    .line 33
    iget-object v2, v0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;->tokenInfos:[Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    if-eqz v2, :cond_0

    .line 35
    array-length v2, v2

    if-lez v2, :cond_0

    .line 37
    iget-object v2, v0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;->tokenType:Ljava/lang/String;

    iget-object v0, v0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyTokenReply;->tokenInfos:[Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    invoke-static {p1, v1, v2, v0}, Lcom/taobao/tao/log/task/UploadFileTask;->taskExecute(Lcom/taobao/android/tlog/protocol/model/CommandInfo;Ljava/lang/String;Ljava/lang/String;[Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/tao/log/task/a;->TAG:Ljava/lang/String;

    const-string v1, "execute error"

    .line 40
    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 41
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v0

    sget-object v1, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/tao/log/task/a;->TAG:Ljava/lang/String;

    invoke-interface {v0, v1, v2, p1}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_0
    :goto_0
    return-object p0
.end method
