.class Lcom/taobao/monitor/procedure/ProcedureImpl$1;
.super Ljava/lang/Object;
.source "ProcedureImpl.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/procedure/ProcedureImpl;->end(Z)Lcom/taobao/monitor/procedure/IProcedure;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/procedure/ProcedureImpl;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/procedure/ProcedureImpl;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            "this$0"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl$1;->this$0:Lcom/taobao/monitor/procedure/ProcedureImpl;

    .line 199
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureImpl$1;->this$0:Lcom/taobao/monitor/procedure/ProcedureImpl;

    .line 202
    invoke-static {v0}, Lcom/taobao/monitor/procedure/ProcedureImpl;->access$000(Lcom/taobao/monitor/procedure/ProcedureImpl;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/procedure/IProcedureGroup;

    iget-object v1, p0, Lcom/taobao/monitor/procedure/ProcedureImpl$1;->this$0:Lcom/taobao/monitor/procedure/ProcedureImpl;

    invoke-interface {v0, v1}, Lcom/taobao/monitor/procedure/IProcedureGroup;->removeSubProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    return-void
.end method
