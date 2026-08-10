.class public Lcom/aliyun/emas/apm/components/d;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/inject/Provider;
.implements Lcom/aliyun/emas/apm/inject/Deferred;


# static fields
.field public static final c:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

.field public static final d:Lcom/aliyun/emas/apm/inject/Provider;


# instance fields
.field public a:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

.field public volatile b:Lcom/aliyun/emas/apm/inject/Provider;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/d$$ExternalSyntheticLambda1;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/components/d$$ExternalSyntheticLambda1;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/components/d;->c:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/components/d$$ExternalSyntheticLambda2;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/components/d$$ExternalSyntheticLambda2;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/components/d;->d:Lcom/aliyun/emas/apm/inject/Provider;

    return-void
.end method

.method public constructor <init>(Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/d;->a:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

    iput-object p2, p0, Lcom/aliyun/emas/apm/components/d;->b:Lcom/aliyun/emas/apm/inject/Provider;

    return-void
.end method

.method public static a()Lcom/aliyun/emas/apm/components/d;
    .locals 3

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/components/d;

    sget-object v1, Lcom/aliyun/emas/apm/components/d;->c:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

    sget-object v2, Lcom/aliyun/emas/apm/components/d;->d:Lcom/aliyun/emas/apm/inject/Provider;

    invoke-direct {v0, v1, v2}, Lcom/aliyun/emas/apm/components/d;-><init>(Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;Lcom/aliyun/emas/apm/inject/Provider;)V

    return-object v0
.end method

.method public static synthetic a(Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 0

    .line 3
    invoke-interface {p0, p2}, Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;->handle(Lcom/aliyun/emas/apm/inject/Provider;)V

    .line 4
    invoke-interface {p1, p2}, Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;->handle(Lcom/aliyun/emas/apm/inject/Provider;)V

    return-void
.end method

.method public static synthetic a(Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 0

    return-void
.end method

.method public static b(Lcom/aliyun/emas/apm/inject/Provider;)Lcom/aliyun/emas/apm/components/d;
    .locals 2

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/components/d;

    const/4 v1, 0x0

    invoke-direct {v0, v1, p0}, Lcom/aliyun/emas/apm/components/d;-><init>(Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;Lcom/aliyun/emas/apm/inject/Provider;)V

    return-object v0
.end method

.method public static synthetic b()Ljava/lang/Object;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method


# virtual methods
.method public c(Lcom/aliyun/emas/apm/inject/Provider;)V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/d;->b:Lcom/aliyun/emas/apm/inject/Provider;

    sget-object v1, Lcom/aliyun/emas/apm/components/d;->d:Lcom/aliyun/emas/apm/inject/Provider;

    if-ne v0, v1, :cond_0

    .line 5
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/components/d;->a:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/aliyun/emas/apm/components/d;->a:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/d;->b:Lcom/aliyun/emas/apm/inject/Provider;

    .line 9
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 10
    invoke-interface {v0, p1}, Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;->handle(Lcom/aliyun/emas/apm/inject/Provider;)V

    return-void

    :catchall_0
    move-exception p1

    .line 11
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1

    .line 12
    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "provide() can be called only once."

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public get()Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/d;->b:Lcom/aliyun/emas/apm/inject/Provider;

    .line 1
    invoke-interface {v0}, Lcom/aliyun/emas/apm/inject/Provider;->get()Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public whenAvailable(Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;)V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/d;->b:Lcom/aliyun/emas/apm/inject/Provider;

    sget-object v1, Lcom/aliyun/emas/apm/components/d;->d:Lcom/aliyun/emas/apm/inject/Provider;

    if-eq v0, v1, :cond_0

    .line 3
    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;->handle(Lcom/aliyun/emas/apm/inject/Provider;)V

    return-void

    .line 7
    :cond_0
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/components/d;->b:Lcom/aliyun/emas/apm/inject/Provider;

    if-eq v0, v1, :cond_1

    move-object v1, v0

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lcom/aliyun/emas/apm/components/d;->a:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

    .line 13
    new-instance v2, Lcom/aliyun/emas/apm/components/d$$ExternalSyntheticLambda0;

    invoke-direct {v2, v1, p1}, Lcom/aliyun/emas/apm/components/d$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;)V

    iput-object v2, p0, Lcom/aliyun/emas/apm/components/d;->a:Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;

    const/4 v1, 0x0

    .line 19
    :goto_0
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v1, :cond_2

    .line 21
    invoke-interface {p1, v0}, Lcom/aliyun/emas/apm/inject/Deferred$DeferredHandler;->handle(Lcom/aliyun/emas/apm/inject/Provider;)V

    :cond_2
    return-void

    :catchall_0
    move-exception p1

    .line 22
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method
