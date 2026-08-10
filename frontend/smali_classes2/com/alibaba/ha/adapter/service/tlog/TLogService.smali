.class public Lcom/alibaba/ha/adapter/service/tlog/TLogService;
.super Ljava/lang/Object;
.source "TLogService.java"


# static fields
.field public static isValid:Z = false


# direct methods
.method public static constructor <clinit>()V
    .locals 1

    :try_start_0
    const-string v0, "com.taobao.tao.log.TLog"

    .line 23
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    sput-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    :goto_0
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static OpenDebug(Ljava/lang/Boolean;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 37
    :cond_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    invoke-virtual {v0, p0}, Lcom/taobao/tao/log/TLogInitializer;->setDebugMode(Z)Lcom/taobao/tao/log/TLogInitializer;

    return-void
.end method

.method public static changeAccsServiceId(Ljava/lang/String;)V
    .locals 1

    if-eqz p0, :cond_0

    .line 252
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    iput-object p0, v0, Lcom/taobao/tao/log/TLogInitializer;->accsServiceId:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public static changeAccsTag(Ljava/lang/String;)V
    .locals 1

    if-eqz p0, :cond_0

    .line 262
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    iput-object p0, v0, Lcom/taobao/tao/log/TLogInitializer;->accsTag:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public static changeBucketName(Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p0, :cond_1

    .line 50
    invoke-static {p0}, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->changeRemoteDebugOssBucket(Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public static changeConfigHost(Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 73
    :cond_0
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 74
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/taobao/tao/log/TLogInitializer;->changeConfigHost(Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public static changeHost(Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    if-eqz p0, :cond_1

    .line 64
    invoke-static {p0}, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->changeRemoteDebugHost(Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method public static changeRasPublishKey(Ljava/lang/String;)V
    .locals 1

    if-eqz p0, :cond_0

    .line 272
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/taobao/tao/log/TLogInitializer;->changeRsaPublishKey(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;

    :cond_0
    return-void
.end method

.method public static changeRemoteDebugHost(Ljava/lang/String;)V
    .locals 1

    if-eqz p0, :cond_0

    .line 232
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    iput-object p0, v0, Lcom/taobao/tao/log/TLogInitializer;->messageHostName:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public static changeRemoteDebugOssBucket(Ljava/lang/String;)V
    .locals 1

    if-eqz p0, :cond_0

    .line 242
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    iput-object p0, v0, Lcom/taobao/tao/log/TLogInitializer;->ossBucketName:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public static logd(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 135
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/taobao/tao/log/TLog;->logd(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static loge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 187
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/taobao/tao/log/TLog;->loge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static loge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 200
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/taobao/tao/log/TLog;->loge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method public static logi(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 148
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/taobao/tao/log/TLog;->logi(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static logv(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 122
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/taobao/tao/log/TLog;->logv(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static logw(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 161
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/taobao/tao/log/TLog;->logw(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static logw(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 174
    :cond_0
    invoke-static {p0, p1, p2}, Lcom/taobao/tao/log/TLog;->logw(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method public static openHttp(Z)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 83
    :cond_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/taobao/tao/log/TLogInitializer;->openHttp(Z)V

    return-void
.end method

.method public static positiveUploadTlog(Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 91
    :cond_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/taobao/tao/log/TLogInitializer;->uploadTlog(Ljava/lang/String;)V

    return-void
.end method

.method public static traceLog(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 212
    :cond_0
    invoke-static {p0, p1}, Lcom/taobao/tao/log/TLog;->traceLog(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static updateLogLevel(Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/tlog/TLogService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 223
    :cond_0
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/taobao/tao/log/TLogInitializer;->updateLogLevel(Ljava/lang/String;)V

    return-void
.end method
