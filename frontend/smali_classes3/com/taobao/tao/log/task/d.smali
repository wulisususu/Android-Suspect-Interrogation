.class public Lcom/taobao/tao/log/task/d;
.super Ljava/lang/Object;
.source "ApplyUploadFileReplyTask.java"

# interfaces
.implements Lcom/taobao/tao/log/task/i;


# instance fields
.field private TAG:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.ApplyUploadFileReplyTask"

    iput-object v0, p0, Lcom/taobao/tao/log/task/d;->TAG:Ljava/lang/String;

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

    iget-object v2, p0, Lcom/taobao/tao/log/task/d;->TAG:Ljava/lang/String;

    const-string v3, "\u6d88\u606f\u5904\u7406\uff1a\u8bf7\u6c42\u6587\u4ef6\u4e0a\u4f20\u670d\u52a1\u7aef\u56de\u590d\u6d88\u606f"

    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 30
    new-instance v0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyUploadReply;

    invoke-direct {v0}, Lcom/taobao/android/tlog/protocol/model/reply/ApplyUploadReply;-><init>()V

    .line 31
    iget-object v1, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->data:Lcom/alibaba/fastjson/JSON;

    invoke-virtual {v0, v1, p1}, Lcom/taobao/android/tlog/protocol/model/reply/ApplyUploadReply;->parse(Lcom/alibaba/fastjson/JSON;Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V

    .line 33
    iget-object v1, v0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyUploadReply;->uploadId:Ljava/lang/String;

    .line 34
    iget-object v2, v0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyUploadReply;->tokenInfos:[Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    if-eqz v2, :cond_0

    .line 36
    array-length v3, v2

    if-lez v3, :cond_0

    .line 38
    iget-object v0, v0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyUploadReply;->tokenType:Ljava/lang/String;

    invoke-static {p1, v1, v0, v2}, Lcom/taobao/tao/log/task/UploadFileTask;->taskExecute(Lcom/taobao/android/tlog/protocol/model/CommandInfo;Ljava/lang/String;Ljava/lang/String;[Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/tao/log/task/d;->TAG:Ljava/lang/String;

    const-string v1, "execute error"

    .line 41
    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 42
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v0

    sget-object v1, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/tao/log/task/d;->TAG:Ljava/lang/String;

    invoke-interface {v0, v1, v2, p1}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_0
    :goto_0
    return-object p0
.end method
