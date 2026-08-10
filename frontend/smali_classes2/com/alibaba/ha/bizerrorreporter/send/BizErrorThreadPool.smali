.class public Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;
.super Ljava/lang/Object;
.source "BizErrorThreadPool.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool$TbThreadFactory;
    }
.end annotation


# static fields
.field public static final INTEGER:Ljava/util/concurrent/atomic/AtomicInteger;

.field public static prop:I = 0x1

.field public static threadPoolExecutor:Ljava/util/concurrent/ScheduledExecutorService;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 19
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>()V

    sput-object v0, Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;->INTEGER:Ljava/util/concurrent/atomic/AtomicInteger;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public declared-synchronized submit(Ljava/lang/Runnable;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "task"
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    sget-object v0, Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;->threadPoolExecutor:Ljava/util/concurrent/ScheduledExecutorService;

    if-nez v0, :cond_0

    .line 39
    new-instance v0, Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool$TbThreadFactory;

    sget v1, Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;->prop:I

    invoke-direct {v0, v1}, Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool$TbThreadFactory;-><init>(I)V

    const/4 v1, 0x3

    invoke-static {v1, v0}, Ljava/util/concurrent/Executors;->newScheduledThreadPool(ILjava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    sput-object v0, Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;->threadPoolExecutor:Ljava/util/concurrent/ScheduledExecutorService;

    :cond_0
    sget-object v0, Lcom/alibaba/ha/bizerrorreporter/send/BizErrorThreadPool;->threadPoolExecutor:Ljava/util/concurrent/ScheduledExecutorService;

    .line 41
    invoke-interface {v0, p1}, Ljava/util/concurrent/ScheduledExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    .line 43
    :try_start_1
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 45
    :goto_0
    monitor-exit p0

    return-void

    :catchall_1
    move-exception p1

    monitor-exit p0

    throw p1
.end method
