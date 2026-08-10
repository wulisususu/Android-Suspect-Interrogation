.class public Lcom/taobao/accs/b/a;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field private static a:Lcom/taobao/accs/b/a;


# instance fields
.field private b:Ljava/lang/ClassLoader;

.field private c:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/accs/b/a;->b:Ljava/lang/ClassLoader;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/b/a;->c:Z

    return-void
.end method

.method public static declared-synchronized a()Lcom/taobao/accs/b/a;
    .locals 2

    const-class v0, Lcom/taobao/accs/b/a;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/taobao/accs/b/a;->a:Lcom/taobao/accs/b/a;

    if-nez v1, :cond_0

    .line 27
    new-instance v1, Lcom/taobao/accs/b/a;

    invoke-direct {v1}, Lcom/taobao/accs/b/a;-><init>()V

    sput-object v1, Lcom/taobao/accs/b/a;->a:Lcom/taobao/accs/b/a;

    :cond_0
    sget-object v1, Lcom/taobao/accs/b/a;->a:Lcom/taobao/accs/b/a;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 29
    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public declared-synchronized b()Ljava/lang/ClassLoader;
    .locals 3

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/taobao/accs/b/a;->b:Ljava/lang/ClassLoader;

    if-nez v0, :cond_0

    const-string v0, "ACCSClassLoader"

    const-string v1, "getClassLoader"

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    .line 71
    invoke-static {v0, v1, v2}, Lcom/taobao/accs/utl/ALog;->d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    const-class v0, Lcom/taobao/accs/b/a;

    .line 72
    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/accs/b/a;->b:Ljava/lang/ClassLoader;

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/b/a;->b:Ljava/lang/ClassLoader;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 74
    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
