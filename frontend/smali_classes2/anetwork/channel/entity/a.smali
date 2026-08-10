.class public Lanetwork/channel/entity/a;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field private static final a:[Ljava/util/concurrent/ExecutorService;

.field private static b:Ljava/util/concurrent/atomic/AtomicInteger;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    const/4 v0, 0x2

    new-array v1, v0, [Ljava/util/concurrent/ExecutorService;

    sput-object v1, Lanetwork/channel/entity/a;->a:[Ljava/util/concurrent/ExecutorService;

    .line 16
    new-instance v1, Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    sput-object v1, Lanetwork/channel/entity/a;->b:Ljava/util/concurrent/atomic/AtomicInteger;

    :goto_0
    if-ge v2, v0, :cond_0

    sget-object v1, Lanetwork/channel/entity/a;->a:[Ljava/util/concurrent/ExecutorService;

    .line 20
    new-instance v3, Lanetwork/channel/entity/b;

    invoke-direct {v3}, Lanetwork/channel/entity/b;-><init>()V

    invoke-static {v3}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor(Ljava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ExecutorService;

    move-result-object v3

    aput-object v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a()Ljava/util/concurrent/atomic/AtomicInteger;
    .locals 1

    sget-object v0, Lanetwork/channel/entity/a;->b:Ljava/util/concurrent/atomic/AtomicInteger;

    return-object v0
.end method

.method public static a(ILjava/lang/Runnable;)V
    .locals 1

    .line 31
    rem-int/lit8 p0, p0, 0x2

    invoke-static {p0}, Ljava/lang/Math;->abs(I)I

    move-result p0

    sget-object v0, Lanetwork/channel/entity/a;->a:[Ljava/util/concurrent/ExecutorService;

    .line 32
    aget-object p0, v0, p0

    invoke-interface {p0, p1}, Ljava/util/concurrent/ExecutorService;->submit(Ljava/lang/Runnable;)Ljava/util/concurrent/Future;

    return-void
.end method
