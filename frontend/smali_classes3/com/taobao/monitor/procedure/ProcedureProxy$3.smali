.class Lcom/taobao/monitor/procedure/ProcedureProxy$3;
.super Ljava/lang/Object;
.source "ProcedureProxy.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/procedure/ProcedureProxy;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/procedure/ProcedureProxy;

.field final synthetic val$name:Ljava/lang/String;

.field final synthetic val$timestamp:J


# direct methods
.method constructor <init>(Lcom/taobao/monitor/procedure/ProcedureProxy;Ljava/lang/String;J)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010,
            0x1010
        }
        names = {
            "this$0",
            "val$name",
            "val$timestamp"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$3;->this$0:Lcom/taobao/monitor/procedure/ProcedureProxy;

    iput-object p2, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$3;->val$name:Ljava/lang/String;

    iput-wide p3, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$3;->val$timestamp:J

    .line 55
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$3;->this$0:Lcom/taobao/monitor/procedure/ProcedureProxy;

    .line 58
    invoke-static {v0}, Lcom/taobao/monitor/procedure/ProcedureProxy;->access$000(Lcom/taobao/monitor/procedure/ProcedureProxy;)Lcom/taobao/monitor/procedure/ProcedureImpl;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$3;->val$name:Ljava/lang/String;

    iget-wide v2, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$3;->val$timestamp:J

    invoke-virtual {v0, v1, v2, v3}, Lcom/taobao/monitor/procedure/ProcedureImpl;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method
