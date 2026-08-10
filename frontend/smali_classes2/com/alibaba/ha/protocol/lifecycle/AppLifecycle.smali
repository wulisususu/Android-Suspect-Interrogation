.class public Lcom/alibaba/ha/protocol/lifecycle/AppLifecycle;
.super Ljava/lang/Object;
.source "AppLifecycle.java"

# interfaces
.implements Landroid/app/Application$ActivityLifecycleCallbacks;


# instance fields
.field private count:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycle;->count:I

    return-void
.end method


# virtual methods
.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "activity",
            "savedInstanceState"
        }
    .end annotation

    .line 18
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    return-void
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 118
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityDestroyed(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 68
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPaused(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPostCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "activity",
            "savedInstanceState"
        }
    .end annotation

    .line 23
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPostCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    return-void
.end method

.method public onActivityPostDestroyed(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 123
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPostDestroyed(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPostPaused(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 73
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPostPaused(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPostResumed(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 58
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPostResumed(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPostSaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "activity",
            "outState"
        }
    .end annotation

    .line 108
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPostSaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    return-void
.end method

.method public onActivityPostStarted(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 43
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPostStarted(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPostStopped(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 93
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPostStopped(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPreCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "activity",
            "savedInstanceState"
        }
    .end annotation

    .line 13
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPreCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    return-void
.end method

.method public onActivityPreDestroyed(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 113
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPreDestroyed(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPrePaused(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 63
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPrePaused(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPreResumed(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 48
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPreResumed(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPreSaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "activity",
            "outState"
        }
    .end annotation

    .line 98
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPreSaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    return-void
.end method

.method public onActivityPreStarted(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 28
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPreStarted(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityPreStopped(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 78
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityPreStopped(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 53
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityResumed(Landroid/app/Activity;)V

    return-void
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "activity",
            "outState"
        }
    .end annotation

    .line 103
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 33
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityStarted(Landroid/app/Activity;)V

    iget v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycle;->count:I

    if-nez v0, :cond_0

    .line 36
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onForeground(Landroid/app/Activity;)V

    :cond_0
    iget p1, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycle;->count:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycle;->count:I

    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 83
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onActivityStopped(Landroid/app/Activity;)V

    iget v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycle;->count:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycle;->count:I

    if-nez v0, :cond_0

    .line 87
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->onBackground(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method
