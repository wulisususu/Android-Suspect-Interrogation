.class final Lcom/aliyun/emas/apm/concurrent/i$b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/concurrent/i;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "b"
.end annotation


# instance fields
.field a:Ljava/lang/Runnable;

.field final synthetic b:Lcom/aliyun/emas/apm/concurrent/i;


# direct methods
.method private constructor <init>(Lcom/aliyun/emas/apm/concurrent/i;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->b:Lcom/aliyun/emas/apm/concurrent/i;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/aliyun/emas/apm/concurrent/i;Lcom/aliyun/emas/apm/concurrent/i$a;)V
    .locals 0

    .line 2
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/concurrent/i$b;-><init>(Lcom/aliyun/emas/apm/concurrent/i;)V

    return-void
.end method

.method private a()V
    .locals 8

    const/4 v0, 0x0

    move v1, v0

    :goto_0
    :try_start_0
    iget-object v2, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->b:Lcom/aliyun/emas/apm/concurrent/i;

    .line 1
    invoke-static {v2}, Lcom/aliyun/emas/apm/concurrent/i;->a(Lcom/aliyun/emas/apm/concurrent/i;)Ljava/util/Deque;

    move-result-object v2

    monitor-enter v2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    if-nez v0, :cond_2

    :try_start_1
    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->b:Lcom/aliyun/emas/apm/concurrent/i;

    .line 5
    invoke-static {v0}, Lcom/aliyun/emas/apm/concurrent/i;->b(Lcom/aliyun/emas/apm/concurrent/i;)Lcom/aliyun/emas/apm/concurrent/i$c;

    move-result-object v0

    sget-object v3, Lcom/aliyun/emas/apm/concurrent/i$c;->d:Lcom/aliyun/emas/apm/concurrent/i$c;

    if-ne v0, v3, :cond_1

    .line 7
    monitor-exit v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    if-eqz v1, :cond_0

    .line 40
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    :cond_0
    return-void

    :cond_1
    :try_start_2
    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->b:Lcom/aliyun/emas/apm/concurrent/i;

    .line 41
    invoke-static {v0}, Lcom/aliyun/emas/apm/concurrent/i;->c(Lcom/aliyun/emas/apm/concurrent/i;)J

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->b:Lcom/aliyun/emas/apm/concurrent/i;

    .line 42
    invoke-static {v0, v3}, Lcom/aliyun/emas/apm/concurrent/i;->a(Lcom/aliyun/emas/apm/concurrent/i;Lcom/aliyun/emas/apm/concurrent/i$c;)Lcom/aliyun/emas/apm/concurrent/i$c;

    const/4 v0, 0x1

    :cond_2
    iget-object v3, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->b:Lcom/aliyun/emas/apm/concurrent/i;

    .line 46
    invoke-static {v3}, Lcom/aliyun/emas/apm/concurrent/i;->a(Lcom/aliyun/emas/apm/concurrent/i;)Ljava/util/Deque;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Deque;->poll()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Runnable;

    iput-object v3, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->a:Ljava/lang/Runnable;

    if-nez v3, :cond_4

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->b:Lcom/aliyun/emas/apm/concurrent/i;

    .line 48
    sget-object v3, Lcom/aliyun/emas/apm/concurrent/i$c;->a:Lcom/aliyun/emas/apm/concurrent/i$c;

    invoke-static {v0, v3}, Lcom/aliyun/emas/apm/concurrent/i;->a(Lcom/aliyun/emas/apm/concurrent/i;Lcom/aliyun/emas/apm/concurrent/i$c;)Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 49
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    if-eqz v1, :cond_3

    .line 69
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    :cond_3
    return-void

    .line 70
    :cond_4
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 74
    :try_start_4
    invoke-static {}, Ljava/lang/Thread;->interrupted()Z

    move-result v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    or-int/2addr v1, v2

    const/4 v2, 0x0

    :try_start_5
    iget-object v3, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->a:Ljava/lang/Runnable;

    .line 76
    invoke-interface {v3}, Ljava/lang/Runnable;->run()V
    :try_end_5
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v0

    goto :goto_2

    :catch_0
    move-exception v3

    .line 81
    :try_start_6
    invoke-static {}, Lcom/aliyun/emas/apm/concurrent/i;->a()Ljava/util/logging/Logger;

    move-result-object v4

    sget-object v5, Ljava/util/logging/Level;->SEVERE:Ljava/util/logging/Level;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Exception while executing runnable "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    iget-object v7, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->a:Ljava/lang/Runnable;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v5, v6, v3}, Ljava/util/logging/Logger;->log(Ljava/util/logging/Level;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    :goto_1
    :try_start_7
    iput-object v2, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->a:Ljava/lang/Runnable;

    goto :goto_0

    :goto_2
    iput-object v2, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->a:Ljava/lang/Runnable;

    .line 84
    throw v0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    :catchall_1
    move-exception v0

    .line 85
    :try_start_8
    monitor-exit v2
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    :try_start_9
    throw v0
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_2

    :catchall_2
    move-exception v0

    if-eqz v1, :cond_5

    .line 103
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Thread;->interrupt()V

    .line 105
    :cond_5
    throw v0
.end method


# virtual methods
.method public run()V
    .locals 4

    .line 1
    :try_start_0
    invoke-direct {p0}, Lcom/aliyun/emas/apm/concurrent/i$b;->a()V
    :try_end_0
    .catch Ljava/lang/Error; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->b:Lcom/aliyun/emas/apm/concurrent/i;

    .line 3
    invoke-static {v1}, Lcom/aliyun/emas/apm/concurrent/i;->a(Lcom/aliyun/emas/apm/concurrent/i;)Ljava/util/Deque;

    move-result-object v1

    monitor-enter v1

    :try_start_1
    iget-object v2, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->b:Lcom/aliyun/emas/apm/concurrent/i;

    .line 4
    sget-object v3, Lcom/aliyun/emas/apm/concurrent/i$c;->a:Lcom/aliyun/emas/apm/concurrent/i$c;

    invoke-static {v2, v3}, Lcom/aliyun/emas/apm/concurrent/i;->a(Lcom/aliyun/emas/apm/concurrent/i;Lcom/aliyun/emas/apm/concurrent/i$c;)Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 5
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 6
    throw v0

    :catchall_0
    move-exception v0

    .line 7
    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v0
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->a:Ljava/lang/Runnable;

    const-string/jumbo v1, "}"

    if-eqz v0, :cond_0

    .line 3
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "SequentialExecutorWorker{running="

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 5
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "SequentialExecutorWorker{state="

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/aliyun/emas/apm/concurrent/i$b;->b:Lcom/aliyun/emas/apm/concurrent/i;

    invoke-static {v2}, Lcom/aliyun/emas/apm/concurrent/i;->b(Lcom/aliyun/emas/apm/concurrent/i;)Lcom/aliyun/emas/apm/concurrent/i$c;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
