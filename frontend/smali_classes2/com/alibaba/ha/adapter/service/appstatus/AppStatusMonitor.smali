.class public Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;
.super Ljava/lang/Object;
.source "AppStatusMonitor.java"

# interfaces
.implements Landroid/app/Application$ActivityLifecycleCallbacks;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor$NotInForegroundTimerTask;
    }
.end annotation


# static fields
.field public static TAG:Ljava/lang/String; = "AliHaAdapter.AppStatusMonitor"

.field public static s_instance:Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;


# instance fields
.field public mActivitiesActive:I

.field public mAppStatusCallbacksList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;",
            ">;"
        }
    .end annotation
.end field

.field public mAppStatusCallbacksLockObj:Ljava/lang/Object;

.field public mApplicationStatusCheckTimer:Ljava/util/Timer;

.field public mApplicationStatusLockObj:Ljava/lang/Object;

.field public mApplicationStatusTimerTask:Ljava/util/TimerTask;

.field public mIsInForeground:Z


# direct methods
.method public static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mActivitiesActive:I

    iput-boolean v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mIsInForeground:Z

    .line 21
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mApplicationStatusLockObj:Ljava/lang/Object;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mApplicationStatusCheckTimer:Ljava/util/Timer;

    .line 23
    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksList:Ljava/util/List;

    .line 24
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksLockObj:Ljava/lang/Object;

    return-void
.end method

.method private _clearApplicationStatusCheckExistingTimer()V
    .locals 2

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mApplicationStatusLockObj:Ljava/lang/Object;

    .line 55
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mApplicationStatusCheckTimer:Ljava/util/Timer;

    if-eqz v1, :cond_0

    .line 57
    invoke-virtual {v1}, Ljava/util/Timer;->cancel()V

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mApplicationStatusCheckTimer:Ljava/util/Timer;

    .line 60
    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method public static synthetic access$102(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;Z)Z
    .locals 0

    .line 15
    iput-boolean p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mIsInForeground:Z

    return p1
.end method

.method public static synthetic access$200(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;)Ljava/lang/Object;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksLockObj:Ljava/lang/Object;

    return-object p0
.end method

.method public static synthetic access$300(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;)Ljava/util/List;
    .locals 0

    .line 15
    iget-object p0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksList:Ljava/util/List;

    return-object p0
.end method

.method public static declared-synchronized getInstance()Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;
    .locals 2

    const-class v0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->s_instance:Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    if-nez v1, :cond_0

    .line 33
    new-instance v1, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    invoke-direct {v1}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;-><init>()V

    sput-object v1, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->s_instance:Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    :cond_0
    sget-object v1, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->s_instance:Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 35
    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksLockObj:Ljava/lang/Object;

    .line 65
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksList:Ljava/util/List;

    .line 66
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;

    .line 67
    invoke-interface {v2, p1, p2}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;->onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V

    goto :goto_0

    .line 69
    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksLockObj:Ljava/lang/Object;

    .line 74
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksList:Ljava/util/List;

    .line 75
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;

    .line 76
    invoke-interface {v2, p1}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;->onActivityDestroyed(Landroid/app/Activity;)V

    goto :goto_0

    .line 78
    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksLockObj:Ljava/lang/Object;

    .line 83
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksList:Ljava/util/List;

    .line 84
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;

    .line 85
    invoke-interface {v2, p1}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;->onActivityPaused(Landroid/app/Activity;)V

    goto :goto_0

    .line 87
    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksLockObj:Ljava/lang/Object;

    .line 92
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksList:Ljava/util/List;

    .line 93
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;

    .line 94
    invoke-interface {v2, p1}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;->onActivityResumed(Landroid/app/Activity;)V

    goto :goto_0

    .line 96
    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksLockObj:Ljava/lang/Object;

    .line 101
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksList:Ljava/util/List;

    .line 102
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;

    .line 103
    invoke-interface {v2, p1, p2}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;->onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V

    goto :goto_0

    .line 105
    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 3

    .line 111
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->_clearApplicationStatusCheckExistingTimer()V

    iget p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mActivitiesActive:I

    const/4 v0, 0x1

    add-int/2addr p1, v0

    iput p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mActivitiesActive:I

    iget-boolean p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mIsInForeground:Z

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksLockObj:Ljava/lang/Object;

    .line 116
    monitor-enter p1

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksList:Ljava/util/List;

    .line 117
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;

    .line 118
    invoke-interface {v2}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;->onSwitchForeground()V

    goto :goto_0

    .line 120
    :cond_0
    monitor-exit p1

    goto :goto_1

    :catchall_0
    move-exception v0

    monitor-exit p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    :cond_1
    :goto_1
    iput-boolean v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mIsInForeground:Z

    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 3

    iget p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mActivitiesActive:I

    add-int/lit8 p1, p1, -0x1

    iput p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mActivitiesActive:I

    if-nez p1, :cond_0

    .line 131
    invoke-direct {p0}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->_clearApplicationStatusCheckExistingTimer()V

    .line 133
    new-instance p1, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor$NotInForegroundTimerTask;

    const/4 v0, 0x0

    invoke-direct {p1, p0, v0}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor$NotInForegroundTimerTask;-><init>(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor$1;)V

    iput-object p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mApplicationStatusTimerTask:Ljava/util/TimerTask;

    .line 134
    new-instance p1, Ljava/util/Timer;

    invoke-direct {p1}, Ljava/util/Timer;-><init>()V

    iput-object p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mApplicationStatusCheckTimer:Ljava/util/Timer;

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mApplicationStatusTimerTask:Ljava/util/TimerTask;

    const-wide/16 v1, 0x3e8

    .line 135
    invoke-virtual {p1, v0, v1, v2}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V

    :cond_0
    return-void
.end method

.method public registerAppStatusCallbacks(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;)V
    .locals 2

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksLockObj:Ljava/lang/Object;

    .line 40
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksList:Ljava/util/List;

    .line 41
    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 42
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_0
    :goto_0
    return-void
.end method

.method public unregisterAppStatusCallbacks(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;)V
    .locals 2

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksLockObj:Ljava/lang/Object;

    .line 48
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->mAppStatusCallbacksList:Ljava/util/List;

    .line 49
    invoke-interface {v1, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 50
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_0
    :goto_0
    return-void
.end method
