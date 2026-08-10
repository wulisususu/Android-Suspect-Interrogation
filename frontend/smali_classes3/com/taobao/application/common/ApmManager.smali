.class public Lcom/taobao/application/common/ApmManager;
.super Ljava/lang/Object;
.source "ApmManager.java"


# static fields
.field private static apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addActivityLifecycle(Lcom/taobao/application/common/Apm$OnActivityLifecycleCallbacks;Z)V
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 27
    invoke-interface {v0, p0, p1}, Lcom/taobao/application/common/IApplicationMonitor;->addActivityLifecycle(Landroid/app/Application$ActivityLifecycleCallbacks;Z)V

    :cond_0
    return-void
.end method

.method public static addApmEventListener(Lcom/taobao/application/common/IApmEventListener;)V
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 150
    invoke-interface {v0, p0}, Lcom/taobao/application/common/IApplicationMonitor;->addApmEventListener(Lcom/taobao/application/common/IApmEventListener;)V

    :cond_0
    return-void
.end method

.method public static addAppLaunchListener(Lcom/taobao/application/common/Apm$OnAppLaunchListener;)V
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 104
    invoke-interface {v0, p0}, Lcom/taobao/application/common/IApplicationMonitor;->addAppLaunchListener(Lcom/taobao/application/common/IAppLaunchListener;)V

    :cond_0
    return-void
.end method

.method public static addPageFpsListener(Lcom/taobao/application/common/Apm$OnPageFpsListener;)V
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 71
    invoke-interface {v0, p0}, Lcom/taobao/application/common/IApplicationMonitor;->addPageFpsListener(Lcom/taobao/application/common/IPageFpsListener;)V

    :cond_0
    return-void
.end method

.method public static addPageListener(Lcom/taobao/application/common/Apm$OnPageListener;)V
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 49
    invoke-interface {v0, p0}, Lcom/taobao/application/common/IApplicationMonitor;->addPageListener(Lcom/taobao/application/common/IPageListener;)V

    :cond_0
    return-void
.end method

.method public static getAppPreferences()Lcom/taobao/application/common/IAppPreferences;
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 126
    invoke-interface {v0}, Lcom/taobao/application/common/IApplicationMonitor;->getAppPreferences()Lcom/taobao/application/common/IAppPreferences;

    move-result-object v0

    return-object v0

    .line 128
    :cond_0
    sget-object v0, Lcom/taobao/application/common/IAppPreferences;->DEFAULT:Lcom/taobao/application/common/IAppPreferences;

    return-object v0
.end method

.method public static getAsyncHandler()Landroid/os/Handler;
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 172
    invoke-interface {v0}, Lcom/taobao/application/common/IApplicationMonitor;->getAsyncHandler()Landroid/os/Handler;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static getAsyncLooper()Landroid/os/Looper;
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 184
    invoke-interface {v0}, Lcom/taobao/application/common/IApplicationMonitor;->getAsyncLooper()Landroid/os/Looper;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static getTopActivity()Landroid/app/Activity;
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 138
    invoke-interface {v0}, Lcom/taobao/application/common/IApplicationMonitor;->getTopActivity()Landroid/app/Activity;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static removeActivityLifecycle(Lcom/taobao/application/common/Apm$OnActivityLifecycleCallbacks;)V
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 38
    invoke-interface {v0, p0}, Lcom/taobao/application/common/IApplicationMonitor;->removeActivityLifecycle(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    :cond_0
    return-void
.end method

.method public static removeApmEventListener(Lcom/taobao/application/common/IApmEventListener;)V
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 161
    invoke-interface {v0, p0}, Lcom/taobao/application/common/IApplicationMonitor;->removeApmEventListener(Lcom/taobao/application/common/IApmEventListener;)V

    :cond_0
    return-void
.end method

.method public static removeAppLaunchListener(Lcom/taobao/application/common/Apm$OnAppLaunchListener;)V
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 115
    invoke-interface {v0, p0}, Lcom/taobao/application/common/IApplicationMonitor;->removeAppLaunchListener(Lcom/taobao/application/common/IAppLaunchListener;)V

    :cond_0
    return-void
.end method

.method public static removePageFpsListener(Lcom/taobao/application/common/Apm$OnPageFpsListener;)V
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 82
    invoke-interface {v0, p0}, Lcom/taobao/application/common/IApplicationMonitor;->removePageFpsListener(Lcom/taobao/application/common/IPageFpsListener;)V

    :cond_0
    return-void
.end method

.method public static removePageListener(Lcom/taobao/application/common/Apm$OnPageListener;)V
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 60
    invoke-interface {v0, p0}, Lcom/taobao/application/common/IApplicationMonitor;->removePageListener(Lcom/taobao/application/common/IPageListener;)V

    :cond_0
    return-void
.end method

.method static setApmDelegate(Lcom/taobao/application/common/IApplicationMonitor;)V
    .locals 0

    sput-object p0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    return-void
.end method

.method public static setPageLoadCalculateListener(Lcom/taobao/application/common/Apm$OnPageLoadCalculateListener;)V
    .locals 1

    sget-object v0, Lcom/taobao/application/common/ApmManager;->apmDelegate:Lcom/taobao/application/common/IApplicationMonitor;

    if-eqz v0, :cond_0

    .line 93
    invoke-interface {v0, p0}, Lcom/taobao/application/common/IApplicationMonitor;->setPageLoadCalculateListener(Lcom/taobao/application/common/IPageLoadCalculateListener;)V

    :cond_0
    return-void
.end method
