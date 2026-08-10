.class public Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$3;
.super Ljava/lang/Object;
.source "Event1010Handler.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->onSwitchBackground()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;


# direct methods
.method public constructor <init>(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$3;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    .line 147
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$3;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    .line 150
    invoke-static {v0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$400(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$3;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    .line 151
    invoke-static {v1}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$100(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$3;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    invoke-static {v1}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$100(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$3;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v2, ""

    const/4 v3, 0x0

    .line 152
    :try_start_1
    invoke-static {v1, v3}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$500(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;Ljava/lang/Long;)Ljava/util/Map;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$600(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;Ljava/lang/Object;Ljava/util/Map;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 153
    invoke-static {}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$700()Ljava/lang/String;

    move-result-object v1

    const-string v2, "resend _send1010Hit success"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$3;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    .line 155
    invoke-static {v1}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$800(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)V

    goto :goto_0

    .line 157
    :cond_0
    invoke-static {}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$700()Ljava/lang/String;

    move-result-object v1

    const-string v2, "resend _send1010Hit failed"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 160
    :cond_1
    :goto_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method
