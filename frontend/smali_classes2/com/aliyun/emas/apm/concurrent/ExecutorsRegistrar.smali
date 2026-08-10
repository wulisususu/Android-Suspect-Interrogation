.class public Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentRegistrar;


# static fields
.field static final a:Lcom/aliyun/emas/apm/components/Lazy;

.field static final b:Lcom/aliyun/emas/apm/components/Lazy;

.field static final c:Lcom/aliyun/emas/apm/components/Lazy;

.field static final d:Lcom/aliyun/emas/apm/components/Lazy;


# direct methods
.method public static synthetic $r8$lambda$8A9oBCqW_FfpxXmLCIHxWvtmbow(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/ScheduledExecutorService;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->c(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$J6KkDQVqg0-pOJNkmgg5xqjFDWQ()Ljava/util/concurrent/ScheduledExecutorService;
    .locals 1

    invoke-static {}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->c()Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    return-object v0
.end method

.method public static synthetic $r8$lambda$Q8FstsF3zv_H0MP5REfq9UUTDgQ()Ljava/util/concurrent/ScheduledExecutorService;
    .locals 1

    invoke-static {}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->e()Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    return-object v0
.end method

.method public static synthetic $r8$lambda$a5uzaQdPmnrCCX2GUzIFXOkwoqo(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/ScheduledExecutorService;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->b(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$dEoWP1p8MiV7TdEltO3oUx1YSiI(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/Executor;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->d(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/Executor;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$kbWAw9BmcFtr9gFVJssvfAJCG84()Ljava/util/concurrent/ScheduledExecutorService;
    .locals 1

    invoke-static {}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->d()Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    return-object v0
.end method

.method public static synthetic $r8$lambda$o9_2N5a2ggdkrfFL5NQrH3YtOVo()Ljava/util/concurrent/ScheduledExecutorService;
    .locals 1

    invoke-static {}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->b()Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    return-object v0
.end method

.method public static synthetic $r8$lambda$r15QbGVXnHiKkHDnhWcHqpLXfsA(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/ScheduledExecutorService;
    .locals 0

    invoke-static {p0}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->a(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/Lazy;

    new-instance v1, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda4;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda4;-><init>()V

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/components/Lazy;-><init>(Lcom/aliyun/emas/apm/inject/Provider;)V

    sput-object v0, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->a:Lcom/aliyun/emas/apm/components/Lazy;

    .line 10
    new-instance v0, Lcom/aliyun/emas/apm/components/Lazy;

    new-instance v1, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda5;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda5;-><init>()V

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/components/Lazy;-><init>(Lcom/aliyun/emas/apm/inject/Provider;)V

    sput-object v0, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->b:Lcom/aliyun/emas/apm/components/Lazy;

    .line 18
    new-instance v0, Lcom/aliyun/emas/apm/components/Lazy;

    new-instance v1, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda6;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda6;-><init>()V

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/components/Lazy;-><init>(Lcom/aliyun/emas/apm/inject/Provider;)V

    sput-object v0, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->c:Lcom/aliyun/emas/apm/components/Lazy;

    .line 28
    new-instance v0, Lcom/aliyun/emas/apm/components/Lazy;

    new-instance v1, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda7;

    invoke-direct {v1}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda7;-><init>()V

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/components/Lazy;-><init>(Lcom/aliyun/emas/apm/inject/Provider;)V

    sput-object v0, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->d:Lcom/aliyun/emas/apm/components/Lazy;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a()Landroid/os/StrictMode$ThreadPolicy;
    .locals 1

    .line 5
    new-instance v0, Landroid/os/StrictMode$ThreadPolicy$Builder;

    invoke-direct {v0}, Landroid/os/StrictMode$ThreadPolicy$Builder;-><init>()V

    invoke-virtual {v0}, Landroid/os/StrictMode$ThreadPolicy$Builder;->detectNetwork()Landroid/os/StrictMode$ThreadPolicy$Builder;

    move-result-object v0

    .line 7
    invoke-virtual {v0}, Landroid/os/StrictMode$ThreadPolicy$Builder;->detectResourceMismatches()Landroid/os/StrictMode$ThreadPolicy$Builder;

    .line 9
    invoke-virtual {v0}, Landroid/os/StrictMode$ThreadPolicy$Builder;->detectUnbufferedIo()Landroid/os/StrictMode$ThreadPolicy$Builder;

    .line 15
    invoke-virtual {v0}, Landroid/os/StrictMode$ThreadPolicy$Builder;->penaltyLog()Landroid/os/StrictMode$ThreadPolicy$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/StrictMode$ThreadPolicy$Builder;->build()Landroid/os/StrictMode$ThreadPolicy;

    move-result-object v0

    return-object v0
.end method

.method private static synthetic a(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/ScheduledExecutorService;
    .locals 0

    sget-object p0, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->a:Lcom/aliyun/emas/apm/components/Lazy;

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/Lazy;->get()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/util/concurrent/ScheduledExecutorService;

    return-object p0
.end method

.method private static a(Ljava/util/concurrent/ExecutorService;)Ljava/util/concurrent/ScheduledExecutorService;
    .locals 2

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/b;

    sget-object v1, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->d:Lcom/aliyun/emas/apm/components/Lazy;

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Lazy;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/concurrent/ScheduledExecutorService;

    invoke-direct {v0, p0, v1}, Lcom/aliyun/emas/apm/concurrent/b;-><init>(Ljava/util/concurrent/ExecutorService;Ljava/util/concurrent/ScheduledExecutorService;)V

    return-object v0
.end method

.method private static a(Ljava/lang/String;I)Ljava/util/concurrent/ThreadFactory;
    .locals 2

    .line 3
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, p1, v1}, Lcom/aliyun/emas/apm/concurrent/a;-><init>(Ljava/lang/String;ILandroid/os/StrictMode$ThreadPolicy;)V

    return-object v0
.end method

.method private static a(Ljava/lang/String;ILandroid/os/StrictMode$ThreadPolicy;)Ljava/util/concurrent/ThreadFactory;
    .locals 1

    .line 4
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/a;

    invoke-direct {v0, p0, p1, p2}, Lcom/aliyun/emas/apm/concurrent/a;-><init>(Ljava/lang/String;ILandroid/os/StrictMode$ThreadPolicy;)V

    return-object v0
.end method

.method private static synthetic b()Ljava/util/concurrent/ScheduledExecutorService;
    .locals 3

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->a()Landroid/os/StrictMode$ThreadPolicy;

    move-result-object v0

    const-string v1, "Apm Background"

    const/16 v2, 0xa

    .line 2
    invoke-static {v1, v2, v0}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->a(Ljava/lang/String;ILandroid/os/StrictMode$ThreadPolicy;)Ljava/util/concurrent/ThreadFactory;

    move-result-object v0

    const/4 v1, 0x4

    .line 3
    invoke-static {v1, v0}, Ljava/util/concurrent/Executors;->newFixedThreadPool(ILjava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    .line 4
    invoke-static {v0}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->a(Ljava/util/concurrent/ExecutorService;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    return-object v0
.end method

.method private static synthetic b(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/ScheduledExecutorService;
    .locals 0

    sget-object p0, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->c:Lcom/aliyun/emas/apm/components/Lazy;

    .line 5
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/Lazy;->get()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/util/concurrent/ScheduledExecutorService;

    return-object p0
.end method

.method private static synthetic c()Ljava/util/concurrent/ScheduledExecutorService;
    .locals 4

    .line 1
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Runtime;->availableProcessors()I

    move-result v0

    const/4 v1, 0x2

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 2
    invoke-static {}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->f()Landroid/os/StrictMode$ThreadPolicy;

    move-result-object v1

    const-string v2, "Apm Lite"

    const/4 v3, 0x0

    invoke-static {v2, v3, v1}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->a(Ljava/lang/String;ILandroid/os/StrictMode$ThreadPolicy;)Ljava/util/concurrent/ThreadFactory;

    move-result-object v1

    .line 3
    invoke-static {v0, v1}, Ljava/util/concurrent/Executors;->newFixedThreadPool(ILjava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    .line 4
    invoke-static {v0}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->a(Ljava/util/concurrent/ExecutorService;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    return-object v0
.end method

.method private static synthetic c(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/ScheduledExecutorService;
    .locals 0

    sget-object p0, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->b:Lcom/aliyun/emas/apm/components/Lazy;

    .line 5
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/Lazy;->get()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/util/concurrent/ScheduledExecutorService;

    return-object p0
.end method

.method private static synthetic d(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/util/concurrent/Executor;
    .locals 0

    .line 4
    sget-object p0, Lcom/aliyun/emas/apm/j;->a:Lcom/aliyun/emas/apm/j;

    return-object p0
.end method

.method private static synthetic d()Ljava/util/concurrent/ScheduledExecutorService;
    .locals 2

    const-string v0, "Apm Blocking"

    const/16 v1, 0xb

    .line 1
    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->a(Ljava/lang/String;I)Ljava/util/concurrent/ThreadFactory;

    move-result-object v0

    .line 2
    invoke-static {v0}, Ljava/util/concurrent/Executors;->newCachedThreadPool(Ljava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    .line 3
    invoke-static {v0}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->a(Ljava/util/concurrent/ExecutorService;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    return-object v0
.end method

.method private static synthetic e()Ljava/util/concurrent/ScheduledExecutorService;
    .locals 2

    const-string v0, "Apm Scheduler"

    const/4 v1, 0x0

    .line 1
    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->a(Ljava/lang/String;I)Ljava/util/concurrent/ThreadFactory;

    move-result-object v0

    .line 2
    invoke-static {v0}, Ljava/util/concurrent/Executors;->newSingleThreadScheduledExecutor(Ljava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    return-object v0
.end method

.method private static f()Landroid/os/StrictMode$ThreadPolicy;
    .locals 1

    .line 1
    new-instance v0, Landroid/os/StrictMode$ThreadPolicy$Builder;

    invoke-direct {v0}, Landroid/os/StrictMode$ThreadPolicy$Builder;-><init>()V

    invoke-virtual {v0}, Landroid/os/StrictMode$ThreadPolicy$Builder;->detectAll()Landroid/os/StrictMode$ThreadPolicy$Builder;

    move-result-object v0

    .line 5
    invoke-virtual {v0}, Landroid/os/StrictMode$ThreadPolicy$Builder;->penaltyLog()Landroid/os/StrictMode$ThreadPolicy$Builder;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/StrictMode$ThreadPolicy$Builder;->build()Landroid/os/StrictMode$ThreadPolicy;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public getComponents()Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/components/Component<",
            "*>;>;"
        }
    .end annotation

    const/4 v0, 0x4

    new-array v0, v0, [Lcom/aliyun/emas/apm/components/Component;

    .line 3
    const-class v1, Lcom/aliyun/emas/apm/annotations/concurrent/Background;

    const-class v2, Ljava/util/concurrent/ScheduledExecutorService;

    invoke-static {v1, v2}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v1

    const/4 v2, 0x2

    new-array v3, v2, [Lcom/aliyun/emas/apm/components/Qualified;

    .line 4
    const-class v4, Lcom/aliyun/emas/apm/annotations/concurrent/Background;

    const-class v5, Ljava/util/concurrent/ExecutorService;

    invoke-static {v4, v5}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v4

    const/4 v5, 0x0

    aput-object v4, v3, v5

    .line 5
    const-class v4, Lcom/aliyun/emas/apm/annotations/concurrent/Background;

    const-class v6, Ljava/util/concurrent/Executor;

    invoke-static {v4, v6}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v4

    const/4 v6, 0x1

    aput-object v4, v3, v6

    .line 6
    invoke-static {v1, v3}, Lcom/aliyun/emas/apm/components/Component;->builder(Lcom/aliyun/emas/apm/components/Qualified;[Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    new-instance v3, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda0;

    invoke-direct {v3}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda0;-><init>()V

    .line 10
    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 11
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    aput-object v1, v0, v5

    .line 13
    const-class v1, Lcom/aliyun/emas/apm/annotations/concurrent/Blocking;

    const-class v3, Ljava/util/concurrent/ScheduledExecutorService;

    invoke-static {v1, v3}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v1

    new-array v3, v2, [Lcom/aliyun/emas/apm/components/Qualified;

    .line 14
    const-class v4, Lcom/aliyun/emas/apm/annotations/concurrent/Blocking;

    const-class v7, Ljava/util/concurrent/ExecutorService;

    invoke-static {v4, v7}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v4

    aput-object v4, v3, v5

    .line 15
    const-class v4, Lcom/aliyun/emas/apm/annotations/concurrent/Blocking;

    const-class v7, Ljava/util/concurrent/Executor;

    invoke-static {v4, v7}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v4

    aput-object v4, v3, v6

    .line 16
    invoke-static {v1, v3}, Lcom/aliyun/emas/apm/components/Component;->builder(Lcom/aliyun/emas/apm/components/Qualified;[Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    new-instance v3, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda1;

    invoke-direct {v3}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda1;-><init>()V

    .line 20
    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 21
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    aput-object v1, v0, v6

    .line 23
    const-class v1, Lcom/aliyun/emas/apm/annotations/concurrent/Lightweight;

    const-class v3, Ljava/util/concurrent/ScheduledExecutorService;

    invoke-static {v1, v3}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v1

    new-array v3, v2, [Lcom/aliyun/emas/apm/components/Qualified;

    .line 24
    const-class v4, Lcom/aliyun/emas/apm/annotations/concurrent/Lightweight;

    const-class v7, Ljava/util/concurrent/ExecutorService;

    invoke-static {v4, v7}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v4

    aput-object v4, v3, v5

    .line 25
    const-class v4, Lcom/aliyun/emas/apm/annotations/concurrent/Lightweight;

    const-class v5, Ljava/util/concurrent/Executor;

    invoke-static {v4, v5}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v4

    aput-object v4, v3, v6

    .line 26
    invoke-static {v1, v3}, Lcom/aliyun/emas/apm/components/Component;->builder(Lcom/aliyun/emas/apm/components/Qualified;[Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    new-instance v3, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda2;

    invoke-direct {v3}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda2;-><init>()V

    .line 30
    invoke-virtual {v1, v3}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 31
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    aput-object v1, v0, v2

    .line 32
    const-class v1, Lcom/aliyun/emas/apm/annotations/concurrent/UiThread;

    const-class v2, Ljava/util/concurrent/Executor;

    invoke-static {v1, v2}, Lcom/aliyun/emas/apm/components/Qualified;->qualified(Ljava/lang/Class;Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v1

    invoke-static {v1}, Lcom/aliyun/emas/apm/components/Component;->builder(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    new-instance v2, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda3;

    invoke-direct {v2}, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar$$ExternalSyntheticLambda3;-><init>()V

    .line 33
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/components/Component$Builder;->factory(Lcom/aliyun/emas/apm/components/ComponentFactory;)Lcom/aliyun/emas/apm/components/Component$Builder;

    move-result-object v1

    .line 34
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component$Builder;->build()Lcom/aliyun/emas/apm/components/Component;

    move-result-object v1

    const/4 v2, 0x3

    aput-object v1, v0, v2

    .line 35
    invoke-static {v0}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method
