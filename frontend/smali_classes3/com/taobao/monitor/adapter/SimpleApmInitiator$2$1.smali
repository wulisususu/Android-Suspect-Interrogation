.class Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$1;
.super Ljava/lang/Object;
.source "SimpleApmInitiator.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;->pub(Ljava/lang/String;Ljava/util/HashMap;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;

.field final synthetic val$bizID:Ljava/lang/String;

.field final synthetic val$hashMap:Ljava/util/HashMap;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;Ljava/lang/String;Ljava/util/HashMap;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010,
            0x1010
        }
        names = {
            "this$1",
            "val$bizID",
            "val$hashMap"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$1;->this$1:Lcom/taobao/monitor/adapter/SimpleApmInitiator$2;

    iput-object p2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$1;->val$bizID:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$1;->val$hashMap:Ljava/util/HashMap;

    .line 122
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 125
    invoke-static {}, Lcom/taobao/monitor/adapter/DataHubProcedureGroupHelper;->getCurrentProcedures()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$1;->val$bizID:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/monitor/adapter/SimpleApmInitiator$2$1;->val$hashMap:Ljava/util/HashMap;

    .line 127
    invoke-interface {v0, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addBiz(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method
