.class Lcom/taobao/monitor/procedure/ProcedureProxy$6;
.super Ljava/lang/Object;
.source "ProcedureProxy.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/procedure/ProcedureProxy;->addBizStage(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/procedure/ProcedureProxy;

.field final synthetic val$bizID:Ljava/lang/String;

.field final synthetic val$stage:Ljava/util/Map;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/procedure/ProcedureProxy;Ljava/lang/String;Ljava/util/Map;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010,
            0x1010
        }
        names = {
            "this$0",
            "val$bizID",
            "val$stage"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$6;->this$0:Lcom/taobao/monitor/procedure/ProcedureProxy;

    iput-object p2, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$6;->val$bizID:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$6;->val$stage:Ljava/util/Map;

    .line 88
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$6;->this$0:Lcom/taobao/monitor/procedure/ProcedureProxy;

    .line 91
    invoke-static {v0}, Lcom/taobao/monitor/procedure/ProcedureProxy;->access$000(Lcom/taobao/monitor/procedure/ProcedureProxy;)Lcom/taobao/monitor/procedure/ProcedureImpl;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$6;->val$bizID:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$6;->val$stage:Ljava/util/Map;

    invoke-virtual {v0, v1, v2}, Lcom/taobao/monitor/procedure/ProcedureImpl;->addBizStage(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method
