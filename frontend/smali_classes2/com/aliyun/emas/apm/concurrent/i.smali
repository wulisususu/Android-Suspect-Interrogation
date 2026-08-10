.class final Lcom/aliyun/emas/apm/concurrent/i;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Executor;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/concurrent/i$c;,
        Lcom/aliyun/emas/apm/concurrent/i$b;
    }
.end annotation


# static fields
.field private static final f:Ljava/util/logging/Logger;


# instance fields
.field private final a:Ljava/util/concurrent/Executor;

.field private final b:Ljava/util/Deque;

.field private c:Lcom/aliyun/emas/apm/concurrent/i$c;

.field private d:J

.field private final e:Lcom/aliyun/emas/apm/concurrent/i$b;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-class v0, Lcom/aliyun/emas/apm/concurrent/i;

    .line 1
    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/util/logging/Logger;->getLogger(Ljava/lang/String;)Ljava/util/logging/Logger;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/concurrent/i;->f:Ljava/util/logging/Logger;

    return-void
.end method

.method constructor <init>(Ljava/util/concurrent/Executor;)V
    .locals 2

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/ArrayDeque;

    invoke-direct {v0}, Ljava/util/ArrayDeque;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i;->b:Ljava/util/Deque;

    .line 6
    sget-object v0, Lcom/aliyun/emas/apm/concurrent/i$c;->a:Lcom/aliyun/emas/apm/concurrent/i$c;

    iput-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/aliyun/emas/apm/concurrent/i;->d:J

    .line 19
    new-instance v0, Lcom/aliyun/emas/apm/concurrent/i$b;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/aliyun/emas/apm/concurrent/i$b;-><init>(Lcom/aliyun/emas/apm/concurrent/i;Lcom/aliyun/emas/apm/concurrent/i$a;)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i;->e:Lcom/aliyun/emas/apm/concurrent/i$b;

    .line 22
    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/concurrent/Executor;

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/i;->a:Ljava/util/concurrent/Executor;

    return-void
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/concurrent/i;Lcom/aliyun/emas/apm/concurrent/i$c;)Lcom/aliyun/emas/apm/concurrent/i$c;
    .locals 0

    .line 2
    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/i;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    return-object p1
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/concurrent/i;)Ljava/util/Deque;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/concurrent/i;->b:Ljava/util/Deque;

    return-object p0
.end method

.method static synthetic a()Ljava/util/logging/Logger;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/concurrent/i;->f:Ljava/util/logging/Logger;

    return-object v0
.end method

.method static synthetic b(Lcom/aliyun/emas/apm/concurrent/i;)Lcom/aliyun/emas/apm/concurrent/i$c;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/concurrent/i;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    return-object p0
.end method

.method static synthetic c(Lcom/aliyun/emas/apm/concurrent/i;)J
    .locals 4

    .line 1
    iget-wide v0, p0, Lcom/aliyun/emas/apm/concurrent/i;->d:J

    const-wide/16 v2, 0x1

    add-long/2addr v2, v0

    iput-wide v2, p0, Lcom/aliyun/emas/apm/concurrent/i;->d:J

    return-wide v0
.end method


# virtual methods
.method public execute(Ljava/lang/Runnable;)V
    .locals 7

    .line 1
    invoke-static {p1}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i;->b:Ljava/util/Deque;

    .line 4
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/i;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 7
    sget-object v2, Lcom/aliyun/emas/apm/concurrent/i$c;->d:Lcom/aliyun/emas/apm/concurrent/i$c;

    if-eq v1, v2, :cond_6

    sget-object v2, Lcom/aliyun/emas/apm/concurrent/i$c;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    if-ne v1, v2, :cond_0

    goto :goto_2

    :cond_0
    iget-wide v3, p0, Lcom/aliyun/emas/apm/concurrent/i;->d:J

    .line 20
    new-instance v1, Lcom/aliyun/emas/apm/concurrent/i$a;

    invoke-direct {v1, p0, p1}, Lcom/aliyun/emas/apm/concurrent/i$a;-><init>(Lcom/aliyun/emas/apm/concurrent/i;Ljava/lang/Runnable;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/concurrent/i;->b:Ljava/util/Deque;

    .line 32
    invoke-interface {p1, v1}, Ljava/util/Deque;->add(Ljava/lang/Object;)Z

    .line 33
    sget-object p1, Lcom/aliyun/emas/apm/concurrent/i$c;->b:Lcom/aliyun/emas/apm/concurrent/i$c;

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/i;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 34
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    :try_start_1
    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i;->a:Ljava/util/concurrent/Executor;

    iget-object v5, p0, Lcom/aliyun/emas/apm/concurrent/i;->e:Lcom/aliyun/emas/apm/concurrent/i$b;

    .line 37
    invoke-interface {v0, v5}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Error; {:try_start_1 .. :try_end_1} :catch_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    if-eq v0, p1, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i;->b:Ljava/util/Deque;

    .line 67
    monitor-enter v0

    :try_start_2
    iget-wide v5, p0, Lcom/aliyun/emas/apm/concurrent/i;->d:J

    cmp-long v1, v5, v3

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/i;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    if-ne v1, p1, :cond_2

    iput-object v2, p0, Lcom/aliyun/emas/apm/concurrent/i;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 71
    :cond_2
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    .line 72
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p1

    :catch_0
    move-exception p1

    goto :goto_0

    :catch_1
    move-exception p1

    :goto_0
    iget-object v2, p0, Lcom/aliyun/emas/apm/concurrent/i;->b:Ljava/util/Deque;

    .line 73
    monitor-enter v2

    :try_start_3
    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i;->c:Lcom/aliyun/emas/apm/concurrent/i$c;

    .line 74
    sget-object v3, Lcom/aliyun/emas/apm/concurrent/i$c;->a:Lcom/aliyun/emas/apm/concurrent/i$c;

    if-eq v0, v3, :cond_3

    sget-object v3, Lcom/aliyun/emas/apm/concurrent/i$c;->b:Lcom/aliyun/emas/apm/concurrent/i$c;

    if-ne v0, v3, :cond_4

    :cond_3
    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/i;->b:Ljava/util/Deque;

    .line 77
    invoke-interface {v0, v1}, Ljava/util/Deque;->removeLastOccurrence(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_4

    const/4 v0, 0x1

    goto :goto_1

    :cond_4
    const/4 v0, 0x0

    .line 80
    :goto_1
    instance-of v1, p1, Ljava/util/concurrent/RejectedExecutionException;

    if-eqz v1, :cond_5

    if-nez v0, :cond_5

    .line 83
    monitor-exit v2

    return-void

    .line 84
    :cond_5
    throw p1

    :catchall_1
    move-exception p1

    .line 86
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    throw p1

    :cond_6
    :goto_2
    :try_start_4
    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/i;->b:Ljava/util/Deque;

    .line 87
    invoke-interface {v1, p1}, Ljava/util/Deque;->add(Ljava/lang/Object;)Z

    .line 88
    monitor-exit v0

    return-void

    :catchall_2
    move-exception p1

    .line 113
    monitor-exit v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    throw p1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "SequentialExecutor@"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/i;->a:Ljava/util/concurrent/Executor;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
