.class public Lcom/alibaba/ha/adapter/service/bizerror/BizErrorService;
.super Ljava/lang/Object;
.source "BizErrorService.java"


# static fields
.field public static isValid:Z = false


# direct methods
.method public static constructor <clinit>()V
    .locals 3

    :try_start_0
    const-string v0, "com.alibaba.ha.bizerrorreporter.BizErrorReporter"

    .line 18
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/alibaba/ha/adapter/service/bizerror/BizErrorService;->isValid:Z
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const/4 v1, 0x0

    sput-boolean v1, Lcom/alibaba/ha/adapter/service/bizerror/BizErrorService;->isValid:Z

    .line 22
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "bizerror load failed. "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/lang/ClassNotFoundException;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "AliHaAdapter"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addCustomInfo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/bizerror/BizErrorService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 96
    :cond_0
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->addCustomInfo(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public static sendBizError(Landroid/content/Context;Ljava/lang/Throwable;)V
    .locals 5

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/bizerror/BizErrorService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 37
    :cond_0
    :try_start_0
    new-instance v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    invoke-direct {v0}, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;-><init>()V

    const-string v1, "HA_CUSTOM_ERROR"

    .line 38
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->businessType:Ljava/lang/String;

    .line 39
    sget-object v1, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;->STACK:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->aggregationType:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    const/4 v1, 0x0

    .line 40
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionCode:Ljava/lang/String;

    .line 41
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->businessType:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "_"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionId:Ljava/lang/String;

    .line 42
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionDetail:Ljava/lang/String;

    .line 43
    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->throwable:Ljava/lang/Throwable;

    .line 44
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->thread:Ljava/lang/Thread;

    const-string p1, "1.0.0.0"

    .line 45
    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionVersion:Ljava/lang/String;

    const-string p1, "arg1"

    .line 46
    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg1:Ljava/lang/String;

    const-string p1, "arg2"

    .line 47
    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg2:Ljava/lang/String;

    const-string p1, "arg3"

    .line 48
    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg3:Ljava/lang/String;

    const/16 p1, 0xa

    .line 49
    iput p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->errorType:I

    .line 51
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    move-result-object p1

    invoke-virtual {p1, p0, v0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->send(Landroid/content/Context;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    return-void
.end method

.method public static sendCrashError(Landroid/content/Context;Ljava/lang/Throwable;)V
    .locals 5

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/bizerror/BizErrorService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 63
    :cond_0
    :try_start_0
    new-instance v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;

    invoke-direct {v0}, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;-><init>()V

    const-string v1, "HA_CRASH_JAVA"

    .line 64
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->businessType:Ljava/lang/String;

    .line 65
    sget-object v1, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;->STACK:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->aggregationType:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    const/4 v1, 0x0

    .line 66
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionCode:Ljava/lang/String;

    .line 67
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->businessType:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "_"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionId:Ljava/lang/String;

    .line 68
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionDetail:Ljava/lang/String;

    .line 69
    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->throwable:Ljava/lang/Throwable;

    .line 70
    iput-object v1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->thread:Ljava/lang/Thread;

    const-string p1, "1.0.0.0"

    .line 71
    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionVersion:Ljava/lang/String;

    const-string p1, "arg1"

    .line 72
    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg1:Ljava/lang/String;

    const-string p1, "arg2"

    .line 73
    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg2:Ljava/lang/String;

    const-string p1, "arg3"

    .line 74
    iput-object p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->exceptionArg3:Ljava/lang/String;

    const/4 p1, 0x1

    .line 75
    iput p1, v0, Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;->errorType:I

    .line 77
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    move-result-object p1

    invoke-virtual {p1, p0, v0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->send(Landroid/content/Context;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    return-void
.end method

.method public static setErrorCallback(Lcom/alibaba/ha/protocol/crash/ErrorCallback;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/bizerror/BizErrorService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 88
    :cond_0
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->setErrorCallback(Lcom/alibaba/ha/protocol/crash/ErrorCallback;)V

    return-void
.end method
