.class public Lcom/taobao/monitor/APMLauncher;
.super Ljava/lang/Object;
.source "APMLauncher.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "APMLauncher"

.field private static init:Z = false

.field private static final launchHelper:Lcom/taobao/application/common/data/c;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/application/common/data/c;

    invoke-direct {v0}, Lcom/taobao/application/common/data/c;-><init>()V

    sput-object v0, Lcom/taobao/monitor/APMLauncher;->launchHelper:Lcom/taobao/application/common/data/c;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Lcom/taobao/application/common/data/c;
    .locals 1

    sget-object v0, Lcom/taobao/monitor/APMLauncher;->launchHelper:Lcom/taobao/application/common/data/c;

    return-object v0
.end method

.method static synthetic access$100()V
    .locals 0

    .line 1
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->initOppoCPUResource()V

    return-void
.end method

.method static synthetic access$200()V
    .locals 0

    .line 1
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->initExecutor()V

    return-void
.end method

.method static synthetic access$300()V
    .locals 0

    .line 1
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->initWeex()V

    return-void
.end method

.method static synthetic access$400()V
    .locals 0

    .line 1
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->initProcessStartTime()V

    return-void
.end method

.method private static firstAsyncMessage()V
    .locals 2

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/taobao/monitor/APMLauncher$c;

    invoke-direct {v1}, Lcom/taobao/monitor/APMLauncher$c;-><init>()V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public static init(Landroid/app/Application;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Application;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    sget-boolean v0, Lcom/taobao/monitor/APMLauncher;->init:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    sput-boolean v0, Lcom/taobao/monitor/APMLauncher;->init:Z

    .line 5
    invoke-static {p0, p1}, Lcom/taobao/monitor/APMLauncher;->initParams(Landroid/app/Application;Ljava/util/Map;)V

    .line 7
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->initHotCold()V

    .line 9
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->initDispatcher()V

    .line 11
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->firstAsyncMessage()V

    .line 13
    invoke-static {p0}, Lcom/taobao/monitor/APMLauncher;->initLifecycle(Landroid/app/Application;)V

    .line 18
    invoke-static {}, Lcom/taobao/monitor/APMLauncher;->initApmImpl()V

    :cond_0
    return-void
.end method

.method private static initApmImpl()V
    .locals 0

    .line 1
    invoke-static {}, Lcom/taobao/application/common/a;->a()V

    return-void
.end method

.method private static initDispatcher()V
    .locals 2

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/f;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/f;-><init>()V

    const-string v1, "APPLICATION_LOW_MEMORY_DISPATCHER"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V

    .line 2
    new-instance v0, Lcom/taobao/monitor/impl/trace/e;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/e;-><init>()V

    const-string v1, "APPLICATION_GC_DISPATCHER"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V

    .line 5
    new-instance v0, Lcom/taobao/monitor/impl/trace/d;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/d;-><init>()V

    const-string v1, "APPLICATION_BACKGROUND_CHANGED_DISPATCHER"

    .line 6
    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V

    .line 9
    new-instance v0, Lcom/taobao/monitor/impl/trace/i;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/i;-><init>()V

    const-string v1, "ACTIVITY_FPS_DISPATCHER"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V

    .line 12
    new-instance v0, Lcom/taobao/monitor/impl/trace/c;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/c;-><init>()V

    .line 13
    new-instance v1, Lcom/taobao/monitor/impl/processor/pageload/e;

    invoke-direct {v1}, Lcom/taobao/monitor/impl/processor/pageload/e;-><init>()V

    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/trace/a;->addListener(Ljava/lang/Object;)V

    .line 14
    new-instance v1, Lcom/taobao/monitor/impl/processor/launcher/a;

    invoke-direct {v1}, Lcom/taobao/monitor/impl/processor/launcher/a;-><init>()V

    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/trace/a;->addListener(Ljava/lang/Object;)V

    const-string v1, "ACTIVITY_LIFECYCLE_DISPATCHER"

    .line 15
    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V

    .line 16
    new-instance v0, Lcom/taobao/monitor/impl/trace/b;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/b;-><init>()V

    const-string v1, "ACTIVITY_EVENT_DISPATCHER"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V

    .line 17
    new-instance v0, Lcom/taobao/monitor/impl/trace/o;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/o;-><init>()V

    const-string v1, "ACTIVITY_USABLE_VISIBLE_DISPATCHER"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V

    .line 20
    new-instance v0, Lcom/taobao/monitor/impl/trace/l;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/l;-><init>()V

    .line 21
    new-instance v1, Lcom/taobao/monitor/impl/processor/fragmentload/a;

    invoke-direct {v1}, Lcom/taobao/monitor/impl/processor/fragmentload/a;-><init>()V

    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/trace/a;->addListener(Ljava/lang/Object;)V

    const-string v1, "FRAGMENT_LIFECYCLE_DISPATCHER"

    .line 22
    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V

    .line 23
    new-instance v0, Lcom/taobao/monitor/impl/trace/o;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/o;-><init>()V

    const-string v1, "FRAGMENT_USABLE_VISIBLE_DISPATCHER"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V

    .line 26
    new-instance v0, Lcom/taobao/monitor/impl/trace/m;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/m;-><init>()V

    const-string v1, "IMAGE_STAGE_DISPATCHER"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V

    .line 29
    invoke-static {}, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->instance()Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;

    move-result-object v0

    new-instance v1, Lcom/taobao/monitor/impl/data/p/a;

    invoke-direct {v1}, Lcom/taobao/monitor/impl/data/p/a;-><init>()V

    invoke-virtual {v0, v1}, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->addLifeCycle(Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;)V

    .line 32
    new-instance v0, Lcom/taobao/monitor/impl/trace/n;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/n;-><init>()V

    const-string v1, "NETWORK_STAGE_DISPATCHER"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;Lcom/taobao/monitor/impl/trace/IDispatcher;)V

    .line 35
    invoke-static {}, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->instance()Lcom/taobao/network/lifecycle/NetworkLifecycleManager;

    move-result-object v0

    new-instance v1, Lcom/taobao/monitor/impl/data/q/a;

    invoke-direct {v1}, Lcom/taobao/monitor/impl/data/q/a;-><init>()V

    invoke-virtual {v0, v1}, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->setLifecycle(Lcom/taobao/network/lifecycle/INetworkLifecycle;)V

    .line 36
    invoke-static {}, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->instance()Lcom/taobao/network/lifecycle/MtopLifecycleManager;

    move-result-object v0

    new-instance v1, Lcom/taobao/monitor/impl/data/q/a;

    invoke-direct {v1}, Lcom/taobao/monitor/impl/data/q/a;-><init>()V

    invoke-virtual {v0, v1}, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->setLifecycle(Lcom/taobao/network/lifecycle/IMtopLifecycle;)V

    return-void
.end method

.method private static initExecutor()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/data/o/a;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/data/o/a;-><init>()V

    .line 2
    invoke-virtual {v0}, Lcom/taobao/monitor/impl/data/o/a;->a()V

    return-void
.end method

.method private static initHookActivityManager()V
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-gt v0, v1, :cond_0

    .line 2
    new-instance v0, Lcom/taobao/monitor/APMLauncher$b;

    invoke-direct {v0}, Lcom/taobao/monitor/APMLauncher$b;-><init>()V

    invoke-static {v0}, Lcom/taobao/monitor/APMLauncher;->runInMain(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method

.method private static initHotCold()V
    .locals 4

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    new-instance v1, Lcom/taobao/monitor/APMLauncher$a;

    invoke-direct {v1}, Lcom/taobao/monitor/APMLauncher$a;-><init>()V

    const-wide/16 v2, 0xbb8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method private static initLifecycle(Landroid/app/Application;)V
    .locals 1

    .line 1
    new-instance p0, Lcom/taobao/monitor/impl/data/m/b;

    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/m/b;-><init>()V

    .line 2
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->addObserver(Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;)V

    .line 3
    invoke-static {}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->getInstance()Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->registerActivityLifecycleCallbacks(Lcom/taobao/monitor/impl/data/m/b;)V

    return-void
.end method

.method private static initOppoCPUResource()V
    .locals 2

    const-string v0, "oppoCPUResource"

    const-string v1, "false"

    .line 1
    invoke-static {v0, v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 2
    sput-object v0, Lcom/taobao/monitor/impl/data/GlobalStats;->oppoCPUResource:Ljava/lang/String;

    return-void
.end method

.method private static initParams(Landroid/app/Application;Ljava/util/Map;)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Application;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lcom/taobao/monitor/impl/data/GlobalStats;->launchStartTime:J

    sget-object v0, Lcom/taobao/monitor/APMLauncher;->launchHelper:Lcom/taobao/application/common/data/c;

    const-string v1, "COLD"

    .line 2
    invoke-virtual {v0, v1}, Lcom/taobao/application/common/data/c;->a(Ljava/lang/String;)V

    .line 3
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/taobao/application/common/data/c;->b(J)V

    .line 4
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lcom/taobao/application/common/data/c;->c(J)V

    const-string v1, "appVersion"

    if-eqz p1, :cond_0

    .line 6
    invoke-interface {p1, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    const-string v2, "unknown"

    invoke-static {p1, v2}, Lcom/taobao/monitor/impl/util/e;->a(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sput-object p1, Lcom/taobao/monitor/impl/data/GlobalStats;->appVersion:Ljava/lang/String;

    .line 9
    :cond_0
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object p1

    invoke-virtual {p1, p0}, Lcom/taobao/monitor/impl/common/Global;->setContext(Landroid/content/Context;)Lcom/taobao/monitor/impl/common/Global;

    .line 11
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/monitor/impl/common/Global;->context()Landroid/content/Context;

    move-result-object p0

    const-string p1, "apm"

    const/4 v2, 0x0

    .line 12
    invoke-virtual {p0, p1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p0

    const-string p1, ""

    .line 13
    invoke-interface {p0, v1, p1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 14
    invoke-interface {p0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v4

    .line 16
    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v5

    const/4 v6, 0x1

    if-eqz v5, :cond_1

    .line 17
    sput-boolean v6, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstInstall:Z

    .line 18
    sput-boolean v6, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstLaunch:Z

    const-string v2, "NEW"

    .line 19
    sput-object v2, Lcom/taobao/monitor/impl/data/GlobalStats;->installType:Ljava/lang/String;

    .line 20
    sget-object v2, Lcom/taobao/monitor/impl/data/GlobalStats;->appVersion:Ljava/lang/String;

    invoke-interface {v4, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    :goto_0
    move v2, v6

    goto :goto_1

    .line 23
    :cond_1
    sput-boolean v2, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstInstall:Z

    .line 24
    sget-object v5, Lcom/taobao/monitor/impl/data/GlobalStats;->appVersion:Ljava/lang/String;

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    xor-int/2addr v3, v6

    sput-boolean v3, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstLaunch:Z

    const-string v3, "UPDATE"

    .line 25
    sput-object v3, Lcom/taobao/monitor/impl/data/GlobalStats;->installType:Ljava/lang/String;

    .line 26
    sget-boolean v3, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstLaunch:Z

    if-eqz v3, :cond_2

    .line 27
    sget-object v2, Lcom/taobao/monitor/impl/data/GlobalStats;->appVersion:Ljava/lang/String;

    invoke-interface {v4, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_0

    :cond_2
    :goto_1
    const-string v1, "LAST_TOP_ACTIVITY"

    .line 32
    invoke-interface {p0, v1, p1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    sput-object p0, Lcom/taobao/monitor/impl/data/GlobalStats;->lastTopActivity:Ljava/lang/String;

    .line 33
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p0

    if-nez p0, :cond_3

    .line 34
    invoke-interface {v4, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_2

    :cond_3
    if-eqz v2, :cond_4

    .line 39
    :goto_2
    invoke-interface {v4}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 42
    :cond_4
    invoke-static {}, Lcom/taobao/application/common/data/c$a;->a()J

    move-result-wide p0

    sput-wide p0, Lcom/taobao/monitor/impl/data/GlobalStats;->lastProcessStartTime:J

    .line 44
    sget-boolean p0, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstLaunch:Z

    invoke-virtual {v0, p0}, Lcom/taobao/application/common/data/c;->a(Z)V

    .line 45
    sget-boolean p0, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstInstall:Z

    invoke-virtual {v0, p0}, Lcom/taobao/application/common/data/c;->b(Z)V

    .line 46
    sget-wide p0, Lcom/taobao/monitor/impl/data/GlobalStats;->lastProcessStartTime:J

    invoke-virtual {v0, p0, p1}, Lcom/taobao/application/common/data/c;->a(J)V

    .line 48
    new-instance p0, Lcom/taobao/application/common/data/DeviceHelper;

    invoke-direct {p0}, Lcom/taobao/application/common/data/DeviceHelper;-><init>()V

    .line 49
    sget-object p1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/taobao/application/common/data/DeviceHelper;->setMobileModel(Ljava/lang/String;)V

    return-void
.end method

.method private static initProcessStartTime()V
    .locals 7

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {}, Landroid/os/Process;->getStartUptimeMillis()J

    move-result-wide v2

    add-long/2addr v0, v2

    .line 3
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    sub-long/2addr v0, v2

    sput-wide v0, Lcom/taobao/monitor/impl/data/GlobalStats;->processStartTime:J

    sget-object v0, Lcom/taobao/monitor/APMLauncher;->launchHelper:Lcom/taobao/application/common/data/c;

    .line 5
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v3

    sget-wide v5, Lcom/taobao/monitor/impl/data/GlobalStats;->processStartTime:J

    sub-long/2addr v3, v5

    sub-long/2addr v1, v3

    .line 6
    invoke-virtual {v0, v1, v2}, Lcom/taobao/application/common/data/c;->e(J)V

    .line 17
    sget-wide v1, Lcom/taobao/monitor/impl/data/GlobalStats;->processStartTime:J

    invoke-virtual {v0, v1, v2}, Lcom/taobao/application/common/data/c;->d(J)V

    return-void
.end method

.method private static initWeex()V
    .locals 2

    .line 1
    sget-boolean v0, Lcom/taobao/monitor/impl/common/DynamicConstants;->needWeex:Z

    if-eqz v0, :cond_0

    .line 2
    invoke-static {}, Lcom/taobao/monitor/performance/APMAdapterFactoryProxy;->instance()Lcom/taobao/monitor/performance/APMAdapterFactoryProxy;

    move-result-object v0

    new-instance v1, Lcom/taobao/monitor/impl/processor/b/a;

    invoke-direct {v1}, Lcom/taobao/monitor/impl/processor/b/a;-><init>()V

    invoke-virtual {v0, v1}, Lcom/taobao/monitor/performance/APMAdapterFactoryProxy;->setFactory(Lcom/taobao/monitor/performance/IApmAdapterFactory;)V

    :cond_0
    return-void
.end method

.method private static runInMain(Ljava/lang/Runnable;)V
    .locals 2

    .line 1
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object v1

    if-ne v0, v1, :cond_0

    .line 2
    invoke-interface {p0}, Ljava/lang/Runnable;->run()V

    goto :goto_0

    .line 4
    :cond_0
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 5
    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :goto_0
    return-void
.end method
