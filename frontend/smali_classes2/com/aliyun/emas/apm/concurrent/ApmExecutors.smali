.class public Lcom/aliyun/emas/apm/concurrent/ApmExecutors;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/concurrent/ApmExecutors$a;
    }
.end annotation


# direct methods
.method public static directExecutor()Ljava/util/concurrent/Executor;
    .locals 1

    .line 1
    sget-object v0, Lcom/aliyun/emas/apm/concurrent/ApmExecutors$a;->a:Lcom/aliyun/emas/apm/concurrent/ApmExecutors$a;

    return-object v0
.end method

.method public static newLimitedConcurrencyExecutor(Ljava/util/concurrent/Executor;I)Ljava/util/concurrent/Executor;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/d;

    invoke-direct {v0, p0, p1}, Lcom/aliyun/emas/apm/concurrent/d;-><init>(Ljava/util/concurrent/Executor;I)V

    return-object v0
.end method

.method public static newLimitedConcurrencyExecutorService(Ljava/util/concurrent/ExecutorService;I)Ljava/util/concurrent/ExecutorService;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/e;

    invoke-direct {v0, p0, p1}, Lcom/aliyun/emas/apm/concurrent/e;-><init>(Ljava/util/concurrent/ExecutorService;I)V

    return-object v0
.end method

.method public static newLimitedConcurrencyScheduledExecutorService(Ljava/util/concurrent/ExecutorService;I)Ljava/util/concurrent/ScheduledExecutorService;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/b;

    .line 2
    invoke-static {p0, p1}, Lcom/aliyun/emas/apm/concurrent/ApmExecutors;->newLimitedConcurrencyExecutorService(Ljava/util/concurrent/ExecutorService;I)Ljava/util/concurrent/ExecutorService;

    move-result-object p0

    sget-object p1, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->d:Lcom/aliyun/emas/apm/components/Lazy;

    .line 3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/components/Lazy;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/concurrent/ScheduledExecutorService;

    invoke-direct {v0, p0, p1}, Lcom/aliyun/emas/apm/concurrent/b;-><init>(Ljava/util/concurrent/ExecutorService;Ljava/util/concurrent/ScheduledExecutorService;)V

    return-object v0
.end method

.method public static newPausableExecutor(Ljava/util/concurrent/Executor;)Lcom/aliyun/emas/apm/g;
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/f;

    const/4 v1, 0x0

    invoke-direct {v0, v1, p0}, Lcom/aliyun/emas/apm/concurrent/f;-><init>(ZLjava/util/concurrent/Executor;)V

    return-object v0
.end method

.method public static newPausableExecutorService(Ljava/util/concurrent/ExecutorService;)Lcom/aliyun/emas/apm/h;
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/g;

    const/4 v1, 0x0

    invoke-direct {v0, v1, p0}, Lcom/aliyun/emas/apm/concurrent/g;-><init>(ZLjava/util/concurrent/ExecutorService;)V

    return-object v0
.end method

.method public static newPausableScheduledExecutorService(Ljava/util/concurrent/ScheduledExecutorService;)Lcom/aliyun/emas/apm/i;
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/h;

    .line 2
    invoke-static {p0}, Lcom/aliyun/emas/apm/concurrent/ApmExecutors;->newPausableExecutorService(Ljava/util/concurrent/ExecutorService;)Lcom/aliyun/emas/apm/h;

    move-result-object p0

    sget-object v1, Lcom/aliyun/emas/apm/concurrent/ExecutorsRegistrar;->d:Lcom/aliyun/emas/apm/components/Lazy;

    invoke-virtual {v1}, Lcom/aliyun/emas/apm/components/Lazy;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/concurrent/ScheduledExecutorService;

    invoke-direct {v0, p0, v1}, Lcom/aliyun/emas/apm/concurrent/h;-><init>(Lcom/aliyun/emas/apm/h;Ljava/util/concurrent/ScheduledExecutorService;)V

    return-object v0
.end method

.method public static newSequentialExecutor(Ljava/util/concurrent/Executor;)Ljava/util/concurrent/Executor;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/i;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/concurrent/i;-><init>(Ljava/util/concurrent/Executor;)V

    return-object v0
.end method
