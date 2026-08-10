.class Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;
.super Ljava/lang/Object;
.source "SimpleApmInitiator.java"

# interfaces
.implements Lcom/ali/ha/datahub/BizSubscriber;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/SimpleApmInitiator;->initDataHub()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/adapter/SimpleApmInitiator;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            "this$0"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;->this$0:Lcom/taobao/monitor/adapter/SimpleApmInitiator;

    .line 115
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private async(Ljava/lang/Runnable;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "runnable"
        }
    .end annotation

    .line 190
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method


# virtual methods
.method public onBizDataReadyStage()V
    .locals 4

    .line 183
    invoke-static {}, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper;->getCurrentProcedures()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v1, "onBizDataReadyTime"

    .line 185
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public onStage(Ljava/lang/String;Ljava/lang/String;J)V
    .locals 6
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x10,
            0x10
        }
        names = {
            "bizID",
            "stageName",
            "timeStamp"
        }
    .end annotation

    .line 150
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v3

    .line 151
    new-instance p3, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$3;

    move-object v0, p3

    move-object v1, p0

    move-object v2, p2

    move-object v5, p1

    invoke-direct/range {v0 .. v5}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$3;-><init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;Ljava/lang/String;JLjava/lang/String;)V

    invoke-direct {p0, p3}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;->async(Ljava/lang/Runnable;)V

    return-void
.end method

.method public pub(Ljava/lang/String;Ljava/util/HashMap;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x10
        }
        names = {
            "bizID",
            "hashMap"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const-string v0, "splash"

    .line 118
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    .line 119
    sput-boolean v0, Lcom/taobao/monitor/impl/data/GlobalStats;->hasSplash:Z

    .line 122
    :cond_0
    new-instance v0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$1;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$1;-><init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;Ljava/lang/String;Ljava/util/HashMap;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;->async(Ljava/lang/Runnable;)V

    return-void
.end method

.method public pubAB(Ljava/lang/String;Ljava/util/HashMap;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x10
        }
        names = {
            "bizID",
            "hashMap"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 136
    new-instance v0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$2;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$2;-><init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;Ljava/lang/String;Ljava/util/HashMap;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;->async(Ljava/lang/Runnable;)V

    return-void
.end method

.method public setMainBiz(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x10
        }
        names = {
            "bizID",
            "bizCode"
        }
    .end annotation

    .line 167
    new-instance v0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$4;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$4;-><init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;Ljava/lang/String;Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;->async(Ljava/lang/Runnable;)V

    return-void
.end method
