.class public Lcom/taobao/tao/log/task/UploadFileTask;
.super Ljava/lang/Object;
.source "UploadFileTask.java"


# static fields
.field private static TAG:Ljava/lang/String; = "TLOG.UploadFileTask"


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static filePathUpload(Ljava/util/List;Ljava/lang/String;Ljava/util/Map;Lcom/taobao/tao/log/upload/FileUploadListener;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/taobao/tao/log/upload/FileUploadListener;",
            ")V"
        }
    .end annotation

    .line 152
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v0

    sget-object v1, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_LOG_UPLOAD:Ljava/lang/String;

    sget-object v2, Lcom/taobao/tao/log/task/UploadFileTask;->TAG:Ljava/lang/String;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "\u6587\u4ef6\u4e0a\u4f20\uff1a\u89e6\u53d1\u4e3b\u52a8\u4e0a\u4f20\u6587\u4ef6\uff0c"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 155
    invoke-static {p0, p1, p2, p3}, Lcom/taobao/tao/log/task/e;->a(Ljava/util/List;Ljava/lang/String;Ljava/util/Map;Lcom/taobao/tao/log/upload/FileUploadListener;)V

    return-void
.end method

.method private static preFixUpload(Ljava/lang/String;Ljava/util/Map;Lcom/taobao/tao/log/upload/FileUploadListener;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/taobao/tao/log/upload/FileUploadListener;",
            ")V"
        }
    .end annotation

    const/4 v0, 0x1

    .line 124
    invoke-static {v0}, Lcom/taobao/tao/log/TLogNative;->appenderFlushData(Z)V

    .line 126
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->getNameprefix()Ljava/lang/String;

    move-result-object v1

    .line 128
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    const/16 v2, 0x3a

    .line 129
    invoke-virtual {v1, v2}, Ljava/lang/String;->indexOf(I)I

    move-result v2

    if-lez v2, :cond_0

    const/4 v3, 0x0

    .line 131
    invoke-virtual {v1, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    :cond_0
    const/4 v2, 0x0

    .line 135
    invoke-static {v2}, Lcom/taobao/tao/log/TLogUtils;->transferTodayFileIfNeeded([Ljava/lang/String;)V

    .line 136
    invoke-static {v1, v0, v2}, Lcom/taobao/tao/log/TLogUtils;->getFilePath(Ljava/lang/String;I[Ljava/lang/String;)Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 137
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    goto :goto_0

    .line 143
    :cond_1
    invoke-static {v0, p0, p1, p2}, Lcom/taobao/tao/log/task/UploadFileTask;->filePathUpload(Ljava/util/List;Ljava/lang/String;Ljava/util/Map;Lcom/taobao/tao/log/upload/FileUploadListener;)V

    return-void

    :cond_2
    :goto_0
    sget-object p0, Lcom/taobao/tao/log/task/UploadFileTask;->TAG:Ljava/lang/String;

    const-string p1, "uploadFile failure, file path is empty"

    .line 138
    invoke-static {p0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public static declared-synchronized taskExecute(Lcom/taobao/android/tlog/protocol/model/CommandInfo;Ljava/lang/String;Ljava/lang/String;[Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;)V
    .locals 6

    const-class v0, Lcom/taobao/tao/log/task/UploadFileTask;

    monitor-enter v0

    .line 43
    :try_start_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v1

    sget-object v2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    sget-object v3, Lcom/taobao/tao/log/task/UploadFileTask;->TAG:Ljava/lang/String;

    const-string v4, "\u6d88\u606f\u5904\u7406\uff1a\u5f00\u59cb\u5904\u7406\u6587\u4ef6\u4e0a\u4f20\u6d88\u606f"

    invoke-interface {v1, v2, v3, v4}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 46
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->getContext()Landroid/content/Context;

    move-result-object v1

    .line 47
    new-instance v2, Lcom/taobao/tao/log/upload/LogFileUploadManager;

    invoke-direct {v2, v1}, Lcom/taobao/tao/log/upload/LogFileUploadManager;-><init>(Landroid/content/Context;)V

    .line 49
    iput-object p1, v2, Lcom/taobao/tao/log/upload/LogFileUploadManager;->uploadId:Ljava/lang/String;

    .line 50
    iput-object p2, v2, Lcom/taobao/tao/log/upload/LogFileUploadManager;->tokenType:Ljava/lang/String;

    .line 51
    iput-object p3, v2, Lcom/taobao/tao/log/upload/LogFileUploadManager;->tokenInfos:[Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    .line 52
    iput-object p0, v2, Lcom/taobao/tao/log/upload/LogFileUploadManager;->mParmas:Lcom/taobao/android/tlog/protocol/model/CommandInfo;

    .line 54
    array-length p0, p3

    const/4 p2, 0x0

    :goto_0
    if-ge p2, p0, :cond_4

    aget-object v1, p3, p2

    .line 55
    iget-object v1, v1, Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;->fileInfo:Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;

    .line 56
    iget-object v3, v1, Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;->fileName:Ljava/lang/String;

    .line 57
    iget-object v1, v1, Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;->absolutePath:Ljava/lang/String;

    .line 59
    invoke-virtual {v2}, Lcom/taobao/tao/log/upload/LogFileUploadManager;->isUploading()Z

    move-result v4

    if-eqz v4, :cond_0

    const-string v1, "TLOG"

    sget-object v3, Lcom/taobao/tao/log/task/UploadFileTask;->TAG:Ljava/lang/String;

    const-string v4, "[persistTask] there is task!"

    .line 60
    invoke-static {v1, v3, v4}, Lcom/taobao/tao/log/TLog;->loge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 63
    :cond_0
    invoke-static {v3}, Lcom/taobao/tao/log/TLogUtils;->getFilePath(Ljava/lang/String;)Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 64
    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_1

    .line 65
    invoke-virtual {v2, v3}, Lcom/taobao/tao/log/upload/LogFileUploadManager;->addFiles(Ljava/util/List;)V

    .line 68
    :cond_1
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v3

    if-nez v3, :cond_2

    .line 69
    invoke-virtual {v2, v1}, Lcom/taobao/tao/log/upload/LogFileUploadManager;->addFile(Ljava/lang/String;)V

    :cond_2
    const/4 v1, 0x1

    .line 72
    iput-boolean v1, v2, Lcom/taobao/tao/log/upload/LogFileUploadManager;->isForceUpload:Z

    .line 73
    invoke-virtual {v2}, Lcom/taobao/tao/log/upload/LogFileUploadManager;->getUploadTaskCount()I

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "TLOG"

    sget-object v3, Lcom/taobao/tao/log/task/UploadFileTask;->TAG:Ljava/lang/String;

    const-string v4, "There are not files matching the condition"

    .line 74
    invoke-static {v1, v3, v4}, Lcom/taobao/tao/log/TLog;->loge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    :cond_3
    const-string v1, "TLOG"

    sget-object v3, Lcom/taobao/tao/log/task/UploadFileTask;->TAG:Ljava/lang/String;

    .line 76
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "There are "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v2}, Lcom/taobao/tao/log/upload/LogFileUploadManager;->getUploadTaskCount()I

    move-result v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " files to upload!"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v1, v3, v4}, Lcom/taobao/tao/log/TLog;->loge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :goto_1
    add-int/lit8 p2, p2, 0x1

    goto :goto_0

    .line 80
    :cond_4
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p0

    sget-object p2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_LOG_UPLOAD:Ljava/lang/String;

    sget-object p3, Lcom/taobao/tao/log/task/UploadFileTask;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u6587\u4ef6\u4e0a\u4f20\uff1a\u5f00\u59cb\u89e6\u53d1\u4e0a\u4f20\u6587\u4ef6,uploadId="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p0, p2, p3, p1}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 83
    invoke-virtual {v2}, Lcom/taobao/tao/log/upload/LogFileUploadManager;->startUpload()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception p0

    goto :goto_3

    :catch_0
    move-exception p0

    :try_start_1
    sget-object p1, Lcom/taobao/tao/log/task/UploadFileTask;->TAG:Ljava/lang/String;

    const-string p2, "task execute failure "

    .line 85
    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 86
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p1

    sget-object p2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_HANDLE:Ljava/lang/String;

    sget-object p3, Lcom/taobao/tao/log/task/UploadFileTask;->TAG:Ljava/lang/String;

    invoke-interface {p1, p2, p3, p0}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 89
    :goto_2
    monitor-exit v0

    return-void

    :goto_3
    monitor-exit v0

    throw p0
.end method

.method public static uploadWithFilePrefix(Ljava/lang/String;Ljava/util/Map;Lcom/taobao/tao/log/upload/FileUploadListener;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;",
            "Lcom/taobao/tao/log/upload/FileUploadListener;",
            ")V"
        }
    .end annotation

    .line 96
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->getInitState()I

    move-result v0

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    .line 97
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p0

    sget-object p1, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_LOG_UPLOAD:Ljava/lang/String;

    sget-object p2, Lcom/taobao/tao/log/task/UploadFileTask;->TAG:Ljava/lang/String;

    const-string v0, "\u6587\u4ef6\u4e0a\u4f20\uff1a\u4e0a\u4f20\u5931\u8d25\uff0c\u672a\u5b8c\u6210\u521d\u59cb\u5316"

    invoke-interface {p0, p1, p2, v0}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    .line 102
    :cond_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->getAppkey()Ljava/lang/String;

    move-result-object v0

    const-string v1, "tlog"

    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;->getInstance(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/EmasSettingService;

    move-result-object v0

    const-class v1, Lcom/taobao/tao/log/utils/SamplingRate;

    const/4 v2, 0x0

    const/4 v3, 0x0

    const-string v4, "positive_sampling_rate"

    .line 103
    invoke-virtual {v0, v4, v1, v2, v3}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;->getObject(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;Z)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/tao/log/utils/SamplingRate;

    if-eqz v0, :cond_2

    .line 107
    invoke-static {v0}, Lcom/taobao/tao/log/utils/a;->a(Lcom/taobao/tao/log/utils/SamplingRate;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 108
    invoke-static {p0, p1, p2}, Lcom/taobao/tao/log/task/UploadFileTask;->preFixUpload(Ljava/lang/String;Ljava/util/Map;Lcom/taobao/tao/log/upload/FileUploadListener;)V

    goto :goto_0

    .line 110
    :cond_1
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p0

    sget-object p1, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_LOG_UPLOAD:Ljava/lang/String;

    sget-object p2, Lcom/taobao/tao/log/task/UploadFileTask;->TAG:Ljava/lang/String;

    const-string v0, "\u6587\u4ef6\u4e0a\u4f20\uff1a\u4e0a\u4f20\u5931\u8d25\uff0c\u672a\u547d\u4e2d\u5230\u4e3b\u52a8\u4e0a\u62a5\u62bd\u6837"

    invoke-interface {p0, p1, p2, v0}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 114
    :cond_2
    invoke-static {p0, p1, p2}, Lcom/taobao/tao/log/task/UploadFileTask;->preFixUpload(Ljava/lang/String;Ljava/util/Map;Lcom/taobao/tao/log/upload/FileUploadListener;)V

    :goto_0
    return-void
.end method
