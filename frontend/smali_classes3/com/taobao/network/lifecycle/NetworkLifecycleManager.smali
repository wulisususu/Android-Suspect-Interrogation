.class public Lcom/taobao/network/lifecycle/NetworkLifecycleManager;
.super Ljava/lang/Object;
.source "NetworkLifecycleManager.java"

# interfaces
.implements Lcom/taobao/network/lifecycle/INetworkLifecycle;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/network/lifecycle/NetworkLifecycleManager$Holder;
    }
.end annotation


# instance fields
.field private lifecycle:Lcom/taobao/network/lifecycle/INetworkLifecycle;

.field private readLock:Ljava/util/concurrent/locks/Lock;

.field private writeLock:Ljava/util/concurrent/locks/Lock;


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 15
    new-instance v0, Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;-><init>()V

    .line 16
    invoke-interface {v0}, Ljava/util/concurrent/locks/ReadWriteLock;->readLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v1

    iput-object v1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 17
    invoke-interface {v0}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/network/lifecycle/NetworkLifecycleManager$1;)V
    .locals 0

    .line 8
    invoke-direct {p0}, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;-><init>()V

    return-void
.end method

.method public static instance()Lcom/taobao/network/lifecycle/NetworkLifecycleManager;
    .locals 1

    .line 21
    invoke-static {}, Lcom/taobao/network/lifecycle/NetworkLifecycleManager$Holder;->access$000()Lcom/taobao/network/lifecycle/NetworkLifecycleManager;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public onCancel(Ljava/lang/String;Ljava/util/Map;)V
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

    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 82
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/INetworkLifecycle;

    if-eqz v0, :cond_0

    .line 85
    invoke-interface {v0, p1, p2}, Lcom/taobao/network/lifecycle/INetworkLifecycle;->onCancel(Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 88
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 89
    throw p1
.end method

.method public onError(Ljava/lang/String;Ljava/util/Map;)V
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

    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 70
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/INetworkLifecycle;

    if-eqz v0, :cond_0

    .line 73
    invoke-interface {v0, p1, p2}, Lcom/taobao/network/lifecycle/INetworkLifecycle;->onError(Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 76
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 77
    throw p1
.end method

.method public onEvent(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
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

    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 106
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/INetworkLifecycle;

    if-eqz v0, :cond_0

    .line 109
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/network/lifecycle/INetworkLifecycle;->onEvent(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 112
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 113
    throw p1
.end method

.method public onFinished(Ljava/lang/String;Ljava/util/Map;)V
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

    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 94
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/INetworkLifecycle;

    if-eqz v0, :cond_0

    .line 97
    invoke-interface {v0, p1, p2}, Lcom/taobao/network/lifecycle/INetworkLifecycle;->onFinished(Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 100
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 101
    throw p1
.end method

.method public onRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
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

    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 46
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/INetworkLifecycle;

    if-eqz v0, :cond_0

    .line 49
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/network/lifecycle/INetworkLifecycle;->onRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 52
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 53
    throw p1
.end method

.method public onValidRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
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

    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 58
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/INetworkLifecycle;

    if-eqz v0, :cond_0

    .line 61
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/network/lifecycle/INetworkLifecycle;->onValidRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 64
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 65
    throw p1
.end method

.method public removeLifecycle(Lcom/taobao/network/lifecycle/INetworkLifecycle;)V
    .locals 1

    iget-object p1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 36
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->lock()V

    const/4 p1, 0x0

    :try_start_0
    iput-object p1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/INetworkLifecycle;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 40
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 41
    throw p1
.end method

.method public setLifecycle(Lcom/taobao/network/lifecycle/INetworkLifecycle;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 25
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/INetworkLifecycle;

    if-nez v0, :cond_0

    iput-object p1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->lifecycle:Lcom/taobao/network/lifecycle/INetworkLifecycle;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 31
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/network/lifecycle/NetworkLifecycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 32
    throw p1
.end method
