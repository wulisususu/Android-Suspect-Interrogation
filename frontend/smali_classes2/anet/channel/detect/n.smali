.class public Lanet/channel/detect/n;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field private static a:Lanet/channel/detect/d;

.field private static b:Lanet/channel/detect/ExceptionDetector;

.field private static c:Lanet/channel/detect/k;

.field private static d:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 14
    new-instance v0, Lanet/channel/detect/d;

    invoke-direct {v0}, Lanet/channel/detect/d;-><init>()V

    sput-object v0, Lanet/channel/detect/n;->a:Lanet/channel/detect/d;

    .line 15
    new-instance v0, Lanet/channel/detect/ExceptionDetector;

    invoke-direct {v0}, Lanet/channel/detect/ExceptionDetector;-><init>()V

    sput-object v0, Lanet/channel/detect/n;->b:Lanet/channel/detect/ExceptionDetector;

    .line 16
    new-instance v0, Lanet/channel/detect/k;

    invoke-direct {v0}, Lanet/channel/detect/k;-><init>()V

    sput-object v0, Lanet/channel/detect/n;->c:Lanet/channel/detect/k;

    .line 17
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lanet/channel/detect/n;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a()V
    .locals 5

    const-string v0, "awcn.NetworkDetector"

    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    sget-object v3, Lanet/channel/detect/n;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v4, 0x1

    .line 24
    invoke-virtual {v3, v2, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v3, "registerListener"

    new-array v4, v2, [Ljava/lang/Object;

    .line 25
    invoke-static {v0, v3, v1, v4}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    sget-object v3, Lanet/channel/detect/n;->a:Lanet/channel/detect/d;

    .line 26
    invoke-virtual {v3}, Lanet/channel/detect/d;->b()V

    sget-object v3, Lanet/channel/detect/n;->b:Lanet/channel/detect/ExceptionDetector;

    .line 27
    invoke-virtual {v3}, Lanet/channel/detect/ExceptionDetector;->a()V

    sget-object v3, Lanet/channel/detect/n;->c:Lanet/channel/detect/k;

    .line 28
    invoke-virtual {v3}, Lanet/channel/detect/k;->a()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v3

    const-string v4, "[registerListener]error"

    new-array v2, v2, [Ljava/lang/Object;

    .line 31
    invoke-static {v0, v4, v1, v3, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_0
    :goto_0
    return-void
.end method

.method public static a(Lanet/channel/statist/RequestStatistic;)V
    .locals 1

    sget-object v0, Lanet/channel/detect/n;->d:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 40
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lanet/channel/detect/n;->b:Lanet/channel/detect/ExceptionDetector;

    .line 44
    invoke-virtual {v0, p0}, Lanet/channel/detect/ExceptionDetector;->a(Lanet/channel/statist/RequestStatistic;)V

    return-void
.end method
