.class public Lcom/taobao/monitor/impl/processor/fragmentload/a;
.super Ljava/lang/Object;
.source "FragmentModelLifecycle.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/l$o;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/processor/fragmentload/a$b;,
        Lcom/taobao/monitor/impl/processor/fragmentload/a$a;
    }
.end annotation


# instance fields
.field private a:I

.field private a:Landroidx/fragment/app/Fragment;

.field private final a:Lcom/taobao/monitor/impl/processor/IProcessorFactory;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/taobao/monitor/impl/processor/IProcessorFactory<",
            "Lcom/taobao/monitor/impl/processor/fragmentload/d;",
            ">;"
        }
    .end annotation
.end field

.field private a:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroidx/fragment/app/Fragment;",
            "Lcom/taobao/monitor/impl/processor/fragmentload/a$a;",
            ">;"
        }
    .end annotation
.end field

.field private final b:Lcom/taobao/monitor/impl/processor/IProcessorFactory;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/taobao/monitor/impl/processor/IProcessorFactory<",
            "Lcom/taobao/monitor/impl/processor/fragmentload/b;",
            ">;"
        }
    .end annotation
.end field

.field private b:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroidx/fragment/app/Fragment;",
            "Lcom/taobao/monitor/impl/processor/fragmentload/a$b;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 2
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 3
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->b:Ljava/util/Map;

    const/4 v0, 0x0

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:I

    .line 9
    new-instance v0, Lcom/taobao/monitor/impl/processor/fragmentload/e;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/processor/fragmentload/e;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    .line 11
    new-instance v0, Lcom/taobao/monitor/impl/processor/fragmentload/c;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/processor/fragmentload/c;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->b:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    return-void
.end method


# virtual methods
.method public a(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->a(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public b(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->b(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public c(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:I

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->c(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->b:Ljava/util/Map;

    .line 7
    invoke-interface {p2, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/taobao/monitor/impl/processor/fragmentload/a$b;

    if-eqz p2, :cond_1

    .line 9
    invoke-interface {p2, p1}, Lcom/taobao/monitor/impl/processor/fragmentload/a$b;->a(Landroidx/fragment/app/Fragment;)V

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->b:Ljava/util/Map;

    .line 10
    invoke-interface {p2, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    iget p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:I

    if-nez p1, :cond_2

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Landroidx/fragment/app/Fragment;

    :cond_2
    return-void
.end method

.method public d(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->d(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public e(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->e(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public f(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:I

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 2
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 4
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->f(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Landroidx/fragment/app/Fragment;

    if-eq p2, p1, :cond_1

    .line 10
    sget-object p2, Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;->INSTANCE:Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;

    invoke-virtual {p2, p1}, Lcom/taobao/monitor/impl/processor/fragmentload/FragmentInterceptorProxy;->needPopFragment(Landroidx/fragment/app/Fragment;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->b:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    .line 11
    invoke-interface {p2}, Lcom/taobao/monitor/impl/processor/IProcessorFactory;->createProcessor()Lcom/taobao/monitor/impl/processor/IProcessor;

    move-result-object p2

    check-cast p2, Lcom/taobao/monitor/impl/processor/fragmentload/a$b;

    if-eqz p2, :cond_1

    .line 13
    invoke-interface {p2, p1}, Lcom/taobao/monitor/impl/processor/fragmentload/a$b;->b(Landroidx/fragment/app/Fragment;)V

    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->b:Ljava/util/Map;

    .line 14
    invoke-interface {p3, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Landroidx/fragment/app/Fragment;

    return-void
.end method

.method public g(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->g(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public h(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->h(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 5
    invoke-interface {p2, p1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public i(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->i(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public j(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->j(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public k(Landroidx/fragment/app/Fragment;J)V
    .locals 2

    .line 1
    sget-object v0, Lcom/taobao/monitor/impl/data/GlobalStats;->activityStatusManager:Lcom/taobao/monitor/impl/data/GlobalStats$a;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/data/GlobalStats$a;->a(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Lcom/taobao/monitor/impl/processor/IProcessorFactory;

    .line 2
    invoke-interface {v0}, Lcom/taobao/monitor/impl/processor/IProcessorFactory;->createProcessor()Lcom/taobao/monitor/impl/processor/IProcessor;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 4
    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 5
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->k(Landroidx/fragment/app/Fragment;J)V

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Landroidx/fragment/app/Fragment;

    :cond_0
    return-void
.end method

.method public l(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->l(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public m(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->m(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method

.method public n(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/a;->a:Ljava/util/Map;

    .line 1
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;

    if-eqz v0, :cond_0

    .line 3
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/impl/processor/fragmentload/a$a;->n(Landroidx/fragment/app/Fragment;J)V

    :cond_0
    return-void
.end method
