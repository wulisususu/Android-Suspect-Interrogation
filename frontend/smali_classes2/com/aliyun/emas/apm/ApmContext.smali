.class public Lcom/aliyun/emas/apm/ApmContext;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/ApmContext$UserUnlockReceiver;
    }
.end annotation


# static fields
.field private static final f:Ljava/lang/Object;

.field static final g:Ljava/util/Map;

.field private static final h:Lcom/aliyun/emas/apm/StartupTime;

.field private static final i:Lcom/aliyun/emas/apm/ApmSession;


# instance fields
.field private final a:Landroid/content/Context;

.field private final b:Ljava/lang/String;

.field private final c:Lcom/aliyun/emas/apm/ApmOptions;

.field private final d:Lcom/aliyun/emas/apm/components/ComponentRuntime;

.field private final e:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/ApmContext;->f:Ljava/lang/Object;

    .line 5
    new-instance v0, Landroidx/collection/ArrayMap;

    invoke-direct {v0}, Landroidx/collection/ArrayMap;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/ApmContext;->g:Ljava/util/Map;

    .line 14
    invoke-static {}, Lcom/aliyun/emas/apm/StartupTime;->now()Lcom/aliyun/emas/apm/StartupTime;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/ApmContext;->h:Lcom/aliyun/emas/apm/StartupTime;

    .line 15
    new-instance v0, Lcom/aliyun/emas/apm/ApmSession;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/ApmSession;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/ApmContext;->i:Lcom/aliyun/emas/apm/ApmSession;

    return-void
.end method

.method protected constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/aliyun/emas/apm/ApmOptions;)V
    .locals 5

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->e:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 212
    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/Context;

    iput-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->a:Landroid/content/Context;

    .line 213
    invoke-static {p2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotEmpty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/aliyun/emas/apm/ApmContext;->b:Ljava/lang/String;

    .line 214
    invoke-static {p3}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/aliyun/emas/apm/ApmOptions;

    iput-object p2, p0, Lcom/aliyun/emas/apm/ApmContext;->c:Lcom/aliyun/emas/apm/ApmOptions;

    sget-object p2, Lcom/aliyun/emas/apm/ApmContext;->h:Lcom/aliyun/emas/apm/StartupTime;

    .line 216
    new-instance v0, Lcom/aliyun/emas/apm/settings/SettingsController;

    invoke-virtual {p3}, Lcom/aliyun/emas/apm/ApmOptions;->getAppKey()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p3}, Lcom/aliyun/emas/apm/ApmOptions;->getAppSecret()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, p1, v1, v2, p3}, Lcom/aliyun/emas/apm/settings/SettingsController;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lcom/aliyun/emas/apm/ApmOptions;)V

    const-string v1, "Apm"

    .line 218
    invoke-static {v1}, Lcom/aliyun/emas/apm/a;->a(Ljava/lang/String;)V

    const-string v1, "ComponentDiscovery"

    .line 220
    invoke-static {v1}, Lcom/aliyun/emas/apm/a;->a(Ljava/lang/String;)V

    .line 222
    const-class v1, Lcom/aliyun/emas/apm/components/ComponentDiscoveryService;

    invoke-static {p1, v1}, Lcom/aliyun/emas/apm/components/ComponentDiscovery;->forContext(Landroid/content/Context;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/ComponentDiscovery;

    move-result-object v1

    .line 223
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/ComponentDiscovery;->discoverLazy()Ljava/util/List;

    move-result-object v1

    .line 224
    invoke-static {}, Lcom/aliyun/emas/apm/a;->a()V

    const-string v2, "Runtime"

    .line 226
    invoke-static {v2}, Lcom/aliyun/emas/apm/a;->a(Ljava/lang/String;)V

    .line 227
    sget-object v2, Lcom/aliyun/emas/apm/j;->a:Lcom/aliyun/emas/apm/j;

    .line 228
    invoke-static {v2}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->builder(Ljava/util/concurrent/Executor;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    move-result-object v2

    .line 229
    invoke-virtual {v2, v1}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->addLazyComponentRegistrars(Ljava/util/Collection;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    move-result-object v1

    new-instance v2, Lcom/aliyun/emas/apm/ApmCommonRegistrar;

    invoke-direct {v2}, Lcom/aliyun/emas/apm/ApmCommonRegistrar;-><init>()V

    .line 230
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->addComponentRegistrar(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    move-result-object v1

    new-instance v2, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;

    invoke-direct {v2}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;-><init>()V

    .line 231
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->addComponentRegistrar(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    move-result-object v1

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Class;

    .line 232
    const-class v4, Landroid/content/Context;

    invoke-static {p1, v4, v3}, Lcom/aliyun/emas/apm/components/Component;->of(Ljava/lang/Object;Ljava/lang/Class;[Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->addComponent(Lcom/aliyun/emas/apm/components/Component;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    move-result-object v1

    new-array v3, v2, [Ljava/lang/Class;

    const-class v4, Lcom/aliyun/emas/apm/ApmContext;

    .line 233
    invoke-static {p0, v4, v3}, Lcom/aliyun/emas/apm/components/Component;->of(Ljava/lang/Object;Ljava/lang/Class;[Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->addComponent(Lcom/aliyun/emas/apm/components/Component;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    move-result-object v1

    new-array v3, v2, [Ljava/lang/Class;

    .line 234
    const-class v4, Lcom/aliyun/emas/apm/ApmOptions;

    invoke-static {p3, v4, v3}, Lcom/aliyun/emas/apm/components/Component;->of(Ljava/lang/Object;Ljava/lang/Class;[Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object p3

    invoke-virtual {v1, p3}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->addComponent(Lcom/aliyun/emas/apm/components/Component;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    move-result-object p3

    sget-object v1, Lcom/aliyun/emas/apm/ApmContext;->i:Lcom/aliyun/emas/apm/ApmSession;

    new-array v3, v2, [Ljava/lang/Class;

    .line 235
    const-class v4, Lcom/aliyun/emas/apm/ApmSession;

    invoke-static {v1, v4, v3}, Lcom/aliyun/emas/apm/components/Component;->of(Ljava/lang/Object;Ljava/lang/Class;[Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    invoke-virtual {p3, v1}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->addComponent(Lcom/aliyun/emas/apm/components/Component;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    move-result-object p3

    new-array v1, v2, [Ljava/lang/Class;

    .line 236
    const-class v3, Lcom/aliyun/emas/apm/settings/SettingProvider;

    invoke-static {v0, v3, v1}, Lcom/aliyun/emas/apm/components/Component;->of(Ljava/lang/Object;Ljava/lang/Class;[Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    invoke-virtual {p3, v1}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->addComponent(Lcom/aliyun/emas/apm/components/Component;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    move-result-object p3

    new-instance v1, Lcom/aliyun/emas/apm/d;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/d;-><init>()V

    .line 237
    invoke-virtual {p3, v1}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->setProcessor(Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    move-result-object p3

    .line 240
    invoke-static {p1}, Landroidx/core/os/UserManagerCompat;->isUserUnlocked(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_0

    new-array p1, v2, [Ljava/lang/Class;

    .line 241
    const-class v1, Lcom/aliyun/emas/apm/StartupTime;

    invoke-static {p2, v1, p1}, Lcom/aliyun/emas/apm/components/Component;->of(Ljava/lang/Object;Ljava/lang/Class;[Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object p1

    invoke-virtual {p3, p1}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->addComponent(Lcom/aliyun/emas/apm/components/Component;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    .line 244
    :cond_0
    invoke-virtual {p3}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;->build()Lcom/aliyun/emas/apm/components/ComponentRuntime;

    move-result-object p1

    iput-object p1, p0, Lcom/aliyun/emas/apm/ApmContext;->d:Lcom/aliyun/emas/apm/components/ComponentRuntime;

    .line 246
    invoke-static {}, Lcom/aliyun/emas/apm/f;->a()Lcom/aliyun/emas/apm/f;

    move-result-object p1

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/f;->a(Lcom/aliyun/emas/apm/settings/SettingProvider;)V

    .line 247
    invoke-static {}, Lcom/aliyun/emas/apm/a;->a()V

    .line 249
    invoke-static {}, Lcom/aliyun/emas/apm/a;->a()V

    return-void
.end method

.method private static a(Landroid/content/Context;Lcom/aliyun/emas/apm/ApmOptions;Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmContext;
    .locals 4

    .line 3
    invoke-static {p2}, Lcom/aliyun/emas/apm/ApmContext;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 6
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 10
    :cond_0
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    :goto_0
    sget-object v0, Lcom/aliyun/emas/apm/ApmContext;->f:Ljava/lang/Object;

    .line 12
    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/aliyun/emas/apm/ApmContext;->g:Ljava/util/Map;

    .line 14
    invoke-interface {v1, p2}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    xor-int/lit8 v2, v2, 0x1

    const-string v3, "Apm has already initialized!"

    .line 15
    invoke-static {v2, v3}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    const-string v2, "Application context cannot be null."

    .line 19
    invoke-static {p0, v2}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 20
    new-instance v2, Lcom/aliyun/emas/apm/ApmContext;

    invoke-direct {v2, p0, p2, p1}, Lcom/aliyun/emas/apm/ApmContext;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/aliyun/emas/apm/ApmOptions;)V

    .line 21
    invoke-interface {v1, p2, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 22
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 24
    invoke-direct {v2}, Lcom/aliyun/emas/apm/ApmContext;->d()V

    return-object v2

    :catchall_0
    move-exception p0

    .line 25
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method static synthetic a()Ljava/lang/Object;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/ApmContext;->f:Ljava/lang/Object;

    return-object v0
.end method

.method private static a(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 26
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/ApmContext;)V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/ApmContext;->d()V

    return-void
.end method

.method private b()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->e:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    const-string v1, "Apm was deleted"

    invoke-static {v0, v1}, Lcom/google/android/gms/common/internal/Preconditions;->checkState(ZLjava/lang/Object;)V

    return-void
.end method

.method private c()Ljava/lang/String;
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/ApmContext;->b()V

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->b:Ljava/lang/String;

    return-object v0
.end method

.method public static clearInstancesForTest()V
    .locals 2

    sget-object v0, Lcom/aliyun/emas/apm/ApmContext;->f:Ljava/lang/Object;

    .line 1
    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/aliyun/emas/apm/ApmContext;->g:Ljava/util/Map;

    .line 2
    invoke-interface {v1}, Ljava/util/Map;->clear()V

    .line 3
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    .line 4
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method private d()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->a:Landroid/content/Context;

    .line 1
    invoke-static {v0}, Landroidx/core/os/UserManagerCompat;->isUserUnlocked(Landroid/content/Context;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    const-string v1, "Apm"

    if-eqz v0, :cond_0

    const-string v0, "Device in Direct Boot Mode: postponing initialization of Apm"

    .line 3
    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->a:Landroid/content/Context;

    .line 7
    invoke-static {v0}, Lcom/aliyun/emas/apm/ApmContext$UserUnlockReceiver;->a(Landroid/content/Context;)V

    goto :goto_0

    :cond_0
    const-string v0, "Device unlocked: initializing Apm"

    .line 9
    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->d:Lcom/aliyun/emas/apm/components/ComponentRuntime;

    .line 10
    invoke-direct {p0}, Lcom/aliyun/emas/apm/ApmContext;->e()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->initializeEagerComponents(Z)V

    :goto_0
    return-void
.end method

.method private e()Z
    .locals 2

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/ApmContext;->c()Ljava/lang/String;

    move-result-object v0

    const-string v1, "[DEFAULT]"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static getApmSession()Lcom/aliyun/emas/apm/ApmSession;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/ApmContext;->i:Lcom/aliyun/emas/apm/ApmSession;

    return-object v0
.end method

.method public static getInstance()Lcom/aliyun/emas/apm/ApmContext;
    .locals 4

    const-string v0, "Apm is not initialized in this process "

    sget-object v1, Lcom/aliyun/emas/apm/ApmContext;->f:Ljava/lang/Object;

    .line 1
    monitor-enter v1

    :try_start_0
    sget-object v2, Lcom/aliyun/emas/apm/ApmContext;->g:Ljava/util/Map;

    const-string v3, "[DEFAULT]"

    .line 2
    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/ApmContext;

    if-eqz v2, :cond_0

    .line 11
    monitor-exit v1

    return-object v2

    .line 12
    :cond_0
    new-instance v2, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 15
    invoke-static {}, Lcom/google/android/gms/common/util/ProcessUtils;->getMyProcessName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, ". Make sure to call Apm.start() first."

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v2, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2

    :catchall_0
    move-exception v0

    .line 20
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public static initialize(Lcom/aliyun/emas/apm/ApmOptions;)Lcom/aliyun/emas/apm/ApmContext;
    .locals 3

    sget-object v0, Lcom/aliyun/emas/apm/ApmContext;->f:Ljava/lang/Object;

    .line 1
    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/aliyun/emas/apm/ApmContext;->g:Ljava/util/Map;

    const-string v2, "[DEFAULT]"

    .line 2
    invoke-interface {v1, v2}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 3
    invoke-static {}, Lcom/aliyun/emas/apm/ApmContext;->getInstance()Lcom/aliyun/emas/apm/ApmContext;

    move-result-object p0

    monitor-exit v0

    return-object p0

    :cond_0
    if-nez p0, :cond_1

    const-string p0, "Apm"

    const-string v1, "Apm failed to initialize because apm options were not set. This usually means that you not invoke Apm.preStart(ApmOptions) before Apm.start()."

    .line 6
    invoke-static {p0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 10
    monitor-exit v0

    const/4 p0, 0x0

    return-object p0

    .line 12
    :cond_1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/ApmOptions;->getApplication()Landroid/app/Application;

    move-result-object v1

    const-string v2, "[DEFAULT]"

    invoke-static {v1, p0, v2}, Lcom/aliyun/emas/apm/ApmContext;->a(Landroid/content/Context;Lcom/aliyun/emas/apm/ApmOptions;Ljava/lang/String;)Lcom/aliyun/emas/apm/ApmContext;

    move-result-object p0

    monitor-exit v0

    return-object p0

    :catchall_0
    move-exception p0

    .line 13
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method


# virtual methods
.method public delete()V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->e:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    .line 1
    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lcom/aliyun/emas/apm/ApmContext;->f:Ljava/lang/Object;

    .line 6
    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/aliyun/emas/apm/ApmContext;->g:Ljava/util/Map;

    iget-object v2, p0, Lcom/aliyun/emas/apm/ApmContext;->b:Ljava/lang/String;

    .line 7
    invoke-interface {v1, v2}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 8
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    .line 9
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 1

    .line 1
    instance-of v0, p1, Lcom/aliyun/emas/apm/ApmContext;

    if-nez v0, :cond_0

    const/4 p1, 0x0

    return p1

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->b:Ljava/lang/String;

    .line 4
    check-cast p1, Lcom/aliyun/emas/apm/ApmContext;

    invoke-direct {p1}, Lcom/aliyun/emas/apm/ApmContext;->c()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public get(Ljava/lang/Class;)Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Class<",
            "TT;>;)TT;"
        }
    .end annotation

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/ApmContext;->b()V

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->d:Lcom/aliyun/emas/apm/components/ComponentRuntime;

    .line 2
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->get(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public getApplicationContext()Landroid/content/Context;
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/ApmContext;->b()V

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->a:Landroid/content/Context;

    return-object v0
.end method

.method public getOptions()Lcom/aliyun/emas/apm/ApmOptions;
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/ApmContext;->b()V

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->c:Lcom/aliyun/emas/apm/ApmOptions;

    return-object v0
.end method

.method public hashCode()I
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/ApmContext;->b:Ljava/lang/String;

    .line 1
    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 1
    invoke-static {p0}, Lcom/google/android/gms/common/internal/Objects;->toStringHelper(Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/ApmContext;->b:Ljava/lang/String;

    const-string v2, "name"

    invoke-virtual {v0, v2, v1}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/ApmContext;->c:Lcom/aliyun/emas/apm/ApmOptions;

    const-string v2, "options"

    invoke-virtual {v0, v2, v1}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->add(Ljava/lang/String;Ljava/lang/Object;)Lcom/google/android/gms/common/internal/Objects$ToStringHelper;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/android/gms/common/internal/Objects$ToStringHelper;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
