.class Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$3;
.super Ljava/lang/Object;
.source "SimpleApmInitiator.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;->onStage(Ljava/lang/String;Ljava/lang/String;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;

.field final synthetic val$bizID:Ljava/lang/String;

.field final synthetic val$currentTimeMillis:J

.field final synthetic val$stageName:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;Ljava/lang/String;JLjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010,
            0x1010,
            0x1010
        }
        names = {
            "this$1",
            "val$stageName",
            "val$currentTimeMillis",
            "val$bizID"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$3;->this$1:Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;

    iput-object p2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$3;->val$stageName:Ljava/lang/String;

    iput-wide p3, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$3;->val$currentTimeMillis:J

    iput-object p5, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$3;->val$bizID:Ljava/lang/String;

    .line 151
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .line 154
    invoke-static {}, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper;->getCurrentProcedures()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 156
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iget-object v2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$3;->val$stageName:Ljava/lang/String;

    iget-wide v3, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$3;->val$currentTimeMillis:J

    .line 157
    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    invoke-virtual {v1, v2, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$3;->val$bizID:Ljava/lang/String;

    .line 158
    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addBizStage(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method
