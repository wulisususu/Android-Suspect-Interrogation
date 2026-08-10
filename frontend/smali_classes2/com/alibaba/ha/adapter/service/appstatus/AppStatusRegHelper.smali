.class public Lcom/alibaba/ha/adapter/service/appstatus/AppStatusRegHelper;
.super Ljava/lang/Object;
.source "AppStatusRegHelper.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static registeActivityLifecycleCallbacks(Landroid/app/Application;)V
    .locals 1

    if-eqz p0, :cond_0

    .line 31
    invoke-static {}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->getInstance()Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    move-result-object v0

    .line 30
    invoke-virtual {p0, v0}, Landroid/app/Application;->registerActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    :cond_0
    return-void
.end method

.method public static registerAppStatusCallbacks(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;)V
    .locals 1

    if-eqz p0, :cond_0

    .line 13
    invoke-static {}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->getInstance()Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->registerAppStatusCallbacks(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;)V

    :cond_0
    return-void
.end method

.method public static unRegisterAppStatusCallbacks(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;)V
    .locals 1

    if-eqz p0, :cond_0

    .line 21
    invoke-static {}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->getInstance()Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->unregisterAppStatusCallbacks(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;)V

    :cond_0
    return-void
.end method

.method public static unregisterActivityLifecycleCallbacks(Landroid/app/Application;)V
    .locals 1

    if-eqz p0, :cond_0

    .line 41
    invoke-static {}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->getInstance()Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    move-result-object v0

    .line 40
    invoke-virtual {p0, v0}, Landroid/app/Application;->unregisterActivityLifecycleCallbacks(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    :cond_0
    return-void
.end method
