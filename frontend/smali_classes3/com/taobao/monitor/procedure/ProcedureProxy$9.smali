.class Lcom/taobao/monitor/procedure/ProcedureProxy$9;
.super Ljava/lang/Object;
.source "ProcedureProxy.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/procedure/ProcedureProxy;->end()Lcom/taobao/monitor/procedure/IProcedure;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/procedure/ProcedureProxy;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/procedure/ProcedureProxy;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            "this$0"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$9;->this$0:Lcom/taobao/monitor/procedure/ProcedureProxy;

    .line 127
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureProxy$9;->this$0:Lcom/taobao/monitor/procedure/ProcedureProxy;

    .line 130
    invoke-static {v0}, Lcom/taobao/monitor/procedure/ProcedureProxy;->access$000(Lcom/taobao/monitor/procedure/ProcedureProxy;)Lcom/taobao/monitor/procedure/ProcedureImpl;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->end()Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method
