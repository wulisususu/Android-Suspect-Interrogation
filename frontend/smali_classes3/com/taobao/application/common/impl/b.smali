.class public Lcom/taobao/application/common/impl/b;
.super Ljava/lang/Object;
.source "ApmImpl.java"

# interfaces
.implements Lcom/taobao/application/common/Apm;
.implements Lcom/taobao/application/common/IApplicationMonitor;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/application/common/impl/b$b;
    }
.end annotation


# instance fields
.field private volatile a:Landroid/app/Activity;

.field private final a:Landroid/os/Handler;

.field private a:Lcom/taobao/application/common/IPageLoadCalculateListener;

.field private final a:Lcom/taobao/application/common/impl/e;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/taobao/application/common/impl/e<",
            "Landroid/app/Application$ActivityLifecycleCallbacks;",
            ">;"
        }
    .end annotation
.end field

.field private final a:Lcom/taobao/application/common/impl/f;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/taobao/application/common/impl/f<",
            "Lcom/taobao/application/common/IPageListener;",
            ">;"
        }
    .end annotation
.end field

.field private a:Ljava/util/concurrent/ConcurrentHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Landroid/app/Application$ActivityLifecycleCallbacks;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private final b:Lcom/taobao/application/common/impl/e;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/taobao/application/common/impl/e<",
            "Landroid/app/Application$ActivityLifecycleCallbacks;",
            ">;"
        }
    .end annotation
.end field

.field private final b:Lcom/taobao/application/common/impl/f;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/taobao/application/common/impl/f<",
            "Lcom/taobao/application/common/IPageFpsListener;",
            ">;"
        }
    .end annotation
.end field

.field private final c:Lcom/taobao/application/common/impl/f;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/taobao/application/common/impl/f<",
            "Lcom/taobao/application/common/IAppLaunchListener;",
            ">;"
        }
    .end annotation
.end field

.field private final d:Lcom/taobao/application/common/impl/f;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/taobao/application/common/impl/f<",
            "Lcom/taobao/application/common/IApmEventListener;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>()V
    .locals 2

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    new-instance v0, Lcom/taobao/application/common/impl/g;

    invoke-direct {v0}, Lcom/taobao/application/common/impl/g;-><init>()V

    iput-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Lcom/taobao/application/common/impl/e;

    .line 6
    new-instance v0, Lcom/taobao/application/common/impl/d;

    invoke-direct {v0}, Lcom/taobao/application/common/impl/d;-><init>()V

    iput-object v0, p0, Lcom/taobao/application/common/impl/b;->b:Lcom/taobao/application/common/impl/e;

    .line 9
    new-instance v0, Lcom/taobao/application/common/impl/i;

    invoke-direct {v0}, Lcom/taobao/application/common/impl/i;-><init>()V

    iput-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Lcom/taobao/application/common/impl/f;

    .line 11
    new-instance v0, Lcom/taobao/application/common/impl/h;

    invoke-direct {v0}, Lcom/taobao/application/common/impl/h;-><init>()V

    iput-object v0, p0, Lcom/taobao/application/common/impl/b;->b:Lcom/taobao/application/common/impl/f;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Lcom/taobao/application/common/IPageLoadCalculateListener;

    .line 16
    new-instance v0, Lcom/taobao/application/common/impl/c;

    invoke-direct {v0}, Lcom/taobao/application/common/impl/c;-><init>()V

    iput-object v0, p0, Lcom/taobao/application/common/impl/b;->c:Lcom/taobao/application/common/impl/f;

    .line 19
    new-instance v0, Lcom/taobao/application/common/impl/a;

    invoke-direct {v0}, Lcom/taobao/application/common/impl/a;-><init>()V

    iput-object v0, p0, Lcom/taobao/application/common/impl/b;->d:Lcom/taobao/application/common/impl/f;

    .line 28
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 32
    new-instance v0, Landroid/os/HandlerThread;

    const-string v1, "Apm-Sec"

    invoke-direct {v0, v1}, Landroid/os/HandlerThread;-><init>(Ljava/lang/String;)V

    .line 33
    invoke-virtual {v0}, Landroid/os/HandlerThread;->start()V

    .line 34
    new-instance v1, Landroid/os/Handler;

    invoke-virtual {v0}, Landroid/os/HandlerThread;->getLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {v1, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    iput-object v1, p0, Lcom/taobao/application/common/impl/b;->a:Landroid/os/Handler;

    const-string v0, "init"

    .line 35
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "ApmImpl"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/Logger;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/application/common/impl/b$a;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/application/common/impl/b;-><init>()V

    return-void
.end method

.method public static a()Lcom/taobao/application/common/impl/b;
    .locals 1

    .line 1
    sget-object v0, Lcom/taobao/application/common/impl/b$b;->a:Lcom/taobao/application/common/impl/b;

    return-object v0
.end method

.method private a(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            ")TT;"
        }
    .end annotation

    return-object p1
.end method


# virtual methods
.method public a()Landroid/app/Application$ActivityLifecycleCallbacks;
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->b:Lcom/taobao/application/common/impl/e;

    .line 2
    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/b;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Application$ActivityLifecycleCallbacks;

    return-object v0
.end method

.method public a()Lcom/taobao/application/common/IApmEventListener;
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->d:Lcom/taobao/application/common/impl/f;

    .line 7
    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/b;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/application/common/IApmEventListener;

    return-object v0
.end method

.method public a()Lcom/taobao/application/common/IAppLaunchListener;
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->c:Lcom/taobao/application/common/impl/f;

    .line 6
    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/b;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/application/common/IAppLaunchListener;

    return-object v0
.end method

.method public a()Lcom/taobao/application/common/IPageFpsListener;
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->b:Lcom/taobao/application/common/impl/f;

    .line 4
    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/b;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/application/common/IPageFpsListener;

    return-object v0
.end method

.method public a()Lcom/taobao/application/common/IPageListener;
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Lcom/taobao/application/common/impl/f;

    .line 3
    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/b;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/application/common/IPageListener;

    return-object v0
.end method

.method public a()Lcom/taobao/application/common/IPageLoadCalculateListener;
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Lcom/taobao/application/common/IPageLoadCalculateListener;

    return-object v0
.end method

.method public a(Landroid/app/Activity;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/b;->a:Landroid/app/Activity;

    return-void
.end method

.method public a(Ljava/lang/Runnable;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Landroid/os/Handler;

    .line 9
    invoke-virtual {v0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public addActivityLifecycle(Landroid/app/Application$ActivityLifecycleCallbacks;Z)V
    .locals 2

    if-eqz p1, :cond_2

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 1
    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v0, p1, v1}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    if-nez v0, :cond_1

    if-eqz p2, :cond_0

    iget-object p2, p0, Lcom/taobao/application/common/impl/b;->a:Lcom/taobao/application/common/impl/e;

    .line 7
    invoke-interface {p2, p1}, Lcom/taobao/application/common/impl/e;->a(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lcom/taobao/application/common/impl/b;->b:Lcom/taobao/application/common/impl/e;

    .line 9
    invoke-interface {p2, p1}, Lcom/taobao/application/common/impl/e;->a(Ljava/lang/Object;)V

    :goto_0
    return-void

    .line 10
    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1

    .line 11
    :cond_2
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1
.end method

.method public addApmEventListener(Lcom/taobao/application/common/IApmEventListener;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->d:Lcom/taobao/application/common/impl/f;

    .line 1
    invoke-interface {v0, p1}, Lcom/taobao/application/common/impl/f;->addListener(Ljava/lang/Object;)V

    return-void
.end method

.method public addAppLaunchListener(Lcom/taobao/application/common/IAppLaunchListener;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->c:Lcom/taobao/application/common/impl/f;

    .line 1
    invoke-interface {v0, p1}, Lcom/taobao/application/common/impl/f;->addListener(Ljava/lang/Object;)V

    return-void
.end method

.method public addPageFpsListener(Lcom/taobao/application/common/IPageFpsListener;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->b:Lcom/taobao/application/common/impl/f;

    .line 1
    invoke-interface {v0, p1}, Lcom/taobao/application/common/impl/f;->addListener(Ljava/lang/Object;)V

    return-void
.end method

.method public addPageListener(Lcom/taobao/application/common/IPageListener;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Lcom/taobao/application/common/impl/f;

    .line 1
    invoke-interface {v0, p1}, Lcom/taobao/application/common/impl/f;->addListener(Ljava/lang/Object;)V

    return-void
.end method

.method public b()Landroid/app/Application$ActivityLifecycleCallbacks;
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Lcom/taobao/application/common/impl/e;

    .line 1
    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/b;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Application$ActivityLifecycleCallbacks;

    return-object v0
.end method

.method public getAppPreferences()Lcom/taobao/application/common/IAppPreferences;
    .locals 1

    .line 1
    invoke-static {}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->instance()Lcom/taobao/application/common/impl/AppPreferencesImpl;

    move-result-object v0

    return-object v0
.end method

.method public getAsyncHandler()Landroid/os/Handler;
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Landroid/os/Handler;

    return-object v0
.end method

.method public getAsyncLooper()Landroid/os/Looper;
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Landroid/os/Handler;

    .line 1
    invoke-virtual {v0}, Landroid/os/Handler;->getLooper()Landroid/os/Looper;

    move-result-object v0

    return-object v0
.end method

.method public getTopActivity()Landroid/app/Activity;
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Landroid/app/Activity;

    return-object v0
.end method

.method public removeActivityLifecycle(Landroid/app/Application$ActivityLifecycleCallbacks;)V
    .locals 2

    if-eqz p1, :cond_2

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 1
    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    if-eqz v0, :cond_1

    .line 3
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    iget-object v1, p0, Lcom/taobao/application/common/impl/b;->a:Ljava/util/concurrent/ConcurrentHashMap;

    .line 4
    invoke-virtual {v1, p1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Lcom/taobao/application/common/impl/e;

    .line 10
    invoke-interface {v0, p1}, Lcom/taobao/application/common/impl/e;->b(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->b:Lcom/taobao/application/common/impl/e;

    .line 12
    invoke-interface {v0, p1}, Lcom/taobao/application/common/impl/e;->b(Ljava/lang/Object;)V

    :goto_0
    return-void

    .line 13
    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1

    .line 14
    :cond_2
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1
.end method

.method public removeApmEventListener(Lcom/taobao/application/common/IApmEventListener;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->d:Lcom/taobao/application/common/impl/f;

    .line 1
    invoke-interface {v0, p1}, Lcom/taobao/application/common/impl/f;->removeListener(Ljava/lang/Object;)V

    return-void
.end method

.method public removeAppLaunchListener(Lcom/taobao/application/common/IAppLaunchListener;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->c:Lcom/taobao/application/common/impl/f;

    .line 1
    invoke-interface {v0, p1}, Lcom/taobao/application/common/impl/f;->removeListener(Ljava/lang/Object;)V

    return-void
.end method

.method public removePageFpsListener(Lcom/taobao/application/common/IPageFpsListener;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->b:Lcom/taobao/application/common/impl/f;

    .line 1
    invoke-interface {v0, p1}, Lcom/taobao/application/common/impl/f;->removeListener(Ljava/lang/Object;)V

    return-void
.end method

.method public removePageListener(Lcom/taobao/application/common/IPageListener;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/application/common/impl/b;->a:Lcom/taobao/application/common/impl/f;

    .line 1
    invoke-interface {v0, p1}, Lcom/taobao/application/common/impl/f;->removeListener(Ljava/lang/Object;)V

    return-void
.end method

.method public setPageLoadCalculateListener(Lcom/taobao/application/common/IPageLoadCalculateListener;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/b;->a:Lcom/taobao/application/common/IPageLoadCalculateListener;

    return-void
.end method
