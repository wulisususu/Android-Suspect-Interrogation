.class Lcom/taobao/accs/net/y;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lcom/taobao/accs/net/w;


# direct methods
.method constructor <init>(Lcom/taobao/accs/net/w;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/net/y;->a:Lcom/taobao/accs/net/w;

    .line 225
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/net/y;->a:Lcom/taobao/accs/net/w;

    .line 228
    invoke-virtual {v0}, Lcom/taobao/accs/net/w;->q()V

    iget-object v0, p0, Lcom/taobao/accs/net/y;->a:Lcom/taobao/accs/net/w;

    .line 229
    invoke-static {v0}, Lcom/taobao/accs/net/w;->c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/net/y;->a:Lcom/taobao/accs/net/w;

    .line 230
    invoke-static {v0}, Lcom/taobao/accs/net/w;->c(Lcom/taobao/accs/net/w;)Lcom/taobao/accs/ut/monitor/SessionMonitor;

    move-result-object v0

    const-string v1, "shut down"

    invoke-virtual {v0, v1}, Lcom/taobao/accs/ut/monitor/SessionMonitor;->setCloseReason(Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/net/y;->a:Lcom/taobao/accs/net/w;

    .line 232
    invoke-static {v0}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v0

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/taobao/accs/net/y;->a:Lcom/taobao/accs/net/w;

    .line 234
    invoke-static {v1}, Lcom/taobao/accs/net/w;->a(Lcom/taobao/accs/net/w;)Ljava/util/LinkedList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    goto :goto_1

    .line 237
    :catch_0
    :goto_0
    :try_start_1
    monitor-exit v0

    return-void

    :goto_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method
