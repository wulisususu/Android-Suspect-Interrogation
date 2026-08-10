.class Lcom/taobao/monitor/network/ProcedureLifecycleImpl$1;
.super Ljava/lang/Object;
.source "ProcedureLifecycleImpl.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->end(Lcom/taobao/monitor/procedure/Value;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/taobao/monitor/network/ProcedureLifecycleImpl;

.field final synthetic val$value:Lcom/taobao/monitor/procedure/Value;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/network/ProcedureLifecycleImpl;Lcom/taobao/monitor/procedure/Value;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010,
            0x1010
        }
        names = {
            "this$0",
            "val$value"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/network/ProcedureLifecycleImpl$1;->this$0:Lcom/taobao/monitor/network/ProcedureLifecycleImpl;

    iput-object p2, p0, Lcom/taobao/monitor/network/ProcedureLifecycleImpl$1;->val$value:Lcom/taobao/monitor/procedure/Value;

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/network/ProcedureLifecycleImpl$1;->this$0:Lcom/taobao/monitor/network/ProcedureLifecycleImpl;

    iget-object v1, p0, Lcom/taobao/monitor/network/ProcedureLifecycleImpl$1;->val$value:Lcom/taobao/monitor/procedure/Value;

    .line 47
    invoke-static {v0, v1}, Lcom/taobao/monitor/network/ProcedureLifecycleImpl;->access$000(Lcom/taobao/monitor/network/ProcedureLifecycleImpl;Lcom/taobao/monitor/procedure/Value;)V

    return-void
.end method
