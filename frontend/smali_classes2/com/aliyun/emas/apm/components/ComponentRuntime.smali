.class public Lcom/aliyun/emas/apm/components/ComponentRuntime;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/components/ComponentContainer;
.implements Lcom/aliyun/emas/apm/dynamicloading/ComponentLoader;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;
    }
.end annotation


# static fields
.field public static final i:Lcom/aliyun/emas/apm/inject/Provider;


# instance fields
.field public final a:Ljava/util/Map;

.field public final b:Ljava/util/Map;

.field public final c:Ljava/util/Map;

.field public final d:Ljava/util/List;

.field public e:Ljava/util/Set;

.field public final f:Lcom/aliyun/emas/apm/components/b;

.field public final g:Ljava/util/concurrent/atomic/AtomicReference;

.field public final h:Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;


# direct methods
.method public static synthetic $r8$lambda$5zxwieS2X75xZTkM3ycZ1uUMnwI()Ljava/util/Set;
    .locals 1

    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda2;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda2;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->i:Lcom/aliyun/emas/apm/inject/Provider;

    return-void
.end method

.method public constructor <init>(Ljava/util/concurrent/Executor;Ljava/lang/Iterable;Ljava/util/Collection;Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;)V
    .locals 4

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 6
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a:Ljava/util/Map;

    .line 7
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->b:Ljava/util/Map;

    .line 8
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->c:Ljava/util/Map;

    .line 10
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->e:Ljava/util/Set;

    .line 12
    new-instance v0, Ljava/util/concurrent/atomic/AtomicReference;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->g:Ljava/util/concurrent/atomic/AtomicReference;

    .line 43
    new-instance v0, Lcom/aliyun/emas/apm/components/b;

    invoke-direct {v0, p1}, Lcom/aliyun/emas/apm/components/b;-><init>(Ljava/util/concurrent/Executor;)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->f:Lcom/aliyun/emas/apm/components/b;

    iput-object p4, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->h:Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;

    .line 46
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    const/4 p4, 0x2

    new-array p4, p4, [Ljava/lang/Class;

    .line 48
    const-class v1, Lcom/aliyun/emas/apm/events/Subscriber;

    const/4 v2, 0x0

    aput-object v1, p4, v2

    const/4 v1, 0x1

    const-class v3, Lcom/aliyun/emas/apm/events/Publisher;

    aput-object v3, p4, v1

    const-class v1, Lcom/aliyun/emas/apm/components/b;

    invoke-static {v0, v1, p4}, Lcom/aliyun/emas/apm/components/Component;->of(Ljava/lang/Object;Ljava/lang/Class;[Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object p4

    invoke-interface {p1, p4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-array p4, v2, [Ljava/lang/Class;

    .line 49
    const-class v0, Lcom/aliyun/emas/apm/dynamicloading/ComponentLoader;

    invoke-static {p0, v0, p4}, Lcom/aliyun/emas/apm/components/Component;->of(Ljava/lang/Object;Ljava/lang/Class;[Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Component;

    move-result-object p4

    invoke-interface {p1, p4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 50
    invoke-interface {p3}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object p3

    :cond_0
    :goto_0
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result p4

    if-eqz p4, :cond_1

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Lcom/aliyun/emas/apm/components/Component;

    if-eqz p4, :cond_0

    .line 52
    invoke-interface {p1, p4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 56
    :cond_1
    invoke-static {p2}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object p2

    iput-object p2, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->d:Ljava/util/List;

    .line 58
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a(Ljava/util/List;)V

    return-void
.end method

.method public synthetic constructor <init>(Ljava/util/concurrent/Executor;Ljava/lang/Iterable;Ljava/util/Collection;Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;Lcom/aliyun/emas/apm/components/ComponentRuntime$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/aliyun/emas/apm/components/ComponentRuntime;-><init>(Ljava/util/concurrent/Executor;Ljava/lang/Iterable;Ljava/util/Collection;Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;)V

    return-void
.end method

.method public varargs constructor <init>(Ljava/util/concurrent/Executor;Ljava/lang/Iterable;[Lcom/aliyun/emas/apm/components/Component;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/concurrent/Executor;",
            "Ljava/lang/Iterable<",
            "Lcom/aliyun/emas/apm/components/ComponentRegistrar;",
            ">;[",
            "Lcom/aliyun/emas/apm/components/Component<",
            "*>;)V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 2
    invoke-static {p2}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->b(Ljava/lang/Iterable;)Ljava/lang/Iterable;

    move-result-object p2

    .line 3
    invoke-static {p3}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object p3

    sget-object v0, Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;->NOOP:Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;

    .line 4
    invoke-direct {p0, p1, p2, p3, v0}, Lcom/aliyun/emas/apm/components/ComponentRuntime;-><init>(Ljava/util/concurrent/Executor;Ljava/lang/Iterable;Ljava/util/Collection;Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;)V

    return-void
.end method

.method public static synthetic a(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)Lcom/aliyun/emas/apm/components/ComponentRegistrar;
    .locals 0

    return-object p0
.end method

.method public static a(Ljava/lang/Iterable;)Ljava/util/List;
    .locals 2

    .line 71
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 72
    invoke-interface {p0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    .line 73
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method public static synthetic a(Lcom/aliyun/emas/apm/components/c;Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 0

    .line 75
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/components/c;->a(Lcom/aliyun/emas/apm/inject/Provider;)V

    return-void
.end method

.method public static synthetic a(Lcom/aliyun/emas/apm/components/d;Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 0

    .line 74
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/components/d;->c(Lcom/aliyun/emas/apm/inject/Provider;)V

    return-void
.end method

.method public static b(Ljava/lang/Iterable;)Ljava/lang/Iterable;
    .locals 3

    .line 1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 2
    invoke-interface {p0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/components/ComponentRegistrar;

    .line 3
    new-instance v2, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda0;

    invoke-direct {v2, v1}, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    return-object v0
.end method

.method public static builder(Ljava/util/concurrent/Executor;)Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/components/ComponentRuntime$Builder;-><init>(Ljava/util/concurrent/Executor;)V

    return-object v0
.end method


# virtual methods
.method public final synthetic a(Lcom/aliyun/emas/apm/components/Component;)Ljava/lang/Object;
    .locals 2

    .line 66
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/components/Component;->getFactory()Lcom/aliyun/emas/apm/components/ComponentFactory;

    move-result-object v0

    new-instance v1, Lcom/aliyun/emas/apm/components/e;

    invoke-direct {v1, p1, p0}, Lcom/aliyun/emas/apm/components/e;-><init>(Lcom/aliyun/emas/apm/components/Component;Lcom/aliyun/emas/apm/components/ComponentContainer;)V

    .line 67
    invoke-interface {v0, v1}, Lcom/aliyun/emas/apm/components/ComponentFactory;->create(Lcom/aliyun/emas/apm/components/ComponentContainer;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final a()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->g:Ljava/util/concurrent/atomic/AtomicReference;

    .line 68
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a:Ljava/util/Map;

    .line 70
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-virtual {p0, v1, v0}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a(Ljava/util/Map;Z)V

    :cond_0
    return-void
.end method

.method public final a(Ljava/util/List;)V
    .locals 8

    .line 2
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 3
    monitor-enter p0

    :try_start_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->d:Ljava/util/List;

    .line 4
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .line 5
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 6
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/inject/Provider;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 8
    :try_start_1
    invoke-interface {v2}, Lcom/aliyun/emas/apm/inject/Provider;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/components/ComponentRegistrar;

    if-eqz v2, :cond_0

    iget-object v3, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->h:Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;

    .line 10
    invoke-interface {v3, v2}, Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;->processRegistrar(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)Ljava/util/List;

    move-result-object v2

    invoke-interface {p1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 11
    invoke-interface {v1}, Ljava/util/Iterator;->remove()V
    :try_end_1
    .catch Lcom/aliyun/emas/apm/components/InvalidRegistrarException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catch_0
    move-exception v2

    .line 14
    :try_start_2
    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    const-string v3, "ComponentDiscovery"

    const-string v4, "Invalid component registrar."

    .line 15
    invoke-static {v3, v4, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 23
    :cond_1
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .line 24
    :cond_2
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 25
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/components/Component;

    .line 26
    invoke-virtual {v2}, Lcom/aliyun/emas/apm/components/Component;->getProvidedInterfaces()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->toArray()[Ljava/lang/Object;

    move-result-object v2

    array-length v3, v2

    const/4 v4, 0x0

    :goto_2
    if-ge v4, v3, :cond_2

    aget-object v5, v2, v4

    .line 27
    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v6

    const-string v7, "kotlinx.coroutines.CoroutineDispatcher"

    invoke-virtual {v6, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_4

    iget-object v6, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->e:Ljava/util/Set;

    .line 28
    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v6, v7}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 29
    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    goto :goto_1

    :cond_3
    iget-object v6, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->e:Ljava/util/Set;

    .line 32
    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-interface {v6, v5}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    :cond_5
    iget-object v1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a:Ljava/util/Map;

    .line 38
    invoke-interface {v1}, Ljava/util/Map;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_6

    .line 39
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/a;->a(Ljava/util/List;)V

    goto :goto_3

    .line 41
    :cond_6
    new-instance v1, Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a:Ljava/util/Map;

    invoke-interface {v2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    .line 42
    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 43
    invoke-static {v1}, Lcom/aliyun/emas/apm/components/a;->a(Ljava/util/List;)V

    .line 46
    :goto_3
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_4
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_7

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/components/Component;

    .line 47
    new-instance v3, Lcom/aliyun/emas/apm/components/Lazy;

    new-instance v4, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda1;

    invoke-direct {v4, p0, v2}, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda1;-><init>(Lcom/aliyun/emas/apm/components/ComponentRuntime;Lcom/aliyun/emas/apm/components/Component;)V

    invoke-direct {v3, v4}, Lcom/aliyun/emas/apm/components/Lazy;-><init>(Lcom/aliyun/emas/apm/inject/Provider;)V

    iget-object v4, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a:Ljava/util/Map;

    .line 54
    invoke-interface {v4, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_4

    .line 57
    :cond_7
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->b(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 58
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->c()Ljava/util/List;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 59
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->b()V

    .line 60
    monitor-exit p0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 61
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_5
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_8

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Runnable;

    .line 62
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    goto :goto_5

    .line 64
    :cond_8
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a()V

    return-void

    :catchall_0
    move-exception p1

    .line 65
    :try_start_3
    monitor-exit p0
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    throw p1
.end method

.method public final a(Ljava/util/Map;Z)V
    .locals 3

    .line 76
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

    .line 77
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/components/Component;

    .line 78
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/inject/Provider;

    .line 80
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component;->isAlwaysEager()Z

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component;->isEagerInDefaultApp()Z

    move-result v1

    if-eqz v1, :cond_0

    if-eqz p2, :cond_0

    .line 81
    :cond_1
    invoke-interface {v0}, Lcom/aliyun/emas/apm/inject/Provider;->get()Ljava/lang/Object;

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->f:Lcom/aliyun/emas/apm/components/b;

    .line 85
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/components/b;->a()V

    return-void
.end method

.method public final b(Ljava/util/List;)Ljava/util/List;
    .locals 5

    .line 4
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 5
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/components/Component;

    .line 6
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component;->isValue()Z

    move-result v2

    if-nez v2, :cond_1

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a:Ljava/util/Map;

    .line 10
    invoke-interface {v2, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/inject/Provider;

    .line 11
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component;->getProvidedInterfaces()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/aliyun/emas/apm/components/Qualified;

    iget-object v4, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->b:Ljava/util/Map;

    .line 12
    invoke-interface {v4, v3}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    iget-object v4, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->b:Ljava/util/Map;

    .line 13
    invoke-interface {v4, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_2
    iget-object v4, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->b:Ljava/util/Map;

    .line 15
    invoke-interface {v4, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/aliyun/emas/apm/inject/Provider;

    .line 17
    check-cast v3, Lcom/aliyun/emas/apm/components/d;

    .line 20
    new-instance v4, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda4;

    invoke-direct {v4, v3, v2}, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda4;-><init>(Lcom/aliyun/emas/apm/components/d;Lcom/aliyun/emas/apm/inject/Provider;)V

    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_3
    return-object v0
.end method

.method public final b()V
    .locals 6

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a:Ljava/util/Map;

    .line 21
    invoke-interface {v0}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/components/Component;

    .line 22
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Component;->getDependencies()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/aliyun/emas/apm/components/Dependency;

    .line 23
    invoke-virtual {v3}, Lcom/aliyun/emas/apm/components/Dependency;->isSet()Z

    move-result v4

    if-eqz v4, :cond_2

    iget-object v4, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->c:Ljava/util/Map;

    invoke-virtual {v3}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_2

    iget-object v4, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->c:Ljava/util/Map;

    .line 24
    invoke-virtual {v3}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v3

    invoke-static {}, Ljava/util/Collections;->emptySet()Ljava/util/Set;

    move-result-object v5

    invoke-static {v5}, Lcom/aliyun/emas/apm/components/c;->a(Ljava/util/Collection;)Lcom/aliyun/emas/apm/components/c;

    move-result-object v5

    invoke-interface {v4, v3, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_2
    iget-object v4, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->b:Ljava/util/Map;

    .line 25
    invoke-virtual {v3}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 26
    invoke-virtual {v3}, Lcom/aliyun/emas/apm/components/Dependency;->isRequired()Z

    move-result v4

    if-nez v4, :cond_3

    .line 31
    invoke-virtual {v3}, Lcom/aliyun/emas/apm/components/Dependency;->isSet()Z

    move-result v4

    if-nez v4, :cond_1

    iget-object v4, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->b:Ljava/util/Map;

    .line 32
    invoke-virtual {v3}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v3

    invoke-static {}, Lcom/aliyun/emas/apm/components/d;->a()Lcom/aliyun/emas/apm/components/d;

    move-result-object v5

    invoke-interface {v4, v3, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    .line 33
    :cond_3
    new-instance v0, Lcom/aliyun/emas/apm/components/MissingDependencyException;

    .line 36
    invoke-virtual {v3}, Lcom/aliyun/emas/apm/components/Dependency;->getInterface()Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object v2

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "Unsatisfied dependency for component %s: %s"

    .line 37
    invoke-static {v2, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/aliyun/emas/apm/components/MissingDependencyException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_4
    return-void
.end method

.method public final c()Ljava/util/List;
    .locals 7

    .line 1
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 2
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iget-object v2, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a:Ljava/util/Map;

    .line 3
    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .line 4
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/aliyun/emas/apm/components/Component;

    .line 7
    invoke-virtual {v4}, Lcom/aliyun/emas/apm/components/Component;->isValue()Z

    move-result v5

    if-eqz v5, :cond_1

    goto :goto_0

    .line 11
    :cond_1
    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/aliyun/emas/apm/inject/Provider;

    .line 13
    invoke-virtual {v4}, Lcom/aliyun/emas/apm/components/Component;->getProvidedInterfaces()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_0

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/aliyun/emas/apm/components/Qualified;

    .line 14
    invoke-interface {v1, v5}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_2

    .line 15
    new-instance v6, Ljava/util/HashSet;

    invoke-direct {v6}, Ljava/util/HashSet;-><init>()V

    invoke-interface {v1, v5, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 17
    :cond_2
    invoke-interface {v1, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Set;

    invoke-interface {v5, v3}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 21
    :cond_3
    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_4
    :goto_2
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_6

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    iget-object v3, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->c:Ljava/util/Map;

    .line 22
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_5

    iget-object v3, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->c:Ljava/util/Map;

    .line 23
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/aliyun/emas/apm/components/Qualified;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Collection;

    invoke-static {v2}, Lcom/aliyun/emas/apm/components/c;->a(Ljava/util/Collection;)Lcom/aliyun/emas/apm/components/c;

    move-result-object v2

    invoke-interface {v3, v4, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    :cond_5
    iget-object v3, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->c:Ljava/util/Map;

    .line 26
    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/aliyun/emas/apm/components/c;

    .line 27
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Set;

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_3
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/aliyun/emas/apm/inject/Provider;

    .line 30
    new-instance v5, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda3;

    invoke-direct {v5, v3, v4}, Lcom/aliyun/emas/apm/components/ComponentRuntime$$ExternalSyntheticLambda3;-><init>(Lcom/aliyun/emas/apm/components/c;Lcom/aliyun/emas/apm/inject/Provider;)V

    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_3

    :cond_6
    return-object v0
.end method

.method public discoverComponents()V
    .locals 1

    .line 1
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->d:Ljava/util/List;

    .line 2
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 3
    monitor-exit p0

    return-void

    .line 5
    :cond_0
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 6
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {p0, v0}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a(Ljava/util/List;)V

    return-void

    :catchall_0
    move-exception v0

    .line 7
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method public getDeferred(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Deferred;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/inject/Deferred<",
            "TT;>;"
        }
    .end annotation

    .line 1
    invoke-virtual {p0, p1}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->getProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;

    move-result-object p1

    if-nez p1, :cond_0

    .line 3
    invoke-static {}, Lcom/aliyun/emas/apm/components/d;->a()Lcom/aliyun/emas/apm/components/d;

    move-result-object p1

    return-object p1

    .line 5
    :cond_0
    instance-of v0, p1, Lcom/aliyun/emas/apm/components/d;

    if-eqz v0, :cond_1

    .line 6
    check-cast p1, Lcom/aliyun/emas/apm/components/d;

    return-object p1

    .line 8
    :cond_1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/d;->b(Lcom/aliyun/emas/apm/inject/Provider;)Lcom/aliyun/emas/apm/components/d;

    move-result-object p1

    return-object p1
.end method

.method public declared-synchronized getProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/inject/Provider<",
            "TT;>;"
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    const-string v0, "Null interface requested."

    .line 1
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/components/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->b:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/inject/Provider;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object p1

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public initializeAllComponentsForTests()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/inject/Provider;

    .line 2
    invoke-interface {v1}, Lcom/aliyun/emas/apm/inject/Provider;->get()Ljava/lang/Object;

    goto :goto_0

    :cond_0
    return-void
.end method

.method public initializeEagerComponents(Z)V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->g:Ljava/util/concurrent/atomic/AtomicReference;

    .line 1
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1}, Landroidx/camera/view/PreviewView$1$$ExternalSyntheticBackportWithForwarding0;->m(Ljava/util/concurrent/atomic/AtomicReference;Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 9
    :cond_0
    monitor-enter p0

    .line 10
    :try_start_0
    new-instance v0, Ljava/util/HashMap;

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a:Ljava/util/Map;

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(Ljava/util/Map;)V

    .line 11
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 12
    invoke-virtual {p0, v0, p1}, Lcom/aliyun/emas/apm/components/ComponentRuntime;->a(Ljava/util/Map;Z)V

    return-void

    :catchall_0
    move-exception p1

    .line 13
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public declared-synchronized setOfProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/inject/Provider;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "TT;>;)",
            "Lcom/aliyun/emas/apm/inject/Provider<",
            "Ljava/util/Set<",
            "TT;>;>;"
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/components/ComponentRuntime;->c:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/components/c;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz p1, :cond_0

    monitor-exit p0

    return-object p1

    :cond_0
    :try_start_1
    sget-object p1, Lcom/aliyun/emas/apm/components/ComponentRuntime;->i:Lcom/aliyun/emas/apm/inject/Provider;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 5
    monitor-exit p0

    return-object p1

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
