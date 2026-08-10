.class final Lcom/aliyun/emas/apm/concurrent/f;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/g;


# instance fields
.field private volatile a:Z

.field private final b:Ljava/util/concurrent/Executor;

.field final c:Ljava/util/concurrent/LinkedBlockingQueue;


# direct methods
.method constructor <init>(ZLjava/util/concurrent/Executor;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v0}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/concurrent/f;->c:Ljava/util/concurrent/LinkedBlockingQueue;

    iput-boolean p1, p0, Lcom/aliyun/emas/apm/concurrent/f;->a:Z

    iput-object p2, p0, Lcom/aliyun/emas/apm/concurrent/f;->b:Ljava/util/concurrent/Executor;

    return-void
.end method

.method private a()V
    .locals 2

    iget-boolean v0, p0, Lcom/aliyun/emas/apm/concurrent/f;->a:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/f;->c:Ljava/util/concurrent/LinkedBlockingQueue;

    .line 4
    invoke-virtual {v0}, Ljava/util/concurrent/LinkedBlockingQueue;->poll()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Runnable;

    :goto_0
    if-eqz v0, :cond_2

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/f;->b:Ljava/util/concurrent/Executor;

    .line 6
    invoke-interface {v1, v0}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    iget-boolean v0, p0, Lcom/aliyun/emas/apm/concurrent/f;->a:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/f;->c:Ljava/util/concurrent/LinkedBlockingQueue;

    .line 8
    invoke-virtual {v0}, Ljava/util/concurrent/LinkedBlockingQueue;->poll()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Runnable;

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0

    :cond_2
    return-void
.end method


# virtual methods
.method public execute(Ljava/lang/Runnable;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/f;->c:Ljava/util/concurrent/LinkedBlockingQueue;

    .line 1
    invoke-virtual {v0, p1}, Ljava/util/concurrent/LinkedBlockingQueue;->offer(Ljava/lang/Object;)Z

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/concurrent/f;->a()V

    return-void
.end method
