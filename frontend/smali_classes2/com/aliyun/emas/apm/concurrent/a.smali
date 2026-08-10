.class Lcom/aliyun/emas/apm/concurrent/a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/ThreadFactory;


# static fields
.field private static final e:Ljava/util/concurrent/ThreadFactory;


# instance fields
.field private final a:Ljava/util/concurrent/atomic/AtomicLong;

.field private final b:Ljava/lang/String;

.field private final c:I

.field private final d:Landroid/os/StrictMode$ThreadPolicy;


# direct methods
.method public static synthetic $r8$lambda$_4LXDyJlHMAic00zXhrrJ7tI3Ns(Lcom/aliyun/emas/apm/concurrent/a;Ljava/lang/Runnable;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/concurrent/a;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 1

    .line 1
    invoke-static {}, Ljava/util/concurrent/Executors;->defaultThreadFactory()Ljava/util/concurrent/ThreadFactory;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/concurrent/a;->e:Ljava/util/concurrent/ThreadFactory;

    return-void
.end method

.method constructor <init>(Ljava/lang/String;ILandroid/os/StrictMode$ThreadPolicy;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicLong;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/concurrent/a;->a:Ljava/util/concurrent/atomic/AtomicLong;

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/a;->b:Ljava/lang/String;

    iput p2, p0, Lcom/aliyun/emas/apm/concurrent/a;->c:I

    iput-object p3, p0, Lcom/aliyun/emas/apm/concurrent/a;->d:Landroid/os/StrictMode$ThreadPolicy;

    return-void
.end method

.method private synthetic a(Ljava/lang/Runnable;)V
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/concurrent/a;->c:I

    .line 1
    invoke-static {v0}, Landroid/os/Process;->setThreadPriority(I)V

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/a;->d:Landroid/os/StrictMode$ThreadPolicy;

    if-eqz v0, :cond_0

    .line 3
    invoke-static {v0}, Landroid/os/StrictMode;->setThreadPolicy(Landroid/os/StrictMode$ThreadPolicy;)V

    .line 5
    :cond_0
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    return-void
.end method


# virtual methods
.method public newThread(Ljava/lang/Runnable;)Ljava/lang/Thread;
    .locals 4

    sget-object v0, Lcom/aliyun/emas/apm/concurrent/a;->e:Ljava/util/concurrent/ThreadFactory;

    .line 1
    new-instance v1, Lcom/aliyun/emas/apm/concurrent/a$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1}, Lcom/aliyun/emas/apm/concurrent/a$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/concurrent/a;Ljava/lang/Runnable;)V

    .line 2
    invoke-interface {v0, v1}, Ljava/util/concurrent/ThreadFactory;->newThread(Ljava/lang/Runnable;)Ljava/lang/Thread;

    move-result-object p1

    .line 10
    sget-object v0, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/a;->b:Ljava/lang/String;

    iget-object v2, p0, Lcom/aliyun/emas/apm/concurrent/a;->a:Ljava/util/concurrent/atomic/AtomicLong;

    .line 11
    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicLong;->getAndIncrement()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "%s Thread #%d"

    invoke-static {v0, v2, v1}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 12
    invoke-virtual {p1, v0}, Ljava/lang/Thread;->setName(Ljava/lang/String;)V

    return-object p1
.end method
