.class public Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;
.super Ljava/lang/Object;
.source "PhenixLifeCycleManager.java"

# interfaces
.implements Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager$Holder;
    }
.end annotation


# instance fields
.field private lifeCycles:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;",
            ">;"
        }
    .end annotation
.end field

.field private readLock:Ljava/util/concurrent/locks/Lock;

.field private writeLock:Ljava/util/concurrent/locks/Lock;


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 15
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->lifeCycles:Ljava/util/List;

    .line 21
    new-instance v0, Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;-><init>()V

    .line 22
    invoke-interface {v0}, Ljava/util/concurrent/locks/ReadWriteLock;->readLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v1

    iput-object v1, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 23
    invoke-interface {v0}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager$1;)V
    .locals 0

    .line 13
    invoke-direct {p0}, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;-><init>()V

    return-void
.end method

.method public static instance()Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;
    .locals 1

    .line 27
    invoke-static {}, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager$Holder;->access$000()Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public addLifeCycle(Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 31
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->lifeCycles:Ljava/util/List;

    .line 33
    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->lifeCycles:Ljava/util/List;

    .line 34
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 37
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 38
    throw p1

    :cond_0
    :goto_0
    iget-object p1, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 37
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void
.end method

.method public onCancel(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
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

    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 76
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->lifeCycles:Ljava/util/List;

    .line 78
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;

    .line 79
    invoke-interface {v1, p1, p2, p3}, Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;->onCancel(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 82
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 83
    throw p1
.end method

.method public onError(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
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

    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 64
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->lifeCycles:Ljava/util/List;

    .line 66
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;

    .line 67
    invoke-interface {v1, p1, p2, p3}, Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;->onError(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 70
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 71
    throw p1
.end method

.method public onEvent(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
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

    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 100
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->lifeCycles:Ljava/util/List;

    .line 102
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;

    .line 103
    invoke-interface {v1, p1, p2, p3}, Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;->onEvent(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 106
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 107
    throw p1
.end method

.method public onFinished(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
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

    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 88
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->lifeCycles:Ljava/util/List;

    .line 90
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;

    .line 91
    invoke-interface {v1, p1, p2, p3}, Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;->onFinished(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 94
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 95
    throw p1
.end method

.method public onRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    .locals 2
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

    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 52
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->lifeCycles:Ljava/util/List;

    .line 54
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;

    .line 55
    invoke-interface {v1, p1, p2, p3}, Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;->onRequest(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    .line 58
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object p2, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->readLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {p2}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 59
    throw p1
.end method

.method public removeLifeCycle(Lcom/taobao/phenix/lifecycle/IPhenixLifeCycle;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 42
    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    :try_start_0
    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->lifeCycles:Ljava/util/List;

    .line 44
    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object p1, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    .line 46
    invoke-interface {p1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    :catchall_0
    move-exception p1

    iget-object v0, p0, Lcom/taobao/phenix/lifecycle/PhenixLifeCycleManager;->writeLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 47
    throw p1
.end method
