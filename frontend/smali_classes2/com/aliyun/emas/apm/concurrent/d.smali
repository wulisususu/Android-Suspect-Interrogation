.class Lcom/aliyun/emas/apm/concurrent/d;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Executor;


# instance fields
.field private final a:Ljava/util/concurrent/Executor;

.field private final b:Ljava/util/concurrent/Semaphore;

.field private final c:Ljava/util/concurrent/LinkedBlockingQueue;


# direct methods
.method public static synthetic $r8$lambda$ZfmIBTWmKROWYF5M1C-omI62WVQ(Lcom/aliyun/emas/apm/concurrent/d;Ljava/lang/Runnable;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/concurrent/d;->b(Ljava/lang/Runnable;)V

    return-void
.end method

.method constructor <init>(Ljava/util/concurrent/Executor;I)V
    .locals 3

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v0}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/concurrent/d;->c:Ljava/util/concurrent/LinkedBlockingQueue;

    const/4 v0, 0x1

    if-lez p2, :cond_0

    move v1, v0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    const-string v2, "concurrency must be positive."

    .line 5
    invoke-static {v1, v2}, Lcom/aliyun/emas/apm/components/Preconditions;->checkArgument(ZLjava/lang/String;)V

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/d;->a:Ljava/util/concurrent/Executor;

    .line 7
    new-instance p1, Ljava/util/concurrent/Semaphore;

    invoke-direct {p1, p2, v0}, Ljava/util/concurrent/Semaphore;-><init>(IZ)V

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/d;->b:Ljava/util/concurrent/Semaphore;

    return-void
.end method

.method private a(Ljava/lang/Runnable;)Ljava/lang/Runnable;
    .locals 1

    .line 7
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/d$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0, p1}, Lcom/aliyun/emas/apm/concurrent/d$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/concurrent/d;Ljava/lang/Runnable;)V

    return-object v0
.end method

.method private a()V
    .locals 2

    :goto_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/d;->b:Ljava/util/concurrent/Semaphore;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->tryAcquire()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/d;->c:Ljava/util/concurrent/LinkedBlockingQueue;

    .line 2
    invoke-virtual {v0}, Ljava/util/concurrent/LinkedBlockingQueue;->poll()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/d;->a:Ljava/util/concurrent/Executor;

    .line 4
    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/concurrent/d;->a(Ljava/lang/Runnable;)Ljava/lang/Runnable;

    move-result-object v0

    invoke-interface {v1, v0}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/d;->b:Ljava/util/concurrent/Semaphore;

    .line 6
    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    :cond_1
    return-void
.end method

.method private synthetic b(Ljava/lang/Runnable;)V
    .locals 1

    .line 1
    :try_start_0
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p1, p0, Lcom/aliyun/emas/apm/concurrent/d;->b:Ljava/util/concurrent/Semaphore;

    .line 3
    invoke-virtual {p1}, Ljava/util/concurrent/Semaphore;->release()V

    .line 4
    invoke-direct {p0}, Lcom/aliyun/emas/apm/concurrent/d;->a()V

    return-void

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/d;->b:Ljava/util/concurrent/Semaphore;

    .line 5
    invoke-virtual {v0}, Ljava/util/concurrent/Semaphore;->release()V

    .line 6
    invoke-direct {p0}, Lcom/aliyun/emas/apm/concurrent/d;->a()V

    .line 7
    throw p1
.end method


# virtual methods
.method public execute(Ljava/lang/Runnable;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/d;->c:Ljava/util/concurrent/LinkedBlockingQueue;

    .line 1
    invoke-virtual {v0, p1}, Ljava/util/concurrent/LinkedBlockingQueue;->offer(Ljava/lang/Object;)Z

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/concurrent/d;->a()V

    return-void
.end method
