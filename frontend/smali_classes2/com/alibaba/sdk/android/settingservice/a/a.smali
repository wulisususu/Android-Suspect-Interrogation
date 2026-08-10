.class public Lcom/alibaba/sdk/android/settingservice/a/a;
.super Ljava/lang/Object;


# static fields
.field private static final f:Ljava/util/concurrent/ThreadPoolExecutor;


# instance fields
.field private final a:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Lcom/alibaba/sdk/android/settingservice/b/b;",
            ">;"
        }
    .end annotation
.end field

.field private final b:Lcom/alibaba/sdk/android/settingservice/c/a;

.field private final c:Lcom/alibaba/sdk/android/settingservice/c/c;

.field private d:Landroid/content/Context;

.field private final e:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 8

    new-instance v7, Ljava/util/concurrent/ThreadPoolExecutor;

    const/4 v1, 0x3

    const/4 v2, 0x3

    const-wide/16 v3, 0x3c

    sget-object v5, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v6, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v6}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;)V

    sput-object v7, Lcom/alibaba/sdk/android/settingservice/a/a;->f:Ljava/util/concurrent/ThreadPoolExecutor;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->e:Ljava/util/Set;

    new-instance v0, Lcom/alibaba/sdk/android/settingservice/c/a;

    invoke-direct {v0, p1, p2}, Lcom/alibaba/sdk/android/settingservice/c/a;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->b:Lcom/alibaba/sdk/android/settingservice/c/a;

    new-instance v0, Lcom/alibaba/sdk/android/settingservice/c/c;

    invoke-direct {v0, p1, p2}, Lcom/alibaba/sdk/android/settingservice/c/c;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->c:Lcom/alibaba/sdk/android/settingservice/c/c;

    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/settingservice/a/a;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->d:Landroid/content/Context;

    return-object p0
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/settingservice/a/a;Ljava/util/Map;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Ljava/util/Map;)V

    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/settingservice/a/a;Ljava/util/Set;Lcom/alibaba/sdk/android/settingservice/a/b;Z)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Ljava/util/Set;Lcom/alibaba/sdk/android/settingservice/a/b;Z)V

    return-void
.end method

.method private a(Ljava/util/Map;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/alibaba/sdk/android/settingservice/b/b;",
            ">;)V"
        }
    .end annotation

    if-eqz p1, :cond_3

    invoke-interface {p1}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_3

    monitor-enter p0

    :try_start_0
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/sdk/android/settingservice/b/b;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/settingservice/b/b;->b()I

    move-result v1

    const/4 v2, 0x2

    if-eq v1, v2, :cond_0

    :cond_1
    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {v1, v2, v0}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_2
    monitor-exit p0

    goto :goto_1

    :catchall_0
    move-exception p1

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_3
    :goto_1
    return-void
.end method

.method private a(Ljava/util/Set;Lcom/alibaba/sdk/android/settingservice/a/b;Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;",
            "Lcom/alibaba/sdk/android/settingservice/a/b;",
            "Z)V"
        }
    .end annotation

    invoke-interface {p1}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    new-instance v0, Lcom/alibaba/sdk/android/settingservice/a/a$2;

    invoke-direct {v0, p0, p1, p2}, Lcom/alibaba/sdk/android/settingservice/a/a$2;-><init>(Lcom/alibaba/sdk/android/settingservice/a/a;Ljava/util/Set;Lcom/alibaba/sdk/android/settingservice/a/b;)V

    if-eqz p3, :cond_0

    sget-object p1, Lcom/alibaba/sdk/android/settingservice/a/a;->f:Ljava/util/concurrent/ThreadPoolExecutor;

    invoke-virtual {p1, v0}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    goto :goto_0

    :cond_0
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    :cond_1
    :goto_0
    return-void
.end method

.method static synthetic b(Lcom/alibaba/sdk/android/settingservice/a/a;)Lcom/alibaba/sdk/android/settingservice/c/a;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->b:Lcom/alibaba/sdk/android/settingservice/c/a;

    return-object p0
.end method

.method static synthetic c(Lcom/alibaba/sdk/android/settingservice/a/a;)Ljava/util/concurrent/ConcurrentHashMap;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    return-object p0
.end method

.method static synthetic d(Lcom/alibaba/sdk/android/settingservice/a/a;)Ljava/util/Set;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->e:Ljava/util/Set;

    return-object p0
.end method

.method static synthetic e(Lcom/alibaba/sdk/android/settingservice/a/a;)Lcom/alibaba/sdk/android/settingservice/c/c;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->c:Lcom/alibaba/sdk/android/settingservice/c/c;

    return-object p0
.end method

.method private h(Ljava/lang/String;)Ljava/util/Set;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1}, Ljava/util/concurrent/ConcurrentHashMap;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    :cond_0
    return-object v0

    :cond_1
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1, p1}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    :cond_2
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-object p1, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {p1}, Ljava/util/concurrent/ConcurrentHashMap;->entrySet()Ljava/util/Set;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_3
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/alibaba/sdk/android/settingservice/b/b;

    iget-wide v5, v4, Lcom/alibaba/sdk/android/settingservice/b/b;->b:J

    const-wide/16 v7, 0x0

    cmp-long v5, v5, v7

    if-lez v5, :cond_3

    iget-wide v5, v4, Lcom/alibaba/sdk/android/settingservice/b/b;->d:J

    sub-long v5, v1, v5

    invoke-static {v5, v6}, Ljava/lang/Math;->abs(J)J

    move-result-wide v5

    iget-wide v7, v4, Lcom/alibaba/sdk/android/settingservice/b/b;->b:J

    cmp-long v4, v5, v7

    if-ltz v4, :cond_3

    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    invoke-interface {v0, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_4
    return-object v0
.end method


# virtual methods
.method public a(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/b/b;
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/alibaba/sdk/android/settingservice/b/b;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->b:Lcom/alibaba/sdk/android/settingservice/c/a;

    iget-object v1, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->d:Landroid/content/Context;

    filled-new-array {p1}, [Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/settingservice/c/a;->a(Landroid/content/Context;[Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Ljava/util/Map;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/alibaba/sdk/android/settingservice/b/b;

    return-object p1

    :cond_0
    return-object v0
.end method

.method public a()V
    .locals 2

    sget-object v0, Lcom/alibaba/sdk/android/settingservice/a/a;->f:Ljava/util/concurrent/ThreadPoolExecutor;

    new-instance v1, Lcom/alibaba/sdk/android/settingservice/a/a$1;

    invoke-direct {v1, p0}, Lcom/alibaba/sdk/android/settingservice/a/a$1;-><init>(Lcom/alibaba/sdk/android/settingservice/a/a;)V

    invoke-virtual {v0, v1}, Ljava/util/concurrent/ThreadPoolExecutor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method public a(Landroid/app/Application;)V
    .locals 0

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/app/Application;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    iput-object p1, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->d:Landroid/content/Context;

    :cond_0
    return-void
.end method

.method public a(Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->d:Landroid/content/Context;

    return-void
.end method

.method public a(Ljava/lang/String;Lcom/alibaba/sdk/android/settingservice/a/b;)V
    .locals 1

    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->h(Ljava/lang/String;)Ljava/util/Set;

    move-result-object p1

    const/4 v0, 0x1

    invoke-direct {p0, p1, p2, v0}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Ljava/util/Set;Lcom/alibaba/sdk/android/settingservice/a/b;Z)V

    return-void
.end method

.method public a(Z)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->c:Lcom/alibaba/sdk/android/settingservice/c/c;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/c/c;->a(Z)V

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->a:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->e:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 2

    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->h(Ljava/lang/String;)Ljava/util/Set;

    move-result-object p1

    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-direct {p0, p1, v0, v1}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Ljava/util/Set;Lcom/alibaba/sdk/android/settingservice/a/b;Z)V

    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 2

    invoke-direct {p0, p1}, Lcom/alibaba/sdk/android/settingservice/a/a;->h(Ljava/lang/String;)Ljava/util/Set;

    move-result-object p1

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1}, Lcom/alibaba/sdk/android/settingservice/a/a;->a(Ljava/util/Set;Lcom/alibaba/sdk/android/settingservice/a/b;Z)V

    return-void
.end method

.method public e(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->b:Lcom/alibaba/sdk/android/settingservice/c/a;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/c/a;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->c:Lcom/alibaba/sdk/android/settingservice/c/c;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/c/c;->a(Ljava/lang/String;)V

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->c:Lcom/alibaba/sdk/android/settingservice/c/c;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/c/c;->b(Ljava/lang/String;)V

    return-void
.end method

.method public g(Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/a/a;->c:Lcom/alibaba/sdk/android/settingservice/c/c;

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/c/c;->c(Ljava/lang/String;)V

    return-void
.end method
