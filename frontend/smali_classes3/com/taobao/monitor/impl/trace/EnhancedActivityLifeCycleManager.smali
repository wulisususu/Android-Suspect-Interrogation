.class public Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;
.super Ljava/lang/Object;
.source "EnhancedActivityLifeCycleManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager$a;
    }
.end annotation


# instance fields
.field private callbacks:Lcom/taobao/monitor/impl/data/m/b;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getInstance()Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;
    .locals 1

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager$a;->a()Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;

    move-result-object v0

    return-object v0
.end method

.method private needCapture()Z
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method


# virtual methods
.method public onActivityPostCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1, p2}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPostCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    :cond_0
    return-void
.end method

.method public onActivityPostDestroyed(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPostDestroyed(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPostPaused(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPostPaused(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPostResumed(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPostResumed(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPostStarted(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPostStarted(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPostStopped(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPostStopped(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPreCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1, p2}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPreCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    :cond_0
    return-void
.end method

.method public onActivityPreDestroyed(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPreDestroyed(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPrePaused(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPrePaused(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPreResumed(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPreResumed(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPreStarted(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPreStarted(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public onActivityPreStopped(Landroid/app/Activity;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->needCapture()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    .line 2
    invoke-virtual {v0, p1}, Lcom/taobao/monitor/impl/data/m/b;->onActivityPreStopped(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method

.method public registerActivityLifecycleCallbacks(Lcom/taobao/monitor/impl/data/m/b;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/EnhancedActivityLifeCycleManager;->callbacks:Lcom/taobao/monitor/impl/data/m/b;

    return-void
.end method
