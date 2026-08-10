.class Lcom/taobao/accs/data/f;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lcom/taobao/accs/data/d;


# direct methods
.method constructor <init>(Lcom/taobao/accs/data/d;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/data/f;->a:Lcom/taobao/accs/data/d;

    .line 1066
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/data/f;->a:Lcom/taobao/accs/data/d;

    .line 1069
    iget-object v0, v0, Lcom/taobao/accs/data/d;->c:Lcom/taobao/accs/ut/monitor/TrafficsMonitor;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/data/f;->a:Lcom/taobao/accs/data/d;

    .line 1070
    iget-object v0, v0, Lcom/taobao/accs/data/d;->c:Lcom/taobao/accs/ut/monitor/TrafficsMonitor;

    invoke-virtual {v0}, Lcom/taobao/accs/ut/monitor/TrafficsMonitor;->a()V

    :cond_0
    return-void
.end method
