.class Lcom/aliyun/emas/apm/crash/c1$a;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/c1;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

.field private final b:Ljava/util/concurrent/atomic/AtomicReference;

.field private final c:Z

.field final synthetic d:Lcom/aliyun/emas/apm/crash/c1;


# direct methods
.method public static synthetic $r8$lambda$6hftghjrpKLKn4mOvJwXQUYc2bw(Lcom/aliyun/emas/apm/crash/c1$a;)Ljava/lang/Void;
    .locals 0

    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/c1$a;->b()Ljava/lang/Void;

    move-result-object p0

    return-object p0
.end method

.method public constructor <init>(Lcom/aliyun/emas/apm/crash/c1;Z)V
    .locals 1

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/c1$a;->d:Lcom/aliyun/emas/apm/crash/c1;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance p1, Ljava/util/concurrent/atomic/AtomicReference;

    const/4 v0, 0x0

    invoke-direct {p1, v0}, Ljava/util/concurrent/atomic/AtomicReference;-><init>(Ljava/lang/Object;)V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/c1$a;->b:Ljava/util/concurrent/atomic/AtomicReference;

    iput-boolean p2, p0, Lcom/aliyun/emas/apm/crash/c1$a;->c:Z

    .line 7
    new-instance p1, Lcom/aliyun/emas/apm/crash/d0;

    if-eqz p2, :cond_0

    const/16 p2, 0x2000

    goto :goto_0

    :cond_0
    const/16 p2, 0x400

    :goto_0
    const/16 v0, 0x40

    .line 8
    invoke-direct {p1, v0, p2}, Lcom/aliyun/emas/apm/crash/d0;-><init>(II)V

    .line 9
    new-instance p2, Ljava/util/concurrent/atomic/AtomicMarkableReference;

    const/4 v0, 0x0

    invoke-direct {p2, p1, v0}, Ljava/util/concurrent/atomic/AtomicMarkableReference;-><init>(Ljava/lang/Object;Z)V

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/c1$a;->a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    return-void
.end method

.method private synthetic b()Ljava/lang/Void;
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1$a;->b:Ljava/util/concurrent/atomic/AtomicReference;

    const/4 v1, 0x0

    .line 1
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/c1$a;->d()V

    return-object v1
.end method

.method private c()V
    .locals 3

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/c1$a$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/crash/c1$a$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/crash/c1$a;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1$a;->b:Ljava/util/concurrent/atomic/AtomicReference;

    const/4 v2, 0x0

    .line 10
    invoke-static {v1, v2, v0}, Landroidx/camera/view/PreviewView$1$$ExternalSyntheticBackportWithForwarding0;->m(Ljava/util/concurrent/atomic/AtomicReference;Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1$a;->d:Lcom/aliyun/emas/apm/crash/c1;

    .line 11
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/c1;->a(Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/j;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/crash/j;->b(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    :cond_0
    return-void
.end method

.method private d()V
    .locals 4

    .line 1
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1$a;->a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 2
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->isMarked()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1$a;->a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 3
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/d0;

    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/d0;->a()Ljava/util/Map;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1$a;->a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 4
    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/crash/d0;

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->set(Ljava/lang/Object;Z)V

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 6
    :goto_0
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1$a;->d:Lcom/aliyun/emas/apm/crash/c1;

    .line 9
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/c1;->c(Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/f0;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/c1$a;->d:Lcom/aliyun/emas/apm/crash/c1;

    invoke-static {v2}, Lcom/aliyun/emas/apm/crash/c1;->b(Lcom/aliyun/emas/apm/crash/c1;)Ljava/lang/String;

    move-result-object v2

    iget-boolean v3, p0, Lcom/aliyun/emas/apm/crash/c1$a;->c:Z

    invoke-virtual {v1, v2, v0, v3}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;Ljava/util/Map;Z)V

    :cond_1
    return-void

    :catchall_0
    move-exception v0

    .line 10
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method


# virtual methods
.method public a()Ljava/util/Map;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1$a;->a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/d0;

    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/d0;->a()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public a(Ljava/util/Map;)V
    .locals 2

    .line 12
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1$a;->a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 13
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/d0;

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/d0;->a(Ljava/util/Map;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/c1$a;->a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 16
    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/d0;

    const/4 v1, 0x1

    invoke-virtual {p1, v0, v1}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->set(Ljava/lang/Object;Z)V

    .line 17
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 18
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/c1$a;->c()V

    return-void

    :catchall_0
    move-exception p1

    .line 19
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1

    .line 2
    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1$a;->a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 5
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/d0;

    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/d0;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    .line 6
    monitor-exit p0

    const/4 p1, 0x0

    return p1

    :cond_0
    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/c1$a;->a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 8
    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/aliyun/emas/apm/crash/d0;

    const/4 v0, 0x1

    invoke-virtual {p1, p2, v0}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->set(Ljava/lang/Object;Z)V

    .line 9
    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 10
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/c1$a;->c()V

    return v0

    :catchall_0
    move-exception p1

    .line 11
    :try_start_1
    monitor-exit p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method
