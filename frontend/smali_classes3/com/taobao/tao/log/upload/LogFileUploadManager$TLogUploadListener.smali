.class public Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;
.super Ljava/lang/Object;
.source "LogFileUploadManager.java"

# interfaces
.implements Lcom/taobao/tao/log/upload/FileUploadListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/upload/LogFileUploadManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "TLogUploadListener"
.end annotation


# instance fields
.field private contentType:Ljava/lang/String;

.field private fileName:Ljava/lang/String;

.field private ossEndpoint:Ljava/lang/String;

.field private ossObjectKey:Ljava/lang/String;

.field final synthetic this$0:Lcom/taobao/tao/log/upload/LogFileUploadManager;


# direct methods
.method public constructor <init>(Lcom/taobao/tao/log/upload/LogFileUploadManager;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->this$0:Lcom/taobao/tao/log/upload/LogFileUploadManager;

    .line 443
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->fileName:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->contentType:Ljava/lang/String;

    iput-object p4, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->ossObjectKey:Ljava/lang/String;

    iput-object p5, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->ossEndpoint:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public onError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    iget-object v0, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->this$0:Lcom/taobao/tao/log/upload/LogFileUploadManager;

    iget-object v1, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->fileName:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->contentType:Ljava/lang/String;

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    .line 452
    invoke-virtual/range {v0 .. v5}, Lcom/taobao/tao/log/upload/LogFileUploadManager;->uploadFailed(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 453
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p1

    sget-object p2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_LOG_UPLOAD_COUNT:Ljava/lang/String;

    new-instance p3, Ljava/lang/StringBuilder;

    const-string v0, "\u6587\u4ef6\u4e0a\u4f20\u5931\u8d25\u4e86\uff1a\u68c0\u6d4b\u662f\u5426\u8fd8\u6709\u6587\u4ef6\u53ef\u4e0a\u4f20  \u662f\u5426\u5f00\u542f\u5f3a\u5236\u4e0a\u4f20\uff1a"

    invoke-direct {p3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->this$0:Lcom/taobao/tao/log/upload/LogFileUploadManager;

    iget-boolean v0, v0, Lcom/taobao/tao/log/upload/LogFileUploadManager;->isForceUpload:Z

    invoke-virtual {p3, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p3

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    const-string v0, "MSG LOG UPLOAD"

    invoke-interface {p1, p2, v0, p3}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onSucessed(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6

    iget-object v0, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->this$0:Lcom/taobao/tao/log/upload/LogFileUploadManager;

    iget-object v2, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->contentType:Ljava/lang/String;

    iget-object v4, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->ossObjectKey:Ljava/lang/String;

    iget-object v5, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->ossEndpoint:Ljava/lang/String;

    move-object v1, p1

    move-object v3, p2

    .line 459
    invoke-virtual/range {v0 .. v5}, Lcom/taobao/tao/log/upload/LogFileUploadManager;->uploadSuccessed(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->this$0:Lcom/taobao/tao/log/upload/LogFileUploadManager;

    const/4 p2, 0x1

    .line 460
    iput-boolean p2, p1, Lcom/taobao/tao/log/upload/LogFileUploadManager;->isForceUpload:Z

    .line 461
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p1

    sget-object p2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_LOG_UPLOAD_COUNT:Ljava/lang/String;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "\u6587\u4ef6\u4e0a\u4f20\u6210\u529f\u4e86\uff1a\u68c0\u6d4b\u662f\u5426\u8fd8\u6709\u6587\u4ef6\u53ef\u4e0a\u4f20  \u662f\u5426\u5f00\u542f\u5f3a\u5236\u4e0a\u4f20\uff1a"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/taobao/tao/log/upload/LogFileUploadManager$TLogUploadListener;->this$0:Lcom/taobao/tao/log/upload/LogFileUploadManager;

    iget-boolean v1, v1, Lcom/taobao/tao/log/upload/LogFileUploadManager;->isForceUpload:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "MSG LOG UPLOAD"

    invoke-interface {p1, p2, v1, v0}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
