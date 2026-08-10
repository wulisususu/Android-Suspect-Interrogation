.class Lcom/alibaba/sdk/android/emas/j$a;
.super Ljava/lang/Object;
.source "SendManager.java"

# interfaces
.implements Ljava/util/concurrent/RejectedExecutionHandler;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/emas/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 293
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/alibaba/sdk/android/emas/j$1;)V
    .locals 0

    .line 293
    invoke-direct {p0}, Lcom/alibaba/sdk/android/emas/j$a;-><init>()V

    return-void
.end method


# virtual methods
.method public rejectedExecution(Ljava/lang/Runnable;Ljava/util/concurrent/ThreadPoolExecutor;)V
    .locals 0

    .line 297
    instance-of p2, p1, Lcom/alibaba/sdk/android/emas/j$b;

    if-eqz p2, :cond_0

    .line 298
    check-cast p1, Lcom/alibaba/sdk/android/emas/j$b;

    .line 299
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/emas/j$b;->f()V

    :cond_0
    return-void
.end method
