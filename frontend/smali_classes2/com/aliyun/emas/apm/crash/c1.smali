.class public Lcom/aliyun/emas/apm/crash/c1;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/c1$a;
    }
.end annotation


# instance fields
.field private final a:Lcom/aliyun/emas/apm/crash/f0;

.field private final b:Lcom/aliyun/emas/apm/crash/j;

.field private c:Ljava/lang/String;

.field private final d:Lcom/aliyun/emas/apm/crash/c1$a;

.field private final e:Lcom/aliyun/emas/apm/crash/c1$a;

.field private final f:Lcom/aliyun/emas/apm/crash/t0;

.field private final g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

.field private final h:Ljava/util/concurrent/atomic/AtomicMarkableReference;


# direct methods
.method public static synthetic $r8$lambda$NahDIPTub4BvVsPFv3y99dbQCso(Lcom/aliyun/emas/apm/crash/c1;)Ljava/lang/Object;
    .locals 0

    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/c1;->h()Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$m7B08Ah7zMEK0aJR-pVWb73pVLc(Lcom/aliyun/emas/apm/crash/c1;)Ljava/lang/Object;
    .locals 0

    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/c1;->f()Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$rU02aZlgnpblkY0aUvQ3aRB7czY(Lcom/aliyun/emas/apm/crash/c1;)Ljava/lang/Object;
    .locals 0

    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/c1;->g()Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/j;)V
    .locals 3

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/crash/c1$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/aliyun/emas/apm/crash/c1$a;-><init>(Lcom/aliyun/emas/apm/crash/c1;Z)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->d:Lcom/aliyun/emas/apm/crash/c1$a;

    .line 3
    new-instance v0, Lcom/aliyun/emas/apm/crash/c1$a;

    const/4 v2, 0x1

    invoke-direct {v0, p0, v2}, Lcom/aliyun/emas/apm/crash/c1$a;-><init>(Lcom/aliyun/emas/apm/crash/c1;Z)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->e:Lcom/aliyun/emas/apm/crash/c1$a;

    .line 5
    new-instance v0, Lcom/aliyun/emas/apm/crash/t0;

    const/16 v2, 0x80

    invoke-direct {v0, v2}, Lcom/aliyun/emas/apm/crash/t0;-><init>(I)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->f:Lcom/aliyun/emas/apm/crash/t0;

    .line 8
    new-instance v0, Ljava/util/concurrent/atomic/AtomicMarkableReference;

    const/4 v2, 0x0

    invoke-direct {v0, v2, v1}, Ljava/util/concurrent/atomic/AtomicMarkableReference;-><init>(Ljava/lang/Object;Z)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 9
    new-instance v0, Ljava/util/concurrent/atomic/AtomicMarkableReference;

    invoke-direct {v0, v2, v1}, Ljava/util/concurrent/atomic/AtomicMarkableReference;-><init>(Ljava/lang/Object;Z)V

    iput-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->h:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/c1;->c:Ljava/lang/String;

    .line 38
    new-instance p1, Lcom/aliyun/emas/apm/crash/f0;

    invoke-direct {p1, p2}, Lcom/aliyun/emas/apm/crash/f0;-><init>(Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;)V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/c1;->a:Lcom/aliyun/emas/apm/crash/f0;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/c1;->b:Lcom/aliyun/emas/apm/crash/j;

    return-void
.end method

.method public static a(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/j;)Lcom/aliyun/emas/apm/crash/c1;
    .locals 3

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/crash/f0;

    invoke-direct {v0, p1}, Lcom/aliyun/emas/apm/crash/f0;-><init>(Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;)V

    .line 3
    new-instance v1, Lcom/aliyun/emas/apm/crash/c1;

    invoke-direct {v1, p0, p1, p2}, Lcom/aliyun/emas/apm/crash/c1;-><init>(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/internal/persistence/FileStore;Lcom/aliyun/emas/apm/crash/j;)V

    iget-object p1, v1, Lcom/aliyun/emas/apm/crash/c1;->d:Lcom/aliyun/emas/apm/crash/c1$a;

    .line 6
    iget-object p1, p1, Lcom/aliyun/emas/apm/crash/c1$a;->a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/crash/d0;

    const/4 p2, 0x0

    invoke-virtual {v0, p0, p2}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;Z)Ljava/util/Map;

    move-result-object v2

    invoke-virtual {p1, v2}, Lcom/aliyun/emas/apm/crash/d0;->a(Ljava/util/Map;)V

    iget-object p1, v1, Lcom/aliyun/emas/apm/crash/c1;->e:Lcom/aliyun/emas/apm/crash/c1$a;

    .line 7
    iget-object p1, p1, Lcom/aliyun/emas/apm/crash/c1$a;->a:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/crash/d0;

    const/4 v2, 0x1

    invoke-virtual {v0, p0, v2}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;Z)Ljava/util/Map;

    move-result-object v2

    invoke-virtual {p1, v2}, Lcom/aliyun/emas/apm/crash/d0;->a(Ljava/util/Map;)V

    iget-object p1, v1, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 8
    invoke-virtual {v0, p0}, Lcom/aliyun/emas/apm/crash/f0;->j(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/b1;

    move-result-object v2

    invoke-virtual {p1, v2, p2}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->set(Ljava/lang/Object;Z)V

    iget-object p1, v1, Lcom/aliyun/emas/apm/crash/c1;->h:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 9
    invoke-virtual {v0, p0}, Lcom/aliyun/emas/apm/crash/f0;->h(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/k0;

    move-result-object v2

    invoke-virtual {p1, v2, p2}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->set(Ljava/lang/Object;Z)V

    iget-object p1, v1, Lcom/aliyun/emas/apm/crash/c1;->f:Lcom/aliyun/emas/apm/crash/t0;

    .line 10
    invoke-virtual {v0, p0}, Lcom/aliyun/emas/apm/crash/f0;->i(Ljava/lang/String;)Ljava/util/List;

    move-result-object p0

    invoke-virtual {p1, p0}, Lcom/aliyun/emas/apm/crash/t0;->a(Ljava/util/List;)Z

    return-object v1
.end method

.method static synthetic a(Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/j;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/c1;->b:Lcom/aliyun/emas/apm/crash/j;

    return-object p0
.end method

.method static synthetic b(Lcom/aliyun/emas/apm/crash/c1;)Ljava/lang/String;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/c1;->c:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic c(Lcom/aliyun/emas/apm/crash/c1;)Lcom/aliyun/emas/apm/crash/f0;
    .locals 0

    .line 1
    iget-object p0, p0, Lcom/aliyun/emas/apm/crash/c1;->a:Lcom/aliyun/emas/apm/crash/f0;

    return-object p0
.end method

.method private synthetic f()Ljava/lang/Object;
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/c1;->i()V

    const/4 v0, 0x0

    return-object v0
.end method

.method private synthetic g()Ljava/lang/Object;
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/c1;->j()V

    const/4 v0, 0x0

    return-object v0
.end method

.method private synthetic h()Ljava/lang/Object;
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/c1;->j()V

    const/4 v0, 0x0

    return-object v0
.end method

.method private i()V
    .locals 4

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->h:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 1
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1;->h:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 2
    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->isMarked()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    .line 3
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/c1;->c()Lcom/aliyun/emas/apm/crash/k0;

    move-result-object v1

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/c1;->h:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 5
    invoke-virtual {v3, v1, v2}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->set(Ljava/lang/Object;Z)V

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 7
    :goto_0
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->a:Lcom/aliyun/emas/apm/crash/f0;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/c1;->c:Ljava/lang/String;

    .line 10
    invoke-virtual {v0, v2, v1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/k0;)V

    :cond_1
    return-void

    :catchall_0
    move-exception v1

    .line 11
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method private j()V
    .locals 4

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 1
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 2
    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->isMarked()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    .line 3
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/c1;->e()Lcom/aliyun/emas/apm/crash/b1;

    move-result-object v1

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 5
    invoke-virtual {v3, v1, v2}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->set(Ljava/lang/Object;Z)V

    const/4 v2, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 7
    :goto_0
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->a:Lcom/aliyun/emas/apm/crash/f0;

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/c1;->c:Ljava/lang/String;

    .line 9
    invoke-virtual {v0, v2, v1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/b1;)V

    :cond_1
    return-void

    :catchall_0
    move-exception v1

    .line 10
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method


# virtual methods
.method public a()Ljava/util/Map;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->d:Lcom/aliyun/emas/apm/crash/c1$a;

    .line 72
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/c1$a;->a()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public a(Landroid/content/Context;Ljava/lang/String;)V
    .locals 5

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->c:Ljava/lang/String;

    .line 11
    monitor-enter v0

    :try_start_0
    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/c1;->c:Ljava/lang/String;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1;->d:Lcom/aliyun/emas/apm/crash/c1$a;

    .line 13
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/c1$a;->a()Ljava/util/Map;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/c1;->f:Lcom/aliyun/emas/apm/crash/t0;

    .line 14
    invoke-virtual {v2}, Lcom/aliyun/emas/apm/crash/t0;->b()Ljava/util/List;

    move-result-object v2

    .line 15
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/c1;->e()Lcom/aliyun/emas/apm/crash/b1;

    move-result-object v3

    if-eqz v3, :cond_0

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/c1;->a:Lcom/aliyun/emas/apm/crash/f0;

    .line 16
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/c1;->e()Lcom/aliyun/emas/apm/crash/b1;

    move-result-object v4

    invoke-virtual {v3, p2, v4}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/b1;)V

    .line 18
    :cond_0
    invoke-interface {v1}, Ljava/util/Map;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_1

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/c1;->a:Lcom/aliyun/emas/apm/crash/f0;

    .line 19
    invoke-virtual {v3, p2, v1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;Ljava/util/Map;)V

    .line 21
    :cond_1
    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1;->a:Lcom/aliyun/emas/apm/crash/f0;

    .line 22
    invoke-virtual {v1, p2, v2}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;Ljava/util/List;)V

    .line 24
    :cond_2
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/c1;->c()Lcom/aliyun/emas/apm/crash/k0;

    move-result-object v1

    if-eqz v1, :cond_3

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/c1;->a:Lcom/aliyun/emas/apm/crash/f0;

    .line 25
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/c1;->c()Lcom/aliyun/emas/apm/crash/k0;

    move-result-object v1

    invoke-virtual {p1, p2, v1}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/k0;)V

    goto :goto_0

    .line 27
    :cond_3
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/l0;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    .line 28
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/l0;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    .line 29
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_5

    .line 30
    :cond_4
    new-instance v2, Lcom/aliyun/emas/apm/crash/k0;

    invoke-direct {v2}, Lcom/aliyun/emas/apm/crash/k0;-><init>()V

    .line 31
    invoke-virtual {v2, v1}, Lcom/aliyun/emas/apm/crash/k0;->b(Ljava/lang/String;)V

    .line 32
    invoke-virtual {v2, p1}, Lcom/aliyun/emas/apm/crash/k0;->a(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/c1;->a:Lcom/aliyun/emas/apm/crash/f0;

    .line 33
    invoke-virtual {p1, p2, v2}, Lcom/aliyun/emas/apm/crash/f0;->a(Ljava/lang/String;Lcom/aliyun/emas/apm/crash/k0;)V

    .line 36
    :cond_5
    :goto_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    .line 37
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public a(Lcom/aliyun/emas/apm/crash/k0;)V
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->h:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 55
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1;->h:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 56
    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/aliyun/emas/apm/crash/k0;

    if-nez v1, :cond_0

    if-nez p1, :cond_1

    .line 59
    monitor-exit v0

    return-void

    .line 62
    :cond_0
    invoke-virtual {v1, p1}, Lcom/aliyun/emas/apm/crash/k0;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 63
    monitor-exit v0

    return-void

    :cond_1
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1;->h:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    const/4 v2, 0x1

    .line 67
    invoke-virtual {v1, p1, v2}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->set(Ljava/lang/Object;Z)V

    .line 68
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/c1;->b:Lcom/aliyun/emas/apm/crash/j;

    .line 70
    new-instance v0, Lcom/aliyun/emas/apm/crash/c1$$ExternalSyntheticLambda1;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/crash/c1$$ExternalSyntheticLambda1;-><init>(Lcom/aliyun/emas/apm/crash/c1;)V

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/j;->b(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    return-void

    :catchall_0
    move-exception p1

    .line 71
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public a(Ljava/lang/String;)V
    .locals 4

    const/16 v0, 0x400

    .line 38
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/d0;->a(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 39
    monitor-enter v1

    :try_start_0
    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 40
    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/crash/b1;

    if-eqz v2, :cond_0

    .line 41
    invoke-virtual {v2}, Lcom/aliyun/emas/apm/crash/b1;->a()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    .line 42
    :goto_0
    invoke-static {v0, v3}, Lcom/aliyun/emas/apm/crash/i;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 43
    monitor-exit v1

    return-void

    :cond_1
    if-nez v2, :cond_2

    .line 47
    new-instance v2, Lcom/aliyun/emas/apm/crash/b1;

    invoke-direct {v2}, Lcom/aliyun/emas/apm/crash/b1;-><init>()V

    .line 49
    :cond_2
    invoke-virtual {v2, p1}, Lcom/aliyun/emas/apm/crash/b1;->a(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    const/4 v0, 0x1

    .line 51
    invoke-virtual {p1, v2, v0}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->set(Ljava/lang/Object;Z)V

    .line 52
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/c1;->b:Lcom/aliyun/emas/apm/crash/j;

    .line 53
    new-instance v0, Lcom/aliyun/emas/apm/crash/c1$$ExternalSyntheticLambda0;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/crash/c1$$ExternalSyntheticLambda0;-><init>(Lcom/aliyun/emas/apm/crash/c1;)V

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/j;->b(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    return-void

    :catchall_0
    move-exception p1

    .line 54
    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public a(Ljava/util/Map;)V
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->d:Lcom/aliyun/emas/apm/crash/c1$a;

    .line 74
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/c1$a;->a(Ljava/util/Map;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->d:Lcom/aliyun/emas/apm/crash/c1$a;

    .line 73
    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/c1$a;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    return p1
.end method

.method public b()Ljava/util/Map;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->e:Lcom/aliyun/emas/apm/crash/c1$a;

    .line 19
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/c1$a;->a()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public b(Ljava/lang/String;)V
    .locals 4

    const/16 v0, 0x400

    .line 2
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/d0;->a(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 3
    monitor-enter v1

    :try_start_0
    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 4
    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/crash/b1;

    if-eqz v2, :cond_0

    .line 5
    invoke-virtual {v2}, Lcom/aliyun/emas/apm/crash/b1;->b()Ljava/lang/String;

    move-result-object v3

    goto :goto_0

    :cond_0
    const/4 v3, 0x0

    .line 6
    :goto_0
    invoke-static {v0, v3}, Lcom/aliyun/emas/apm/crash/i;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 7
    monitor-exit v1

    return-void

    :cond_1
    if-nez v2, :cond_2

    .line 11
    new-instance v2, Lcom/aliyun/emas/apm/crash/b1;

    invoke-direct {v2}, Lcom/aliyun/emas/apm/crash/b1;-><init>()V

    .line 13
    :cond_2
    invoke-virtual {v2, p1}, Lcom/aliyun/emas/apm/crash/b1;->b(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    const/4 v0, 0x1

    .line 15
    invoke-virtual {p1, v2, v0}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->set(Ljava/lang/Object;Z)V

    .line 16
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/c1;->b:Lcom/aliyun/emas/apm/crash/j;

    .line 17
    new-instance v0, Lcom/aliyun/emas/apm/crash/c1$$ExternalSyntheticLambda2;

    invoke-direct {v0, p0}, Lcom/aliyun/emas/apm/crash/c1$$ExternalSyntheticLambda2;-><init>(Lcom/aliyun/emas/apm/crash/c1;)V

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/j;->b(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Task;

    return-void

    :catchall_0
    move-exception p1

    .line 18
    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p1
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->e:Lcom/aliyun/emas/apm/crash/c1$a;

    .line 20
    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/c1$a;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    return p1
.end method

.method public c()Lcom/aliyun/emas/apm/crash/k0;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->h:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 2
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/k0;

    return-object v0
.end method

.method public d()Ljava/util/List;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->f:Lcom/aliyun/emas/apm/crash/t0;

    .line 1
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/t0;->a()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public e()Lcom/aliyun/emas/apm/crash/b1;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/c1;->g:Ljava/util/concurrent/atomic/AtomicMarkableReference;

    .line 1
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicMarkableReference;->getReference()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/aliyun/emas/apm/crash/b1;

    return-object v0
.end method
