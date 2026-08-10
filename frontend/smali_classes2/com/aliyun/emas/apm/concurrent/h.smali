.class final Lcom/aliyun/emas/apm/concurrent/h;
.super Lcom/aliyun/emas/apm/concurrent/b;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/i;


# instance fields
.field private final c:Lcom/aliyun/emas/apm/h;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/h;Ljava/util/concurrent/ScheduledExecutorService;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Lcom/aliyun/emas/apm/concurrent/b;-><init>(Ljava/util/concurrent/ExecutorService;Ljava/util/concurrent/ScheduledExecutorService;)V

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/h;->c:Lcom/aliyun/emas/apm/h;

    return-void
.end method


# virtual methods
.method public scheduleAtFixedRate(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;
    .locals 0

    .line 1
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    invoke-direct {p1}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw p1
.end method

.method public scheduleWithFixedDelay(Ljava/lang/Runnable;JJLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;
    .locals 0

    .line 1
    new-instance p1, Ljava/lang/UnsupportedOperationException;

    invoke-direct {p1}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw p1
.end method
