.class public Lcom/taobao/monitor/impl/processor/launcher/a;
.super Ljava/lang/Object;
.source "LauncherModelLifeCycle.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/c$s;
.implements Lcom/taobao/monitor/impl/processor/IProcessor$a;


# instance fields
.field private a:I

.field private final a:Lcom/taobao/monitor/impl/processor/IProcessorFactory;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/taobao/monitor/impl/processor/IProcessorFactory<",
            "Lcom/taobao/monitor/impl/processor/launcher/b;",
            ">;"
        }
    .end annotation
.end field

.field private a:Lcom/taobao/monitor/impl/processor/launcher/b;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    const/4 v0, 0x0

    iput v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:I

    .line 6
    new-instance v0, Lcom/taobao/monitor/impl/processor/launcher/c;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/processor/launcher/c;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    return-void
.end method


# virtual methods
.method public a(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 4
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->a(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/launcher/b;->a(Landroid/app/Activity;Landroid/os/Bundle;J)V

    :cond_0
    return-void
.end method

.method public a(Lcom/taobao/monitor/impl/processor/IProcessor;)V
    .locals 0

    return-void
.end method

.method public b(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 16
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->b(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public b(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:I

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    .line 4
    invoke-interface {v0}, Lcom/taobao/monitor/impl/processor/IProcessorFactory;->createProcessor()Lcom/taobao/monitor/impl/processor/IProcessor;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/launcher/b;

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_1

    .line 8
    invoke-virtual {v0, p0}, Lcom/taobao/monitor/impl/processor/a;->a(Lcom/taobao/monitor/impl/processor/IProcessor$a;)V

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_2

    .line 12
    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/launcher/b;->b(Landroid/app/Activity;Landroid/os/Bundle;J)V

    :cond_2
    iget p1, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:I

    return-void
.end method

.method public b(Lcom/taobao/monitor/impl/processor/IProcessor;)V
    .locals 0

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    return-void
.end method

.method public c(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 8
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->c(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public c(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:I

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    .line 2
    invoke-interface {v0}, Lcom/taobao/monitor/impl/processor/IProcessorFactory;->createProcessor()Lcom/taobao/monitor/impl/processor/IProcessor;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/launcher/b;

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_1

    .line 6
    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/launcher/b;->c(Landroid/app/Activity;Landroid/os/Bundle;J)V

    :cond_1
    return-void
.end method

.method public d(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->d(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public e(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->e(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public f(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->f(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public g(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->g(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public h(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->h(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public i(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->i(Landroid/app/Activity;J)V

    :cond_0
    iget p1, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:I

    add-int/lit8 p1, p1, -0x1

    iput p1, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:I

    return-void
.end method

.method public j(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->j(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public k(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->k(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public l(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->l(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public m(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->m(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public n(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->n(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public o(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/a;->a:Lcom/taobao/monitor/impl/processor/launcher/b;

    if-eqz v0, :cond_0

    .line 2
    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/launcher/b;->o(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method
