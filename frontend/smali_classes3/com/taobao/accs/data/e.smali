.class Lcom/taobao/accs/data/e;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;

.field final synthetic b:Lcom/taobao/accs/data/d;


# direct methods
.method constructor <init>(Lcom/taobao/accs/data/d;Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/data/e;->b:Lcom/taobao/accs/data/d;

    iput-object p2, p0, Lcom/taobao/accs/data/e;->a:Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;

    .line 1052
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/data/e;->b:Lcom/taobao/accs/data/d;

    .line 1055
    iget-object v0, v0, Lcom/taobao/accs/data/d;->c:Lcom/taobao/accs/ut/monitor/TrafficsMonitor;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/data/e;->b:Lcom/taobao/accs/data/d;

    .line 1056
    iget-object v0, v0, Lcom/taobao/accs/data/d;->c:Lcom/taobao/accs/ut/monitor/TrafficsMonitor;

    iget-object v1, p0, Lcom/taobao/accs/data/e;->a:Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;

    invoke-virtual {v0, v1}, Lcom/taobao/accs/ut/monitor/TrafficsMonitor;->a(Lcom/taobao/accs/ut/monitor/TrafficsMonitor$a;)V

    :cond_0
    return-void
.end method
