.class Lcom/taobao/monitor/impl/data/j$a;
.super Ljava/lang/Object;
.source "SimplePageLoadCalculate.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/data/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/data/j;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/data/j;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/j$a;->a:Lcom/taobao/monitor/impl/data/j;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j$a;->a:Lcom/taobao/monitor/impl/data/j;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/j;->a(Lcom/taobao/monitor/impl/data/j;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j$a;->a:Lcom/taobao/monitor/impl/data/j;

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/j;->a(Lcom/taobao/monitor/impl/data/j;)Lcom/taobao/monitor/impl/data/j$e;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/j$a;->a:Lcom/taobao/monitor/impl/data/j;

    invoke-static {v1}, Lcom/taobao/monitor/impl/data/j;->a(Lcom/taobao/monitor/impl/data/j;)J

    move-result-wide v1

    invoke-interface {v0, v1, v2}, Lcom/taobao/monitor/impl/data/j$e;->a(J)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j$a;->a:Lcom/taobao/monitor/impl/data/j;

    .line 3
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/j;->b(Lcom/taobao/monitor/impl/data/j;)J

    move-result-wide v0

    iget-object v2, p0, Lcom/taobao/monitor/impl/data/j$a;->a:Lcom/taobao/monitor/impl/data/j;

    invoke-static {v2}, Lcom/taobao/monitor/impl/data/j;->a(Lcom/taobao/monitor/impl/data/j;)J

    move-result-wide v2

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j$a;->a:Lcom/taobao/monitor/impl/data/j;

    .line 4
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/j;->a(Lcom/taobao/monitor/impl/data/j;)Lcom/taobao/monitor/impl/data/j$e;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/data/j$a;->a:Lcom/taobao/monitor/impl/data/j;

    invoke-static {v1}, Lcom/taobao/monitor/impl/data/j;->b(Lcom/taobao/monitor/impl/data/j;)J

    move-result-wide v1

    const/4 v3, 0x2

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/impl/data/j$e;->a(IJ)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/j$a;->a:Lcom/taobao/monitor/impl/data/j;

    .line 5
    invoke-virtual {v0}, Lcom/taobao/monitor/impl/data/j;->a()V

    :cond_0
    return-void
.end method
