.class public Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor$NotInForegroundTimerTask;
.super Ljava/util/TimerTask;
.source "AppStatusMonitor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "NotInForegroundTimerTask"
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;


# direct methods
.method public constructor <init>(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor$NotInForegroundTimerTask;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    .line 142
    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor$1;)V
    .locals 0

    .line 140
    invoke-direct {p0, p1}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor$NotInForegroundTimerTask;-><init>(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor$NotInForegroundTimerTask;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    const/4 v1, 0x0

    .line 148
    invoke-static {v0, v1}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->access$102(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;Z)Z

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor$NotInForegroundTimerTask;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    .line 151
    invoke-static {v0}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->access$200(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;)Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor$NotInForegroundTimerTask;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;

    .line 152
    invoke-static {v1}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;->access$300(Lcom/alibaba/ha/adapter/service/appstatus/AppStatusMonitor;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;

    .line 153
    invoke-interface {v2}, Lcom/alibaba/ha/adapter/service/appstatus/AppStatusCallbacks;->onSwitchBackground()V

    goto :goto_0

    .line 155
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
