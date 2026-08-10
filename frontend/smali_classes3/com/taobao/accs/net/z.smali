.class Lcom/taobao/accs/net/z;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lcom/taobao/accs/net/w;


# direct methods
.method constructor <init>(Lcom/taobao/accs/net/w;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/net/z;->b:Lcom/taobao/accs/net/w;

    iput-object p2, p0, Lcom/taobao/accs/net/z;->a:Ljava/lang/String;

    .line 544
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/net/z;->a:Ljava/lang/String;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/taobao/accs/net/z;->b:Lcom/taobao/accs/net/w;

    .line 548
    invoke-static {v1}, Lcom/taobao/accs/net/w;->d(Lcom/taobao/accs/net/w;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/net/z;->b:Lcom/taobao/accs/net/w;

    .line 549
    invoke-static {v0}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;)I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/net/z;->b:Lcom/taobao/accs/net/w;

    const/4 v1, 0x0

    .line 550
    invoke-static {v0, v1}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;Z)Z

    iget-object v0, p0, Lcom/taobao/accs/net/z;->b:Lcom/taobao/accs/net/w;

    const/4 v1, 0x1

    .line 551
    invoke-static {v0, v1}, Lcom/taobao/accs/net/w;->b(Lcom/taobao/accs/net/w;Z)Z

    iget-object v0, p0, Lcom/taobao/accs/net/z;->b:Lcom/taobao/accs/net/w;

    .line 552
    invoke-virtual {v0}, Lcom/taobao/accs/net/w;->q()V

    iget-object v0, p0, Lcom/taobao/accs/net/z;->b:Lcom/taobao/accs/net/w;

    .line 553
    invoke-static {v0}, Lcom/taobao/accs/net/w;->c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;

    move-result-object v0

    const-string v1, "conn timeout"

    invoke-virtual {v0, v1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setCloseReason(Ljava/lang/String;)V

    :cond_0
    return-void
.end method
