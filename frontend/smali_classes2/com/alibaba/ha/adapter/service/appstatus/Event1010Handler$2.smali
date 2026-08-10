.class public Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$2;
.super Ljava/lang/Object;
.source "Event1010Handler.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->_send1010Hit()V
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

    iput-object p1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$2;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    .line 63
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$2;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    .line 66
    invoke-static {v0}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$400(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    .line 67
    :try_start_0
    new-instance v1, Ljava/util/Date;

    invoke-direct {v1}, Ljava/util/Date;-><init>()V

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v1

    iget-object v3, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$2;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v4, ""

    .line 69
    :try_start_1
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    invoke-static {v3, v5}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$500(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;Ljava/lang/Long;)Ljava/util/Map;

    move-result-object v5

    invoke-static {v3, v4, v5}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$600(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;Ljava/lang/Object;Ljava/util/Map;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 70
    invoke-static {}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$700()Ljava/lang/String;

    move-result-object v1

    const-string v2, "_send1010Hit success"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    iget-object v1, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$2;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    .line 72
    invoke-static {v1}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$800(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;)V

    goto :goto_0

    :cond_0
    iget-object v3, p0, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler$2;->this$0:Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;

    .line 74
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    invoke-static {v3, v1}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$900(Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;Ljava/lang/Long;)V

    .line 75
    invoke-static {}, Lcom/alibaba/ha/adapter/service/appstatus/Event1010Handler;->access$700()Ljava/lang/String;

    move-result-object v1

    const-string v2, "_send1010Hit failed"

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 77
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
