.class public abstract Lcom/taobao/monitor/impl/processor/a;
.super Ljava/lang/Object;
.source "AbsProcessor.java"

# interfaces
.implements Lcom/taobao/monitor/impl/processor/IProcessor;


# instance fields
.field private a:Lcom/taobao/monitor/impl/common/a;

.field private a:Lcom/taobao/monitor/impl/processor/IProcessor$a;

.field private volatile a:Z


# direct methods
.method protected constructor <init>(Z)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/common/a;->a()Lcom/taobao/monitor/impl/common/a;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/a;->a:Lcom/taobao/monitor/impl/common/a;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/a;->a:Z

    return-void
.end method


# virtual methods
.method protected a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;
    .locals 0

    .line 1
    invoke-static {p1}, Lcom/taobao/monitor/impl/common/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object p1

    return-object p1
.end method

.method public a(Lcom/taobao/monitor/impl/processor/IProcessor$a;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/a;->a:Lcom/taobao/monitor/impl/processor/IProcessor$a;

    return-void
.end method

.method protected b()V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/a;->a:Lcom/taobao/monitor/impl/processor/IProcessor$a;

    if-eqz v0, :cond_0

    .line 2
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/processor/IProcessor$a;->a(Lcom/taobao/monitor/impl/processor/IProcessor;)V

    :cond_0
    return-void
.end method

.method protected c()V
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/a;->a:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/a;->a:Z

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/a;->a:Lcom/taobao/monitor/impl/processor/IProcessor$a;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/processor/IProcessor$a;->b(Lcom/taobao/monitor/impl/processor/IProcessor;)V

    :cond_0
    return-void
.end method
