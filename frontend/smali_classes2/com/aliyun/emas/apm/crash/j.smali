.class public Lcom/aliyun/emas/apm/crash/j;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field private final a:Ljava/util/concurrent/Executor;

.field private b:Lcom/google/android/gms/tasks/Task;

.field private final c:Ljava/lang/Object;

.field private final d:Ljava/lang/ThreadLocal;


# direct methods
.method public constructor <init>(Ljava/util/concurrent/Executor;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    .line 2
    invoke-static {v0}, Lcom/google/android/gms/tasks/Tasks;->forResult(Ljava/lang/Object;)Lcom/google/android/gms/tasks/Task;

    move-result-object v0

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/j;->b:Lcom/google/android/gms/tasks/Task;

    .line 4
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/j;->c:Ljava/lang/Object;

    .line 7
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/j;->d:Ljava/lang/ThreadLocal;

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/j;->a:Ljava/util/concurrent/Executor;

    .line 12
    new-instance v0, Lcom/aliyun/emas/apm/crash/j$a;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/crash/j$a;-><init>(Lcom/aliyun/emas/apm/crash/j;)V

    invoke-interface {p1, v0}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method private a(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Continuation;
    .locals 1

    .line 5
    new-instance v0, Lcom/aliyun/emas/apm/crash/j$c;

    invoke-direct {v0, p0, p1}, Lcom/aliyun/emas/apm/crash/j$c;-><init>(Lcom/aliyun/emas/apm/crash/j;Ljava/util/concurrent/Callable;)V

    return-object v0
.end method

.method private a(Lcom/google/android/gms/tasks/Task;)Lcom/google/android/gms/tasks/Task;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/j;->a:Ljava/util/concurrent/Executor;

    .line 6
    new-instance v1, Lcom/aliyun/emas/apm/crash/j$d;

    invoke-direct {v1, p0}, Lcom/aliyun/emas/apm/crash/j$d;-><init>(Lcom/aliyun/emas/apm/crash/j;)V

    invoke-virtual {p1, v0, v1}, Lcom/google/android/gms/tasks/Task;->continueWith(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/Continuation;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/j;)Ljava/lang/ThreadLocal;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/j;->d:Ljava/lang/ThreadLocal;

    return-object p0
.end method

.method private c()Z
    .locals 2

    .line 1
    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/j;->d:Ljava/lang/ThreadLocal;

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method


# virtual methods
.method a(Ljava/lang/Runnable;)Lcom/google/android/gms/tasks/Task;
    .locals 1

    .line 4
    new-instance v0, Lcom/aliyun/emas/apm/crash/j$b;

    invoke-direct {v0, p0, p1}, Lcom/aliyun/emas/apm/crash/j$b;-><init>(Lcom/aliyun/emas/apm/crash/j;Ljava/lang/Runnable;)V

    invoke-virtual {p0, v0}, Lcom/aliyun/emas/apm/crash/j;->b(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method

.method public a()V
    .locals 2

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/j;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 3
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Not running on background worker thread as intended."

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public b(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/j;->c:Ljava/lang/Object;

    .line 2
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/j;->b:Lcom/google/android/gms/tasks/Task;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/j;->a:Ljava/util/concurrent/Executor;

    .line 4
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/j;->a(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Continuation;

    move-result-object p1

    invoke-virtual {v1, v2, p1}, Lcom/google/android/gms/tasks/Task;->continueWith(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/Continuation;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    .line 7
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/j;->a(Lcom/google/android/gms/tasks/Task;)Lcom/google/android/gms/tasks/Task;

    move-result-object v1

    iput-object v1, p0, Lcom/aliyun/emas/apm/crash/j;->b:Lcom/google/android/gms/tasks/Task;

    .line 8
    monitor-exit v0

    return-object p1

    :catchall_0
    move-exception p1

    .line 9
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public b()Ljava/util/concurrent/Executor;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/j;->a:Ljava/util/concurrent/Executor;

    return-object v0
.end method

.method public c(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/j;->c:Ljava/lang/Object;

    .line 2
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/j;->b:Lcom/google/android/gms/tasks/Task;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/j;->a:Ljava/util/concurrent/Executor;

    .line 4
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/j;->a(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Continuation;

    move-result-object p1

    invoke-virtual {v1, v2, p1}, Lcom/google/android/gms/tasks/Task;->continueWithTask(Ljava/util/concurrent/Executor;Lcom/google/android/gms/tasks/Continuation;)Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    .line 7
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/j;->a(Lcom/google/android/gms/tasks/Task;)Lcom/google/android/gms/tasks/Task;

    move-result-object v1

    iput-object v1, p0, Lcom/aliyun/emas/apm/crash/j;->b:Lcom/google/android/gms/tasks/Task;

    .line 8
    monitor-exit v0

    return-object p1

    :catchall_0
    move-exception p1

    .line 9
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method
