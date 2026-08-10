.class public Lcom/taobao/tao/log/task/n$a;
.super Ljava/lang/Thread;
.source "MethodTraceReplyTask.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/task/n;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation


# instance fields
.field private a:Lcom/taobao/tao/log/godeye/api/file/FileUploadListener;

.field final synthetic a:Lcom/taobao/tao/log/task/n;

.field private filePath:Ljava/lang/String;

.field private uploadId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/taobao/tao/log/task/n;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/file/FileUploadListener;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/task/n$a;->a:Lcom/taobao/tao/log/task/n;

    .line 166
    invoke-direct {p0, p2}, Ljava/lang/Thread;-><init>(Ljava/lang/String;)V

    iput-object p3, p0, Lcom/taobao/tao/log/task/n$a;->uploadId:Ljava/lang/String;

    iput-object p4, p0, Lcom/taobao/tao/log/task/n$a;->filePath:Ljava/lang/String;

    iput-object p5, p0, Lcom/taobao/tao/log/task/n$a;->a:Lcom/taobao/tao/log/godeye/api/file/FileUploadListener;

    return-void
.end method

.method static synthetic a(Lcom/taobao/tao/log/task/n$a;)Lcom/taobao/tao/log/godeye/api/file/FileUploadListener;
    .locals 0

    .line 160
    iget-object p0, p0, Lcom/taobao/tao/log/task/n$a;->a:Lcom/taobao/tao/log/godeye/api/file/FileUploadListener;

    return-object p0
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 176
    :try_start_0
    new-instance v0, Lcom/taobao/tao/log/task/n$a$1;

    invoke-direct {v0, p0}, Lcom/taobao/tao/log/task/n$a$1;-><init>(Lcom/taobao/tao/log/task/n$a;)V

    .line 188
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, p0, Lcom/taobao/tao/log/task/n$a;->filePath:Ljava/lang/String;

    .line 189
    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v2, p0, Lcom/taobao/tao/log/task/n$a;->uploadId:Ljava/lang/String;

    if-eqz v2, :cond_0

    .line 192
    invoke-static {}, Lcom/taobao/tao/log/upload/UploadQueue;->getInstance()Lcom/taobao/tao/log/upload/UploadQueue;

    move-result-object v2

    iget-object v3, p0, Lcom/taobao/tao/log/task/n$a;->uploadId:Ljava/lang/String;

    invoke-virtual {v2, v3, v0}, Lcom/taobao/tao/log/upload/UploadQueue;->pushListener(Ljava/lang/String;Lcom/taobao/tao/log/upload/FileUploadListener;)V

    iget-object v0, p0, Lcom/taobao/tao/log/task/n$a;->uploadId:Ljava/lang/String;

    const-string v2, "application/x-perf-methodtrace"

    .line 193
    invoke-static {v0, v1, v2}, Lcom/taobao/tao/log/task/b;->a(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/taobao/tao/log/task/n$a;->a:Lcom/taobao/tao/log/task/n;

    .line 195
    invoke-static {v0}, Lcom/taobao/tao/log/task/n;->a(Lcom/taobao/tao/log/task/n;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "upload id is null "

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "TLOG"

    iget-object v1, p0, Lcom/taobao/tao/log/task/n$a;->a:Lcom/taobao/tao/log/task/n;

    .line 196
    invoke-static {v1}, Lcom/taobao/tao/log/task/n;->a(Lcom/taobao/tao/log/task/n;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "method trace upload id is null"

    invoke-static {v0, v1, v2}, Lcom/taobao/tao/log/TLog;->loge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 199
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 200
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v1

    sget-object v2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    iget-object v3, p0, Lcom/taobao/tao/log/task/n$a;->a:Lcom/taobao/tao/log/task/n;

    .line 201
    invoke-static {v3}, Lcom/taobao/tao/log/task/n;->a(Lcom/taobao/tao/log/task/n;)Ljava/lang/String;

    move-result-object v3

    .line 200
    invoke-interface {v1, v2, v3, v0}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_0
    return-void
.end method
