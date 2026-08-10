.class public Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;
.super Ljava/lang/Object;
.source "AppLifecycleSubject.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$SingleTon;
    }
.end annotation


# instance fields
.field private activeActivityCount:I

.field private mObservers:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;",
            ">;"
        }
    .end annotation
.end field

.field private totalActivityCount:I


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    const/4 v0, 0x0

    iput v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->activeActivityCount:I

    iput v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->totalActivityCount:I

    return-void
.end method

.method synthetic constructor <init>(Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$1;)V
    .locals 0

    .line 10
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;-><init>()V

    return-void
.end method

.method static synthetic access$100(Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;)Ljava/util/ArrayList;
    .locals 0

    .line 10
    iget-object p0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    return-object p0
.end method

.method private checkThread()V
    .locals 2

    .line 234
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    if-ne v0, v1, :cond_0

    return-void

    .line 235
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-direct {v0}, Ljava/lang/IllegalStateException;-><init>()V

    throw v0
.end method

.method public static getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;
    .locals 1

    .line 20
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$SingleTon;->access$000()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object v0

    return-object v0
.end method

.method private isMainThread()Z
    .locals 2

    .line 240
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-virtual {v0}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private runOnMain(Ljava/lang/Runnable;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "runnable"
        }
    .end annotation

    .line 249
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->isMainThread()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 250
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    goto :goto_0

    .line 252
    :cond_0
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    invoke-virtual {v0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    :goto_0
    return-void
.end method


# virtual methods
.method public addObserver(Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10
        }
        names = {
            "observer"
        }
    .end annotation

    .line 200
    new-instance v0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$1;

    invoke-direct {v0, p0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$1;-><init>(Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;)V

    invoke-direct {p0, v0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->runOnMain(Ljava/lang/Runnable;)V

    return-void
.end method

.method public getActiveActivityCount()I
    .locals 1

    iget v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->activeActivityCount:I

    return v0
.end method

.method public getTotalActivityCount()I
    .locals 1

    iget v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->totalActivityCount:I

    return v0
.end method

.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 2
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

    .line 51
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 52
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 53
    invoke-interface {v1, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 181
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 182
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 183
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityDestroyed(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 117
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 118
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 119
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPaused(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPostCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 2
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

    .line 58
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 59
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 60
    invoke-interface {v1, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPostCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPostDestroyed(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 188
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 189
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 190
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPostDestroyed(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPostPaused(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 124
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 125
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 126
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPostPaused(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPostResumed(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 103
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 104
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 105
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPostResumed(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPostSaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 2
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

    .line 167
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 168
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 169
    invoke-interface {v1, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPostSaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPostStarted(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 82
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 83
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 84
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPostStarted(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPostStopped(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 146
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 147
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 148
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPostStopped(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPreCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 2
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

    .line 44
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 45
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 46
    invoke-interface {v1, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPreCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPreDestroyed(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 174
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 175
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 176
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPreDestroyed(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPrePaused(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 110
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 111
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 112
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPrePaused(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPreResumed(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 89
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 90
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 91
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPreResumed(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPreSaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 2
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

    .line 153
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 154
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 155
    invoke-interface {v1, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPreSaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPreStarted(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 65
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 66
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 67
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPreStarted(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityPreStopped(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 131
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 132
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 133
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityPreStopped(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 96
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 97
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 98
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityResumed(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 2
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

    .line 160
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 161
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 162
    invoke-interface {v1, p1, p2}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 72
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->activeActivityCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->activeActivityCount:I

    iget v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->totalActivityCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->totalActivityCount:I

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 76
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 77
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityStarted(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 138
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->activeActivityCount:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->activeActivityCount:I

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 140
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 141
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onActivityStopped(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onBackground(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 27
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 28
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 29
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onBackground(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onForeground(Landroid/app/Activity;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "activity"
        }
    .end annotation

    .line 37
    invoke-direct {p0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->checkThread()V

    iget-object v0, p0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->mObservers:Ljava/util/ArrayList;

    .line 38
    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;

    .line 39
    invoke-interface {v1, p1}, Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;->onForeground(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public removeObserver(Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10
        }
        names = {
            "observer"
        }
    .end annotation

    .line 214
    new-instance v0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$2;

    invoke-direct {v0, p0, p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$2;-><init>(Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;)V

    invoke-direct {p0, v0}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->runOnMain(Ljava/lang/Runnable;)V

    return-void
.end method
