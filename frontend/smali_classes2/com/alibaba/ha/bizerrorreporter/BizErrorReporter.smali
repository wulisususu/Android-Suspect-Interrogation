.class public Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;
.super Ljava/lang/Object;
.source "BizErrorReporter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter$InstanceCreater;
    }
.end annotation


# instance fields
.field private mCustomInfo:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mErrorCallback:Lcom/alibaba/ha/protocol/crash/ErrorCallback;

.field public processName:Ljava/lang/String;

.field public reporterStartTime:Ljava/lang/Long;

.field public sampling:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

.field private threadPool:Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    new-instance v0, Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;

    invoke-direct {v0}, Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->threadPool:Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;

    .line 30
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->reporterStartTime:Ljava/lang/Long;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->processName:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->sampling:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    .line 39
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->mCustomInfo:Ljava/util/concurrent/ConcurrentHashMap;

    return-void
.end method

.method synthetic constructor <init>(Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter$1;)V
    .locals 0

    .line 24
    invoke-direct {p0}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;-><init>()V

    return-void
.end method

.method public static declared-synchronized getInstance()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;
    .locals 2

    const-class v0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

    monitor-enter v0

    .line 59
    :try_start_0
    invoke-static {}, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter$InstanceCreater;->access$100()Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;

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
.method public addCustomInfo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "key",
            "value"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->mCustomInfo:Ljava/util/concurrent/ConcurrentHashMap;

    .line 112
    invoke-virtual {v0, p1, p2}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method getCustomInfo()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->mCustomInfo:Ljava/util/concurrent/ConcurrentHashMap;

    return-object v0
.end method

.method getErrorCallback()Lcom/alibaba/ha/protocol/crash/ErrorCallback;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->mErrorCallback:Lcom/alibaba/ha/protocol/crash/ErrorCallback;

    return-object v0
.end method

.method public getProcessName(Landroid/content/Context;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "context"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->processName:Ljava/lang/String;

    if-eqz v0, :cond_0

    return-object v0

    .line 96
    :cond_0
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/utils/AppUtils;->getMyProcessNameByCmdline()Ljava/lang/String;

    move-result-object v0

    .line 97
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/StringUtils;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 98
    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/AppUtils;->getMyProcessNameByAppProcessInfo(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    :cond_1
    iput-object v0, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->processName:Ljava/lang/String;

    return-object v0
.end method

.method public openSampling(Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "sampling"
        }
    .end annotation

    iput-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->sampling:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    return-void
.end method

.method public send(Landroid/content/Context;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "context",
            "module"
        }
    .end annotation

    const-string v0, "MotuCrashAdapter"

    .line 69
    :try_start_0
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v1

    iget-object v1, v1, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    if-eqz v1, :cond_1

    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v1

    iget-object v1, v1, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    if-eqz p2, :cond_2

    .line 78
    new-instance v1, Lcom/alibaba/ha/bizerrorreporter/send/Sender;

    invoke-direct {v1, p1, p2}, Lcom/alibaba/ha/bizerrorreporter/send/Sender;-><init>(Landroid/content/Context;Lcom/alibaba/ha/bizerrorreporter/module/BizErrorModule;)V

    iget-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->threadPool:Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;

    .line 81
    invoke-virtual {p1, v1}, Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;->submit(Ljava/lang/Runnable;)V

    goto :goto_1

    :cond_1
    :goto_0
    const-string/jumbo p1, "you need init rest send service"

    .line 71
    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    const-string p2, "adapter err"

    .line 84
    invoke-static {v0, p2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_2
    :goto_1
    return-void
.end method

.method public setErrorCallback(Lcom/alibaba/ha/protocol/crash/ErrorCallback;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "callback"
        }
    .end annotation

    iput-object p1, p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorReporter;->mErrorCallback:Lcom/alibaba/ha/protocol/crash/ErrorCallback;

    return-void
.end method
