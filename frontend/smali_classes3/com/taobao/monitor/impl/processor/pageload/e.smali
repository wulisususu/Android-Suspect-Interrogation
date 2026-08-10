.class public Lcom/taobao/monitor/impl/processor/pageload/e;
.super Ljava/lang/Object;
.source "PageModelLifecycle.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/c$s;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/processor/pageload/e$b;,
        Lcom/taobao/monitor/impl/processor/pageload/e$a;
    }
.end annotation


# instance fields
.field private a:I

.field private a:Landroid/app/Activity;

.field private final a:Lcom/taobao/monitor/impl/processor/IProcessorFactory;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/taobao/monitor/impl/processor/IProcessorFactory<",
            "Lcom/taobao/monitor/impl/processor/pageload/c;",
            ">;"
        }
    .end annotation
.end field

.field private a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroid/app/Activity;",
            "Lcom/taobao/monitor/impl/processor/pageload/e$a;",
            ">;"
        }
    .end annotation
.end field

.field private final b:Lcom/taobao/monitor/impl/processor/IProcessorFactory;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/taobao/monitor/impl/processor/IProcessorFactory<",
            "Lcom/taobao/monitor/impl/processor/pageload/a;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroid/app/Activity;",
            "Lcom/taobao/monitor/impl/processor/pageload/e$b;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 5
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->b:Ljava/util/Map;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Landroid/app/Activity;

    const/4 v0, 0x0

    iput v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:I

    .line 11
    new-instance v0, Lcom/taobao/monitor/impl/processor/pageload/d;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/processor/pageload/d;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    .line 13
    new-instance v0, Lcom/taobao/monitor/impl/processor/pageload/b;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/processor/pageload/b;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->b:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    return-void
.end method


# virtual methods
.method public a(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 4
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 6
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->a(Landroid/app/Activity;J)V

    :cond_0
    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 9
    invoke-interface {p2, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Landroid/app/Activity;

    if-ne p1, p2, :cond_1

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Landroid/app/Activity;

    :cond_1
    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->a(Landroid/app/Activity;Landroid/os/Bundle;J)V

    :cond_0
    return-void
.end method

.method public b(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 12
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 14
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->b(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public b(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->b(Landroid/app/Activity;Landroid/os/Bundle;J)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    .line 5
    invoke-interface {v0}, Lcom/taobao/monitor/impl/processor/IProcessorFactory;->createProcessor()Lcom/taobao/monitor/impl/processor/IProcessor;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 7
    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 8
    invoke-interface {v0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->b(Landroid/app/Activity;Landroid/os/Bundle;J)V

    :cond_1
    :goto_0
    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Landroid/app/Activity;

    return-void
.end method

.method public c(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 5
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 7
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->c(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public c(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    .line 1
    invoke-interface {v0}, Lcom/taobao/monitor/impl/processor/IProcessorFactory;->createProcessor()Lcom/taobao/monitor/impl/processor/IProcessor;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/c;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 3
    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 4
    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/pageload/c;->c(Landroid/app/Activity;Landroid/os/Bundle;J)V

    :cond_0
    return-void
.end method

.method public d(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->d(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public e(Landroid/app/Activity;J)V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:I

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->e(Landroid/app/Activity;J)V

    :cond_0
    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->b:Ljava/util/Map;

    .line 7
    invoke-interface {p2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/taobao/monitor/impl/processor/pageload/e$b;

    if-eqz p2, :cond_1

    .line 9
    invoke-interface {p2, p1}, Lcom/taobao/monitor/impl/processor/pageload/e$b;->onActivityStopped(Landroid/app/Activity;)V

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->b:Ljava/util/Map;

    .line 10
    invoke-interface {p2, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    iget p1, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:I

    if-nez p1, :cond_2

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Landroid/app/Activity;

    :cond_2
    return-void
.end method

.method public f(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->f(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public g(Landroid/app/Activity;J)V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:I

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 3
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 5
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->g(Landroid/app/Activity;J)V

    :cond_0
    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Landroid/app/Activity;

    if-eq p2, p1, :cond_1

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->b:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    .line 10
    invoke-interface {p2}, Lcom/taobao/monitor/impl/processor/IProcessorFactory;->createProcessor()Lcom/taobao/monitor/impl/processor/IProcessor;

    move-result-object p2

    check-cast p2, Lcom/taobao/monitor/impl/processor/pageload/e$b;

    if-eqz p2, :cond_1

    .line 12
    invoke-interface {p2, p1}, Lcom/taobao/monitor/impl/processor/pageload/e$b;->onActivityStarted(Landroid/app/Activity;)V

    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->b:Ljava/util/Map;

    .line 13
    invoke-interface {p3, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Landroid/app/Activity;

    return-void
.end method

.method public h(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->h(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public i(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->i(Landroid/app/Activity;J)V

    .line 6
    :cond_0
    sget-boolean p2, Lcom/taobao/monitor/impl/data/m/b;->a:Z

    if-nez p2, :cond_1

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 7
    invoke-interface {p2, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Landroid/app/Activity;

    if-ne p1, p2, :cond_1

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Landroid/app/Activity;

    :cond_1
    return-void
.end method

.method public j(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->j(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public k(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->k(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public l(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->l(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public m(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->m(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public n(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->n(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method

.method public o(Landroid/app/Activity;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/e;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/pageload/e$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/e$a;->o(Landroid/app/Activity;J)V

    :cond_0
    return-void
.end method
