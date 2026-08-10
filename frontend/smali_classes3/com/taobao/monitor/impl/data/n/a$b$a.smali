.class Lcom/taobao/monitor/impl/data/n/a$b$a;
.super Ljava/lang/Object;
.source "FragmentDataCollector.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/data/n/a$b;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/data/n/a$b;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/data/n/a$b;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/n/a$b$a;->a:Lcom/taobao/monitor/impl/data/n/a$b;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$b$a;->a:Lcom/taobao/monitor/impl/data/n/a$b;

    .line 1
    iget-object v0, v0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/taobao/monitor/impl/data/n/a;->b(Lcom/taobao/monitor/impl/data/n/a;Ljava/lang/Runnable;)Ljava/lang/Runnable;

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$b$a;->a:Lcom/taobao/monitor/impl/data/n/a$b;

    .line 3
    iget-object v0, v0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;)J

    move-result-wide v0

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$b$a;->a:Lcom/taobao/monitor/impl/data/n/a$b;

    iget-object v0, v0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->c(Lcom/taobao/monitor/impl/data/n/a;)J

    move-result-wide v0

    cmp-long v0, v0, v2

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$b$a;->a:Lcom/taobao/monitor/impl/data/n/a$b;

    .line 4
    iget-object v0, v0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    iget-object v3, p0, Lcom/taobao/monitor/impl/data/n/a$b$a;->a:Lcom/taobao/monitor/impl/data/n/a$b;

    iget-object v3, v3, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v3}, Lcom/taobao/monitor/impl/data/n/a;->a(Lcom/taobao/monitor/impl/data/n/a;)J

    move-result-wide v3

    sub-long/2addr v1, v3

    invoke-static {v0, v1, v2}, Lcom/taobao/monitor/impl/data/n/a;->b(Lcom/taobao/monitor/impl/data/n/a;J)J

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/n/a$b$a;->a:Lcom/taobao/monitor/impl/data/n/a$b;

    .line 5
    iget-object v0, v0, Lcom/taobao/monitor/impl/data/n/a$b;->a:Lcom/taobao/monitor/impl/data/n/a;

    invoke-static {v0}, Lcom/taobao/monitor/impl/data/n/a;->c(Lcom/taobao/monitor/impl/data/n/a;)J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "sniffer"

    const-string v2, "stayStartedStateDuration"

    filled-new-array {v1, v2, v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "FragmentDataCollector"

    invoke-static {v1, v0}, Lcom/taobao/monitor/impl/logger/Logger;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    return-void
.end method
