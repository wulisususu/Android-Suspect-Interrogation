.class public Lcom/taobao/monitor/adapter/SimpleApmInitiator;
.super Ljava/lang/Object;
.source "SimpleApmInitiator.java"

# interfaces
.implements Ljava/io/Serializable;


# static fields
.field private static final TAG:Ljava/lang/String; = "TBAPMAdapterLaunchers"


# instance fields
.field private apmStartTime:J

.field private cpuStartTime:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 44
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->apmStartTime:J

    .line 45
    invoke-static {}, Landroid/os/SystemClock;->currentThreadTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->cpuStartTime:J

    return-void
.end method

.method private initAPMFunction(Landroid/app/Application;Ljava/util/HashMap;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x0
        }
        names = {
            "application",
            "params"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Application;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .line 93
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-static {}, Lcom/taobao/monitor/ProcedureGlobal;->instance()Lcom/taobao/monitor/ProcedureGlobal;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/monitor/ProcedureGlobal;->handler()Landroid/os/Handler;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/common/Global;->setHandler(Landroid/os/Handler;)V

    .line 95
    invoke-direct {p0, p1, p2}, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initAPMLauncher(Landroid/app/Application;Ljava/util/HashMap;)V

    .line 97
    invoke-direct {p0, p1}, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initTbRest(Landroid/app/Application;)V

    .line 99
    invoke-direct {p0, p1}, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initFulltrace(Landroid/app/Application;)V

    .line 101
    invoke-direct {p0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initDataHub()V

    .line 103
    invoke-direct {p0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initLauncherProcedure()V

    .line 105
    invoke-direct {p0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initWebView()V

    return-void
.end method

.method private initAPMLauncher(Landroid/app/Application;Ljava/util/HashMap;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "application",
            "params"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Application;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .line 259
    invoke-static {p1, p2}, Lcom/taobao/monitor/ProcedureLauncher;->init(Landroid/content/Context;Ljava/util/Map;)V

    .line 260
    invoke-static {p1, p2}, Lcom/taobao/monitor/APMLauncher;->init(Landroid/app/Application;Ljava/util/Map;)V

    .line 261
    invoke-static {}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->instance()Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    move-result-object p1

    new-instance p2, Lcom/taobao/monitor/adapter/SimpleApmInitiator$4;

    invoke-direct {p2, p0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$4;-><init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator;)V

    invoke-virtual {p1, p2}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->setProxy(Lcom/taobao/monitor/impl/processor/pageload/IProcedureManager;)Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    return-void
.end method

.method private initDataHub()V
    .locals 2

    .line 115
    invoke-static {}, Lcom/ali/ha/datahub/DataHub;->getInstance()Lcom/ali/ha/datahub/DataHub;

    move-result-object v0

    new-instance v1, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;

    invoke-direct {v1, p0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;-><init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator;)V

    invoke-virtual {v0, v1}, Lcom/ali/ha/datahub/DataHub;->init(Lcom/ali/ha/datahub/BizSubscriber;)V

    return-void
.end method

.method private initDeviceEvaluation(Landroid/app/Application;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "application"
        }
    .end annotation

    .line 81
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->setUp(Landroid/app/Application;)V

    .line 82
    new-instance p1, Lcom/taobao/monitor/adapter/SimpleApmInitiator$1;

    invoke-direct {p1, p0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$1;-><init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator;)V

    invoke-static {p1}, Lcom/taobao/monitor/common/ThreadUtils;->start(Ljava/lang/Runnable;)V

    return-void
.end method

.method private initFulltrace(Landroid/app/Application;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10
        }
        names = {
            "application"
        }
    .end annotation

    .line 281
    new-instance v0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$5;

    invoke-direct {v0, p0, p1}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$5;-><init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator;Landroid/app/Application;)V

    invoke-static {v0}, Lcom/taobao/monitor/common/ThreadUtils;->start(Ljava/lang/Runnable;)V

    return-void
.end method

.method private initLauncherProcedure()V
    .locals 5

    .line 226
    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    invoke-direct {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;-><init>()V

    const/4 v1, 0x0

    .line 227
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setIndependent(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    const/4 v2, 0x1

    .line 228
    invoke-virtual {v0, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setUpload(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 229
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    const/4 v3, 0x0

    .line 230
    invoke-virtual {v0, v3}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 231
    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->build()Lcom/taobao/monitor/procedure/ProcedureConfig;

    move-result-object v0

    .line 233
    sget-object v3, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    const-string v4, "/startup"

    invoke-static {v4}, Lcom/taobao/monitor/impl/util/TopicUtils;->getFullTopic(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4, v0}, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    .line 234
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->begin()Lcom/taobao/monitor/procedure/IProcedure;

    .line 235
    sget-object v3, Lcom/taobao/monitor/ProcedureGlobal;->PROCEDURE_MANAGER:Lcom/taobao/monitor/procedure/ProcedureManager;

    invoke-virtual {v3, v0}, Lcom/taobao/monitor/procedure/ProcedureManager;->setLauncherProcedure(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 237
    new-instance v3, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    invoke-direct {v3}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;-><init>()V

    .line 238
    invoke-virtual {v3, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setIndependent(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v3

    .line 239
    invoke-virtual {v3, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setUpload(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v3

    .line 240
    invoke-virtual {v3, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v3

    .line 241
    invoke-virtual {v3, v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 242
    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->build()Lcom/taobao/monitor/procedure/ProcedureConfig;

    move-result-object v0

    .line 244
    sget-object v3, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    const-string v4, "/APMSelf"

    invoke-virtual {v3, v4, v0}, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    .line 245
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->begin()Lcom/taobao/monitor/procedure/IProcedure;

    .line 246
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-virtual {v3}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object v3

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v4

    if-ne v3, v4, :cond_0

    move v1, v2

    :cond_0
    const-string v2, "isMainThread"

    .line 247
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 248
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "threadName"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "taskStart"

    iget-wide v2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->apmStartTime:J

    .line 249
    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "cpuStartTime"

    iget-wide v2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->cpuStartTime:J

    .line 250
    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 251
    invoke-static {}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->transferPendingTasks()V

    const-string v1, "taskEnd"

    .line 252
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "cpuEndTime"

    .line 253
    invoke-static {}, Landroid/os/SystemClock;->currentThreadTimeMillis()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 254
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->end()Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method private initTbRest(Landroid/app/Application;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "application"
        }
    .end annotation

    .line 110
    invoke-static {}, Lcom/taobao/monitor/network/NetworkSenderProxy;->instance()Lcom/taobao/monitor/network/NetworkSenderProxy;

    move-result-object p1

    new-instance v0, Lcom/taobao/monitor/adapter/network/TBRestSender;

    invoke-direct {v0}, Lcom/taobao/monitor/adapter/network/TBRestSender;-><init>()V

    invoke-virtual {p1, v0}, Lcom/taobao/monitor/network/NetworkSenderProxy;->setSender(Lcom/taobao/monitor/network/INetworkSender;)Lcom/taobao/monitor/network/NetworkSenderProxy;

    return-void
.end method

.method private initWebView()V
    .locals 2

    .line 199
    sget-object v0, Lcom/taobao/monitor/impl/data/WebViewProxy;->INSTANCE:Lcom/taobao/monitor/impl/data/WebViewProxy;

    new-instance v1, Lcom/taobao/monitor/adapter/SimpleApmInitiator$3;

    invoke-direct {v1, p0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$3;-><init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator;)V

    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/data/WebViewProxy;->setReal(Lcom/taobao/monitor/impl/data/IWebView;)Lcom/taobao/monitor/impl/data/WebViewProxy;

    return-void
.end method

.method public static setDebug(Z)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "isDebug"
        }
    .end annotation

    .line 77
    invoke-static {p0}, Lcom/taobao/monitor/impl/logger/Logger;->setDebug(Z)V

    return-void
.end method


# virtual methods
.method public init(Landroid/app/Application;Ljava/util/HashMap;)V
    .locals 4
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "application",
            "params"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Application;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .line 49
    sget-boolean v0, Lcom/taobao/monitor/adapter/common/TBAPMConstants;->init:Z

    const-string v1, "TBAPMAdapterLaunchers"

    if-nez v0, :cond_0

    const-string v0, "init start"

    .line 50
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    const/4 v0, 0x1

    .line 51
    sput-boolean v0, Lcom/taobao/monitor/adapter/common/TBAPMConstants;->open:Z

    .line 52
    invoke-direct {p0, p1, p2}, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initAPMFunction(Landroid/app/Application;Ljava/util/HashMap;)V

    .line 53
    invoke-direct {p0, p1}, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initDeviceEvaluation(Landroid/app/Application;)V

    const-string p1, "init end"

    .line 55
    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v1, p1}, Lcom/taobao/monitor/impl/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 56
    sput-boolean v0, Lcom/taobao/monitor/adapter/common/TBAPMConstants;->init:Z

    .line 59
    :cond_0
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide p1

    iget-wide v2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator;->apmStartTime:J

    sub-long/2addr p1, v2

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    const-string p2, "apmStartTime:"

    filled-new-array {p2, p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v1, p1}, Lcom/taobao/monitor/impl/logger/Logger;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method
