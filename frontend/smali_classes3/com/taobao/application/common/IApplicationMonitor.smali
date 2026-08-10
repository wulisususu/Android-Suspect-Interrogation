.class public interface abstract Lcom/taobao/application/common/IApplicationMonitor;
.super Ljava/lang/Object;
.source "IApplicationMonitor.java"


# virtual methods
.method public abstract addActivityLifecycle(Landroid/app/Application$ActivityLifecycleCallbacks;Z)V
.end method

.method public abstract addApmEventListener(Lcom/taobao/application/common/IApmEventListener;)V
.end method

.method public abstract addAppLaunchListener(Lcom/taobao/application/common/IAppLaunchListener;)V
.end method

.method public abstract addPageFpsListener(Lcom/taobao/application/common/IPageFpsListener;)V
.end method

.method public abstract addPageListener(Lcom/taobao/application/common/IPageListener;)V
.end method

.method public abstract getAppPreferences()Lcom/taobao/application/common/IAppPreferences;
.end method

.method public abstract getAsyncHandler()Landroid/os/Handler;
.end method

.method public abstract getAsyncLooper()Landroid/os/Looper;
.end method

.method public abstract getTopActivity()Landroid/app/Activity;
.end method

.method public abstract removeActivityLifecycle(Landroid/app/Application$ActivityLifecycleCallbacks;)V
.end method

.method public abstract removeApmEventListener(Lcom/taobao/application/common/IApmEventListener;)V
.end method

.method public abstract removeAppLaunchListener(Lcom/taobao/application/common/IAppLaunchListener;)V
.end method

.method public abstract removePageFpsListener(Lcom/taobao/application/common/IPageFpsListener;)V
.end method

.method public abstract removePageListener(Lcom/taobao/application/common/IPageListener;)V
.end method

.method public abstract setPageLoadCalculateListener(Lcom/taobao/application/common/IPageLoadCalculateListener;)V
.end method
