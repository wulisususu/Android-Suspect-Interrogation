.class public Lcom/taobao/network/lifecycle/MtopLifecycleManager;
.super Ljava/lang/Object;
.source "MtopLifecycleManager.java"

# interfaces
.implements Lcom/taobao/network/lifecycle/IMtopLifecycle;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/network/lifecycle/MtopLifecycleManager$Holder;
    }
.end annotation


# instance fields
.field private lifecycle:Lcom/taobao/network/lifecycle/IMtopLifecycle;

.field private readLock:Ljava/util/concurrent/locks/Lock;

.field private writeLock:Ljava/util/concurrent/locks/Lock;


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    new-instance v0, Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;-><init>()V

    .line 15
    invoke-interface {v0}, Ljava/util/concurrent/locks/ReadWriteLock;->readLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v1

    iput-object v1, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 16
    invoke-interface {v0}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/network/lifecycle/MtopLifecycleManager$1;)V
    .locals 0

    .line 8
    invoke-direct {p0}, Lcom/taobao/network/lifecycle/MtopLifecycleManager;-><init>()V

    return-void
.end method

.method public static instance()Lcom/taobao/network/lifecycle/MtopLifecycleManager;
    .locals 1

    .line 20
    invoke-static {}, Lcom/taobao/network/lifecycle/MtopLifecycleManager$Holder;->access$000()Lcom/taobao/network/lifecycle/MtopLifecycleManager;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public onMtopCancel(Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 69
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/IMtopLifecycle;

    if-eqz v0, :cond_0

    .line 72
    invoke-interface {v0, p1, p2}, Lcom/taobao/network/lifecycle/IMtopLifecycle;->onMtopCancel(Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 75
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 76
    throw p1
.end method

.method public onMtopError(Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 57
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/IMtopLifecycle;

    if-eqz v0, :cond_0

    .line 60
    invoke-interface {v0, p1, p2}, Lcom/taobao/network/lifecycle/IMtopLifecycle;->onMtopError(Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 63
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 64
    throw p1
.end method

.method public onMtopEvent(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 93
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/IMtopLifecycle;

    if-eqz v0, :cond_0

    .line 96
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/network/lifecycle/IMtopLifecycle;->onMtopEvent(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 99
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 100
    throw p1
.end method

.method public onMtopFinished(Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 81
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/IMtopLifecycle;

    if-eqz v0, :cond_0

    .line 84
    invoke-interface {v0, p1, p2}, Lcom/taobao/network/lifecycle/IMtopLifecycle;->onMtopFinished(Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 87
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 88
    throw p1
.end method

.method public onMtopRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 45
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/IMtopLifecycle;

    if-eqz v0, :cond_0

    .line 48
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/network/lifecycle/IMtopLifecycle;->onMtopRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 51
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 52
    throw p1
.end method

.method public removeLifecycle(Lcom/taobao/network/lifecycle/IMtopLifecycle;)V
    .locals 1

    iget-object p1, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 35
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->lock()V

    const/4 p1, 0x0

    :try_start_0
    iput-object p1, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/IMtopLifecycle;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p1, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 39
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 40
    throw p1
.end method

.method public setLifecycle(Lcom/taobao/network/lifecycle/IMtopLifecycle;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 24
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/IMtopLifecycle;

    if-nez v0, :cond_0

    iput-object p1, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/IMtopLifecycle;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 30
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/network/lifecycle/MtopLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 31
    throw p1
.end method
